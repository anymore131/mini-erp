package cn.edu.zust.se.service.impl;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Client;
import cn.edu.zust.se.entity.po.Order;
import cn.edu.zust.se.entity.query.OrderQuery;
import cn.edu.zust.se.entity.vo.ClientVo;
import cn.edu.zust.se.entity.vo.OrderVo;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.ClientFeignServiceI;
import cn.edu.zust.se.feign.UserFeignServiceI;
import cn.edu.zust.se.mapper.OrderMapper;
import cn.edu.zust.se.service.IOrderService;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

/**
 * @author anymore131
 * @since 2024-12-21
 */
@Service
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements IOrderService {
    @Autowired
    private UserFeignServiceI userFeignService;
    @Autowired
    private ClientFeignServiceI clientFeignService;

    @Override
    public OrderVo getOrderVoById(Integer id) {
        if (id == null){
            throw new InvalidInputException("订单id不能为空！");
        }
        Order order = getById(id);
        if (order == null){
            throw new InvalidInputException("订单不存在！");
        }
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

    @Override
    public PageDto<OrderVo> pageOrders(OrderQuery orderQuery) {
        Page<Order> page = orderQuery.toMpPage(orderQuery.getSortBy(), orderQuery.isAsc());
        lambdaQuery()
                .eq(orderQuery.getOrderNo() != null, Order::getOrderNo, orderQuery.getOrderNo())
                .eq(orderQuery.getClientId() != null, Order::getClientId, orderQuery.getClientId())
                .eq(orderQuery.getUserId() != null, Order::getUserId, orderQuery.getUserId())
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
            OrderVo orderVo = BeanUtil.copyProperties(records, OrderVo.class);
            orderVo.setUserName(userFeignService.getUserNameById(record.getUserId()));
            orderVo.setClientName(clientFeignService.getClientNameById(record.getClientId()));
            vos.add(orderVo);
        }
        orderVos.setList(vos);
        return orderVos;
    }

    // 起草
    @Override
    public void addOrder(Order order) {
        if (order == null){
            throw new InvalidInputException("订单不能为空！");
        }
        if (order.getClientId() == null){
            throw new InvalidInputException("客户不能为空！");
        }
        if (order.getUserId() == null){
            throw new InvalidInputException("用户不能为空！");
        }
        order.setStatus("DRAFT");
        order.setTotalAmount(0);
        order.setCreateTime(LocalDateTime.now());
        order.setUpdateTime(LocalDateTime.now());
        order.setIsDelete(0);
        save(order);
    }

    // 待检验
    @Override
    public Integer PendingOrder(Integer id) {
        if (id == null){
            throw new InvalidInputException("订单id不能为空！");
        }
        Order order = getById(id);
        if (order == null){
            throw new InvalidInputException("订单不存在！");
        }
        if (!Objects.equals(order.getStatus(), "DRAFT")){
            throw new InvalidInputException("订单状态错误！");
        }
        order.setStatus("PENDING");



        return updateById(order)? id : null;
    }

    // 检验通过
    @Override
    public Integer ApproveOrder(Integer id) {
        if (id == null){
            throw new InvalidInputException("订单id不能为空！");
        }
        Order order = getById(id);
        if (order == null){
            throw new InvalidInputException("订单不存在！");
        }
        if (!Objects.equals(order.getStatus(), "PENDING")){
            throw new InvalidInputException("订单状态错误！");
        }
        order.setStatus("APPROVED");



        return updateById(order)? id : null;
    }

    // 未通过
    @Override
    public Integer RejectOrder(Integer id) {
        if (id == null){
            throw new InvalidInputException("订单id不能为空！");
        }
        Order order = getById(id);
        if (order == null){
            throw new InvalidInputException("订单不存在！");
        }
        if (!Objects.equals(order.getStatus(), "PENDING")){
            throw new InvalidInputException("订单状态错误！");
        }
        order.setStatus("REJECTED");



        return updateById(order)? id : null;
    }

    // 完成
    @Override
    public Integer CompleteOrder(Integer id) {
        if (id == null){
            throw new InvalidInputException("订单id不能为空！");
        }
        Order order = getById(id);
        if (order == null){
            throw new InvalidInputException("订单不存在！");
        }
        if (!Objects.equals(order.getStatus(), "APPROVED")){
            throw new InvalidInputException("订单状态错误！");
        }
        order.setStatus("COMPLETED");



        return updateById(order)? id : null;
    }

    @Override
    public Integer CancelledOrder(Integer id) {
        if (id == null){
            throw new InvalidInputException("订单id不能为空！");
        }
        Order order = getById(id);
        if (order == null){
            throw new InvalidInputException("订单不存在！");
        }
        order.setStatus("CANCELLED");

        return updateById(order)? id : null;
    }

}
