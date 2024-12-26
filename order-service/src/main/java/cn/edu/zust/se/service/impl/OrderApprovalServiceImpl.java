package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.po.Order;
import cn.edu.zust.se.entity.po.OrderApproval;
import cn.edu.zust.se.entity.po.OrderLog;
import cn.edu.zust.se.entity.vo.OrderApprovalVo;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.UserFeignServiceI;
import cn.edu.zust.se.mapper.OrderApprovalMapper;
import cn.edu.zust.se.mapper.OrderMapper;
import cn.edu.zust.se.service.IOrderApprovalService;
import cn.edu.zust.se.service.IOrderService;
import cn.edu.zust.se.service.IOrderLogService;
import cn.hutool.core.bean.BeanUtil;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
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
public class OrderApprovalServiceImpl extends ServiceImpl<OrderApprovalMapper, OrderApproval> implements IOrderApprovalService {
    @Autowired
    private UserFeignServiceI userFeignService;
    @Autowired
    private IOrderService orderService;
    @Autowired
    private IOrderLogService orderLogService;
    private final OrderMapper orderMapper;

    public OrderApprovalServiceImpl(OrderMapper orderMapper) {
        this.orderMapper = orderMapper;
    }

    @Override
    public boolean addOrderApproval(OrderApproval orderApproval) {
        checkInput(orderApproval, "参数为空");
        checkAdmin();
        checkInput(orderApproval.getOrderId(), "订单id不能为空！");
        checkInput(orderApproval.getApproverId(), "审批人不能为空！");
        checkInput(orderMapper.selectById(orderApproval.getOrderId()),"订单不存在！");
        orderApproval.setCreateTime(LocalDateTime.now()).setIsDelete(0);
        boolean b = save(orderApproval);
        String result = "PASS".equals(orderApproval.getStatus()) ? "通过" : "不通过";
        orderLogService.addLog(orderApproval.getOrderId(), orderApproval.getApproverId(), "APPROVE", 
            String.format("审批%s，意见：%s", result, orderApproval.getComment()));
        if (b && "PASS".equals(orderApproval.getStatus())){
            orderService.ApproveOrder(orderApproval.getOrderId());
        }else if (b && "REJECT".equals(orderApproval.getStatus())) {
            orderService.RejectOrder(orderApproval.getOrderId());
        }
        updateOrderTime(orderApproval.getOrderId());
        return b;
    }

    @Override
    public List<OrderApprovalVo> getOrderApprovalByOrderId(Integer orderId) {
        checkInput(orderId, "参数为空");
        Order order = orderMapper.selectById(orderId);
        checkInput(order, "订单不存在");
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(order.getUserId())){
            throw new InvalidInputException("权限不足！");
        }
        QueryWrapper<OrderApproval> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("order_id", orderId).orderBy(true, false,"create_time");
        List<OrderApproval> orderApprovals = list(queryWrapper);
        if (orderApprovals == null){
            return null;
        }
        List<OrderApprovalVo> vos = new ArrayList<>();
        for (OrderApproval orderApproval : orderApprovals){
            OrderApprovalVo vo = BeanUtil.copyProperties(orderApproval, OrderApprovalVo.class);
            vo.setOrderNo(order.getOrderNo());
            vo.setApproverName(userFeignService.getUserNameById(orderApproval.getApproverId()));
            vos.add(vo);
        }
        return vos;
    }

    // 已弃用
    @Override
    public boolean passOrderApproval(Integer id,String comment) {
        checkInput(id, "参数为空");
        checkAdmin();
        OrderApproval orderApproval = getById(id);
        checkInput(orderApproval, "审批记录不存在");
        if (!Objects.equals(orderApproval.getStatus(), "START")){
            throw new InvalidInputException("审批记录已结束！");
        }
        orderApproval.setComment(comment);
        orderApproval.setStatus("PASS");
        return updateById(orderApproval);
    }

    // 已弃用
    @Override
    public boolean rejectOrderApproval(Integer id, String comment) {
        checkInput(id, "参数为空");
        checkAdmin();
        OrderApproval orderApproval = getById(id);
        checkInput(orderApproval, "审批记录不存在");
        if (!Objects.equals(orderApproval.getStatus(), "START")){
            throw new InvalidInputException("审批记录已结束！");
        }
        checkInput(comment, "审批意见不能为空！");
        orderApproval.setComment(comment);
        orderApproval.setStatus("REJECT");
        return updateById(orderApproval);
    }

    // 已弃用
    @Override
    public void updateOrderApproval(OrderApproval orderApproval) {}

    // 已弃用
    @Override
    public void deleteOrderApproval(Integer id) {}

    private <T> void checkInput(T t,String s){
        if (t == null){
            throw new InvalidInputException(s);
        }
    }

    private void checkAdmin(){
        if (!StpUtil.hasRole("admin")){
            throw new InvalidInputException("权限不足！");
        }
    }

    private void updateOrderTime(Integer orderId){
        Order order = orderService.getById(orderId);
        order.setUpdateTime(LocalDateTime.now());
        orderService.update(order, new UpdateWrapper<Order>().eq("id", orderId));
    }
}
