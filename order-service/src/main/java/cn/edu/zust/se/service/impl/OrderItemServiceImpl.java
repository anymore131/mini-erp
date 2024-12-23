package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Order;
import cn.edu.zust.se.entity.po.OrderItem;
import cn.edu.zust.se.entity.query.OrderItemQuery;
import cn.edu.zust.se.entity.vo.OrderItemVo;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.mapper.OrderItemMapper;
import cn.edu.zust.se.mapper.OrderMapper;
import cn.edu.zust.se.service.IOrderItemService;
import cn.edu.zust.se.service.IOrderService;
import cn.edu.zust.se.service.IOrderLogService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.hutool.core.bean.BeanUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @author anymore131
 * @since 2024-12-21
 */
@Service
public class OrderItemServiceImpl extends ServiceImpl<OrderItemMapper, OrderItem> implements IOrderItemService {
    private final static org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(OrderServiceImpl.class);

    @Autowired
    private IOrderService orderService;

    @Autowired
    private IOrderLogService orderLogService;

    @Override
    public OrderItemVo getOrderItemById(Integer id) {
        if (id == null){
            throw new InvalidInputException("输入信息为空！");
        }
        OrderItem orderItem = getById(id);
        if (orderItem == null){
            throw new InvalidInputException("该订单明细不存在！");
        }
        OrderItemVo orderItemVo = BeanUtil.copyProperties(orderItem, OrderItemVo.class);
        orderItemVo.setOrder(orderService.getOrderVoById(orderItem.getOrderId()));
        return orderItemVo;
    }

    @Override
    public PageDto<OrderItemVo> page(OrderItemQuery query) {
        Page<OrderItem> page = query.toMpPage(query.getSortBy(), query.isAsc());
        if (query.getOrderNo() != null){
            query.setOrderId(orderService.getOrderIdByOrderNo(query.getOrderNo()));
        }
        lambdaQuery()
                .eq(query.getOrderId() != null, OrderItem::getOrderId, query.getOrderId())
                .eq(query.getProductName() != null, OrderItem::getProductName, query.getProductName())
                .ge(query.getUnitPriceStart() != null, OrderItem::getUnitPrice, query.getUnitPriceStart())
                .le(query.getUnitPriceEnd() != null, OrderItem::getUnitPrice, query.getUnitPriceEnd())
                .ge(query.getTotalPriceStart() != null, OrderItem::getTotalPrice, query.getTotalPriceStart())
                .le(query.getTotalPriceEnd() != null, OrderItem::getTotalPrice, query.getTotalPriceEnd())
                .page(page);
        PageDto<OrderItemVo> orderItemVos = new PageDto<>();
        orderItemVos.setTotal(page.getTotal());
        orderItemVos.setPages(page.getPages());
        List<OrderItemVo> vos = new ArrayList<>();
        for (OrderItem record : page.getRecords()){
            OrderItemVo orderItemVo = BeanUtil.copyProperties(record, OrderItemVo.class);
            orderItemVo.setOrder(orderService.getOrderVoById(record.getOrderId()));
            vos.add(orderItemVo);
        }
        orderItemVos.setList(vos);
        return orderItemVos;
    }

    @Override
    public List<OrderItemVo> listByOrderId(Integer orderId) {
        if (orderId == null){
            throw new InvalidInputException("输入信息为空！");
        }
        log.info("根据订单id查询订单明细信息：{}", orderId);
        Order order = orderService.getById(orderId);
        if (order == null){
            throw new InvalidInputException("订单不存在！");
        }
        checkRole(order,"无权查看订单明细！");
        QueryWrapper<OrderItem> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("order_id", orderId);
        List<OrderItem> orderItems = list(queryWrapper);
        if (orderItems == null){
            return null;
        }
        return BeanUtil.copyToList(orderItems, OrderItemVo.class);
    }

    @Override
    public boolean addOrderItem(OrderItem item) {
        if (item == null){
            throw new InvalidInputException("输入为空！");
        }
        if (item.getProductName() == null || item.getProductName().isEmpty() || item.getOrderId() == null){
            throw new InvalidInputException("输入信息为空！");
        }
        log.info("添加订单明细信息：{}", item);
        Order order = orderService.getById(item.getOrderId());
        if (order == null){
            throw new InvalidInputException("订单不存在！");
        }
        checkRole(order,"无权添加订单明细！");
        if (!Objects.equals(order.getStatus(), "DRAFT")&&!Objects.equals(order.getStatus(), "REJECTED")){
            throw new InvalidInputException("只能再起草、未通过阶段添加！");
        }
        if (item.getUnitPrice() == null){
            item.setUnitPrice(0);
        }
        if (item.getQuantity() == null){
            item.setQuantity(0);
        }
        item.setTotalPrice(item.getUnitPrice()*item.getQuantity());
        item.setCreateTime(LocalDateTime.now()).setIsDelete(0);
        boolean save = save(item);
        orderService.refreshOrderAmount(order.getId());
        if (!save){
            throw new InvalidInputException("添加订单明细失败！");
        }
        orderLogService.addLog(item.getOrderId(), StpUtil.getLoginIdAsInt(), "ADD_ITEM", 
            String.format("添加订单明细：%s，数量：%d，单价：%.2f", item.getProductName(), item.getQuantity(), item.getUnitPrice()/100.0));
        return true;
    }

    @Override
    public boolean updateOrderItem(OrderItem item) {
        boolean b = false;
        if (item == null){
            throw new InvalidInputException("输入为空！");
        }
        log.info("修改订单明细信息：{}", item);
        if (item.getProductName() == null || item.getProductName().isEmpty()
                || item.getOrderId() == null || item.getId() == null){
            throw new InvalidInputException("输入信息为空！");
        }
        Order order = orderService.getById(item.getOrderId());
        if (order == null){
            throw new InvalidInputException("订单不存在！");
        }
        checkRole(order,"无权修改订单明细！");
        if (!Objects.equals(order.getStatus(), "DRAFT")){
            throw new InvalidInputException("只能再起草阶段添加！");
        }
        OrderItem orderItem = getById(item.getId());
        if (item.getUnitPrice() == null){
            item.setUnitPrice(0);
        }
        if (item.getQuantity() == null){
            item.setQuantity(0);
        }
        item.setTotalPrice(item.getUnitPrice()*item.getQuantity());
        if (orderItem == null){
            b = addOrderItem(item);
        }else{
            b = update(item, new UpdateWrapper<OrderItem>().eq("id", item.getId()));
            orderService.refreshOrderAmount(order.getId());
        }
        return b;
    }

    @Override
    public boolean removeOrderItemById(Integer id) {
        if (id == null){
            throw new InvalidInputException("输入为空！");
        }
        OrderItem orderItem = getById(id);
        if (orderItem == null){
            throw new InvalidInputException("订单明细不存在！");
        }
        Order order = orderService.getById(orderItem.getOrderId());
        if (order == null){
            removeById(id);
            throw new InvalidInputException("订单不存在！");
        }
        checkRole(order,"无权删除订单明细！");
        if (!Objects.equals(order.getStatus(), "DRAFT")){
            throw new InvalidInputException("只能再起草阶段添加！");
        }
        if (!removeById(id)){
            throw new InvalidInputException("删除订单明细失败！");
        }
        orderService.refreshOrderAmount(order.getId());
        return true;
    }

    @Override
    public boolean removeOrderItemByOrderId(Integer orderId) {
        if (orderId == null){
            throw new InvalidInputException("输入为空！");
        }
        Order order = orderService.getById(orderId);
        if (order == null){
            throw new InvalidInputException("订单不存在！");
        }
        checkRole(order,"无权删除订单明细！");
        listByOrderId(orderId);
        boolean b = remove(new QueryWrapper<OrderItem>().eq("order_id", orderId));
        if (!b){
            throw new InvalidInputException("删除订单明细失败！");
        }
        orderService.refreshOrderAmount(orderId);
        return true;
    }

    private void checkRole(Order order,String s){
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(order.getUserId())){
            throw new InvalidInputException(s);
        }
    }
}
