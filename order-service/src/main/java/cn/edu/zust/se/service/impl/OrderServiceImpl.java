package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.dto.TendDto;
import cn.edu.zust.se.entity.po.Order;
import cn.edu.zust.se.entity.po.Message;
import cn.edu.zust.se.entity.po.OrderItem;
import cn.edu.zust.se.entity.query.OrderQuery;
import cn.edu.zust.se.entity.vo.OrderVo;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.ClientFeignServiceI;
import cn.edu.zust.se.feign.UserFeignServiceI;
import cn.edu.zust.se.feign.MessageFeignServiceI;
import cn.edu.zust.se.mapper.OrderItemMapper;
import cn.edu.zust.se.mapper.OrderMapper;
import cn.edu.zust.se.service.IOrderLogService;
import cn.edu.zust.se.service.IOrderService;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.*;

/**
 * @author anymore131
 * @since 2024-12-21
 */
@Service
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements IOrderService {
    private final static org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(OrderServiceImpl.class);

    @Autowired
    private UserFeignServiceI userFeignService;
    @Autowired
    private ClientFeignServiceI clientFeignService;
    @Autowired
    private OrderItemMapper orderItemMapper;
    @Autowired
    private IOrderLogService orderLogService;
    @Autowired
    private MessageFeignServiceI messageFeignService;

    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
    private static final Random random = new Random();

    @Override
    public OrderVo getOrderVoById(Integer id) {
        checkOrderId(id);
        Order order = getAndCheckOrderLive(id);
        return putOrderVo(order);
    }

    @Override
    public PageDto<OrderVo> pageOrders(OrderQuery orderQuery) {
        if (orderQuery == null){
            throw new InvalidInputException("查询条件不能为空！");
        }
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (orderQuery.getUserId() == null && !StpUtil.hasRole("admin")){
            throw new InvalidInputException("用户id不能为空！");
        }
        if (!StpUtil.hasRole("admin") && !orderQuery.getUserId().equals(currentUserId)){
            throw new InvalidInputException("无权查询订单！");
        }
        Page<Order> page = orderQuery.toMpPage(orderQuery.getSortBy(), orderQuery.isAsc());
        if (orderQuery.getCreateTime()!= null){
            log.info(orderQuery.getCreateTime().substring(0,19).replace('T', ' '));
            orderQuery.setCreateTime(orderQuery.getCreateTime().substring(0,19).replace('T', ' '));
        }
        if (orderQuery.getUpdateTime()!= null){
            log.info(orderQuery.getUpdateTime().substring(0,19).replace('T', ' '));
            orderQuery.setUpdateTime(orderQuery.getUpdateTime().substring(0,19).replace('T', ' '));
        }
        lambdaQuery()
                .eq(orderQuery.getOrderNo() != null, Order::getOrderNo, orderQuery.getOrderNo())
                .eq(orderQuery.getClientId() != null, Order::getClientId, orderQuery.getClientId())
//                .eq(orderQuery.getUserId() != null, Order::getUserId, orderQuery.getUserId())
                .eq(orderQuery.getStatus() != null, Order::getStatus, orderQuery.getStatus())
                .ge(orderQuery.getMinAmount() != null, Order::getTotalAmount, orderQuery.getMinAmount())
                .le(orderQuery.getMaxAmount() != null, Order::getTotalAmount, orderQuery.getMaxAmount())
                .ge(orderQuery.getCreateTime() != null, Order::getCreateTime, orderQuery.getCreateTime())
                .le(orderQuery.getUpdateTime() != null, Order::getUpdateTime, orderQuery.getUpdateTime())
                .page(page);
        PageDto<OrderVo> orderVos = new PageDto<>();
        orderVos.setTotal(page.getTotal());
        orderVos.setPages(page.getPages());
        List<Order> records = page.getRecords();
        if (CollUtil.isEmpty(records)){
            orderVos.setList(Collections.emptyList());
            return orderVos;
        }
        List<OrderVo> vos = new ArrayList<>();
        for (Order record : records){
            OrderVo orderVo = BeanUtil.copyProperties(record, OrderVo.class);
            orderVo.setUserName(userFeignService.getUserNameById(record.getUserId()));
            orderVo.setClientName(clientFeignService.getClientNameById(record.getClientId()));
            vos.add(orderVo);
        }
        orderVos.setList(vos);
        return orderVos;
    }

    // 起草
    @Override
    public Integer addOrder(Order order) {
        if (order == null){
            throw new InvalidInputException("订单不能为空！");
        }
        if (order.getClientId() == null){
            throw new InvalidInputException("客户不能为空！");
        }
        if (order.getUserId() == null){
            throw new InvalidInputException("用户不能为空！");
        }
        checkRole(order,"无权添加订单！");
        order.setOrderNo(generateOrderNo());
        order.setStatus("DRAFT");
        order.setTotalAmount(0);
        order.setCreateTime(LocalDateTime.now());
        order.setUpdateTime(LocalDateTime.now());
        order.setIsDelete(0);
        save(order);
        String s = clientFeignService.toCooperation(order.getClientId());
        if (s!=null){
            throw new InvalidInputException(s);
        }
        orderLogService.addLog(order.getId(), order.getUserId(), "CREATE", "创建订单");
        return order.getId();
    }

    @Override
    public Integer getOrderIdByOrderNo(String orderNo) {
        if (orderNo == null){
            throw new InvalidInputException("订单号不能为空！");
        }
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("order_no",orderNo);
        Order one = getOne(queryWrapper);
        return one.getId();
    }

    @Override
    public void refreshOrderAmount(Integer id) {
        Integer amount = 0;
        if (id == null){
            throw new InvalidInputException("订单id不能为空！");
        }
        Order order = getById(id);
        if (order == null){
            throw new InvalidInputException("订单不存在！");
        }
        List<OrderItem> orderItem = orderItemMapper.getByOrderId(id);
        if (!CollUtil.isEmpty(orderItem)){
            for (OrderItem o: orderItem){
                amount += o.getTotalPrice();
            }
        }
        order.setTotalAmount(amount);
        order.setUpdateTime(LocalDateTime.now());
        updateById(order);
    }

    // 失效
    @Override
    public Integer backDraft(Integer id) {
        checkOrderId(id);
        Order order = getAndCheckOrderLive(id);
        checkRole(order,"无权修改订单状态！");
        order.setStatus("DRAFT");
        return updateById(order)? id : null;
    }


    // 待检验
    @Override
    public Integer PendingOrder(Integer id) {
        checkOrderId(id);
        Order order = getAndCheckOrderLive(id);
        checkRole(order,"无权修改订单状态！");
        if (!Objects.equals(order.getStatus(), "DRAFT")&&!Objects.equals(order.getStatus(), "REJECTED")){
            throw new InvalidInputException("订单状态错误！");
        }
        order.setStatus("PENDING");
        orderLogService.addLog(id, StpUtil.getLoginIdAsInt(), "SUBMIT", "提交检验");
        return updateById(order)? id : null;
    }

    // 检验通过
    @Override
    public Integer ApproveOrder(Integer id) {
        System.out.println("\n========== 订单审批通过处理开始 ==========");
        System.out.println("接收到订单审批通过请求，订单ID: " + id);
        
        checkOrderId(id);
        Order order = getAndCheckOrderLive(id);
        System.out.println("获取到订单信息: " + order);
        
        if (!Objects.equals(order.getStatus(), "PENDING")){
            System.out.println("错误：订单状态错误，当前状态: " + order.getStatus());
            throw new InvalidInputException("订单状态错误！");
        }
        order.setStatus("APPROVED");
        System.out.println("订单状态已更新为: APPROVED");

        // 创建消息
        Message message = new Message();
        message.setContent("你的订单" + order.getOrderNo() + "检验通过");
        message.setSendTime(LocalDateTime.now());
        message.setUserId(order.getUserId());
        message.setType(0);
        
        System.out.println("准备创建消息:");
        System.out.println("- content: " + message.getContent());
        System.out.println("- userId: " + message.getUserId());
        System.out.println("- sendTime: " + message.getSendTime());
        System.out.println("- type: " + message.getType());
        
        try {
            System.out.println("开始调用消息服务...");
            SaResult result = messageFeignService.add(message);
            System.out.println("消息服务返回结果:");
            System.out.println("- code: " + result.getCode());
            System.out.println("- msg: " + result.getMsg());
            System.out.println("- data: " + result.getData());
        } catch (Exception e) {
            System.out.println("错误：创建消息失败");
            System.out.println("异常类型: " + e.getClass().getName());
            System.out.println("异常消息: " + e.getMessage());
            if (e.getCause() != null) {
                System.out.println("根本原因: " + e.getCause().getMessage());
            }
            e.printStackTrace();
        }

        boolean updated = updateById(order);
        System.out.println("订单更新结果: " + (updated ? "成功" : "失败"));
        System.out.println("========== 订单审批通过处理结束 ==========\n");
        return updated ? id : null;
    }

    // 未通过
    @Override
    public Integer RejectOrder(Integer id) {
        System.out.println("\n========== 订单驳回处理开始 ==========");
        System.out.println("接收到订单驳回请求，订单ID: " + id);
        
        checkOrderId(id);
        Order order = getAndCheckOrderLive(id);
        System.out.println("获取到订单信息: " + order);
        
        if (!Objects.equals(order.getStatus(), "PENDING")){
            System.out.println("错误：订单状态错误，当前状态: " + order.getStatus());
            throw new InvalidInputException("订单状态错误！");
        }
        order.setStatus("REJECTED");
        System.out.println("订单状态已更新为: REJECTED");

        // 创建消息
        Message message = new Message();
        message.setContent("你的订单" + order.getOrderNo() + "检验不通过");
        message.setSendTime(LocalDateTime.now());
        message.setUserId(order.getUserId());
        message.setType(0);
        
        System.out.println("准备创建消息:");
        System.out.println("- content: " + message.getContent());
        System.out.println("- userId: " + message.getUserId());
        System.out.println("- sendTime: " + message.getSendTime());
        System.out.println("- type: " + message.getType());
        
        try {
            System.out.println("开始调用消息服务...");
            SaResult result = messageFeignService.add(message);
            System.out.println("消息服务返回结果:");
            System.out.println("- code: " + result.getCode());
            System.out.println("- msg: " + result.getMsg());
            System.out.println("- data: " + result.getData());
        } catch (Exception e) {
            System.out.println("错误：创建消息失败");
            System.out.println("异常类型: " + e.getClass().getName());
            System.out.println("异常消息: " + e.getMessage());
            if (e.getCause() != null) {
                System.out.println("根本原因: " + e.getCause().getMessage());
            }
            e.printStackTrace();
        }

        boolean updated = updateById(order);
        System.out.println("订单更新结果: " + (updated ? "成功" : "失败"));
        System.out.println("========== 订单驳回处理结束 ==========\n");
        return updated ? id : null;
    }

    // 完成
    @Override
    public Integer CompleteOrder(Integer id) {
        checkOrderId(id);
        Order order = getAndCheckOrderLive(id);
        checkRole(order,"无权修改订单状态！");
        if (!Objects.equals(order.getStatus(), "APPROVED")){
            throw new InvalidInputException("订单状态错误！");
        }
        order.setStatus("COMPLETED");
        clientFeignService.updateClientSum(order.getClientId(), order.getTotalAmount());
        boolean b = updateById(order);
        Integer clientId = order.getClientId();
        List<Order> orders = lambdaQuery()
                .eq(Order::getClientId, clientId)
                .ne(Order::getStatus, "COMPLETED")
                .list();
        if (CollUtil.isEmpty(orders)){
            clientFeignService.toWaitting(clientId);
        }
        Thread thread = new Thread(() -> {
            clientFeignService.updateManual();
        });
        thread.start();
        return b? id : null;
    }

    @Override
    public Integer CancelledOrder(Integer id) {
        checkOrderId(id);
        Order order = getAndCheckOrderLive(id);
        checkRole(order,"无权修改订单状态！");
        order.setStatus("CANCELLED");

        return updateById(order)? id : null;
    }

    @Override
    public OrderVo getOrderVoByOrderNo(String orderNo) {
        if (orderNo == null){
            throw new InvalidInputException("订单号不能为空！");
        }
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("order_no",orderNo);
        Order order = getOne(queryWrapper);
        if (order == null){
            return null;
        }
        return putOrderVo(order);
    }

    @Override
    public Map<String,Long> getOrderStatusDistribution(Integer userId) {
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        Map<String,Long> map = new HashMap<>();
        if (userId == null && !StpUtil.hasRole("admin")){
            throw new InvalidInputException("无权查看！");
        }
        List<String> status = List.of(new String[]{"DRAFT", "PENDING", "APPROVED", "REJECTED", "COMPLETED", "CANCELLED"});
        for (String s: status){
            queryWrapper.clear();
            if (userId != null){
                queryWrapper.eq("user_id",userId);
            }
            queryWrapper.ge("create_time",LocalDateTime.now().minusDays(7));
            Long count = count(queryWrapper.eq("status", s));
            map.put(s, count);
        }
        return map;
    }

    @Override
    public List<TendDto> getTend(Integer userId) {
        if (userId == null && !StpUtil.hasRole("admin")){
            throw new InvalidInputException("无权查看！");
        }
        List<TendDto> tends = new ArrayList<>();
        for (int i = 0; i <= 7; i++){
            TendDto tend = new TendDto();
            tend.setDate(LocalDateTime.now().minusDays(i));
            tend.setNewCount(count(new QueryWrapper<Order>()
                    .eq("status", "DRAFT")
                    .eq(userId!=null,"user_id", userId)
                    .ge("create_time", tend.getDate().plusDays(1))));
            tend.setCompletedCount(count(new QueryWrapper<Order>()
                    .eq("status", "COMPLETED")
                    .eq(userId!=null,"user_id", userId)
                    .ge("create_time", tend.getDate().plusDays(1))));
            tends.add(tend);
        }
        return tends;
    }

    @Override
    public LocalDateTime getLastOrderTime(Integer clientId) {
        if (clientId == null){
            throw new InvalidInputException("客户id不能为空！");
        }
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper
                .eq("client_id", clientId)
                .orderByDesc("update_time")
                .eq("status", "COMPLETED");
        Order order = list(queryWrapper).get(0);
        if (order != null){
            return order.getCreateTime();
        }
        return null;
    }

    @Override
    public long getOrderFrequency(Integer clientId) {
        if (clientId == null){
            throw new InvalidInputException("客户id不能为空！");
        }
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper
                .eq("client_id",clientId)
                .ge("create_time", LocalDateTime.now().minusYears(1))
                .eq("status", "COMPLETED");
        return count(queryWrapper);
    }

    @Override
    public Integer getTotalAmount(Integer clientId) {
        if (clientId == null){
            throw new InvalidInputException("客户id不能为空！");
        }
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper
                .eq("client_id", clientId)
                .ge("create_time", LocalDateTime.now().minusYears(1))
                .eq("status", "COMPLETED");
        List<Order> orders = list(queryWrapper);
        if (CollUtil.isNotEmpty(orders)){
            return orders.stream().mapToInt(Order::getTotalAmount).sum();
        }
        return 0;
    }

    private OrderVo putOrderVo(Order order) {
        OrderVo orderVo = BeanUtil.copyProperties(order, OrderVo.class);
        String userName = userFeignService.getUserNameById(order.getUserId());
        if (userName == null){
            userName = userFeignService.getDeleteUserNameById(order.getUserId()).getUserName();
            orderVo.setUserId(null);
            orderVo.setUserName(userName);
        }else{
            orderVo.setUserName(userName);
        }
        String clientName = clientFeignService.getClientNameById(order.getClientId());
        orderVo.setClientName(clientName);
        return orderVo;
    }

    private void checkOrderId(Integer id){
        if (id == null){
            throw new InvalidInputException("订单id不能为空！");
        }
    }

    /**
     * 生成订单编号
     * @return 生成的订单编号
     */
    private String generateOrderNo() {
        String timestamp = dateFormat.format(new Date());
        int randomNumber = 1000 + random.nextInt(9000); // 生成4位随机数
        return timestamp + randomNumber;
    }

    private Order getAndCheckOrderLive(Integer id){
        Order order = getById(id);
        if (order == null){
            throw new InvalidInputException("订单不存在！");
        }
        return order;
    }

    private void checkRoleAdmin(Order order,String s){
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") || !currentUserId.equals(order.getUserId())){
            throw new InvalidInputException(s);
        }
    }

    private void checkRole(Order order,String s){
        if (order == null){
            throw new InvalidInputException("订单不存在！");
        }
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(order.getUserId())){
            throw new InvalidInputException(s);
        }
    }
}
