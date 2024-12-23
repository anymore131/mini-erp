package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Order;
import cn.edu.zust.se.entity.po.OrderLog;
import cn.edu.zust.se.entity.query.OrderLogQuery;
import cn.edu.zust.se.entity.vo.OrderLogVo;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.ClientFeignServiceI;
import cn.edu.zust.se.feign.UserFeignServiceI;
import cn.edu.zust.se.mapper.OrderLogMapper;
import cn.edu.zust.se.mapper.OrderMapper;
import cn.edu.zust.se.service.IOrderLogService;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * @author anymore131
 * @since 2024-12-21
 */
@Service
public class OrderLogServiceImpl extends ServiceImpl<OrderLogMapper, OrderLog> implements IOrderLogService {
    @Autowired
    private UserFeignServiceI userFeignService;
    @Autowired
    private OrderMapper orderMapper;

    @Override
    public PageDto<OrderLogVo> pageLogs(OrderLogQuery query) {
        Integer orderId = null, userId = null;
        if (query == null){
            throw new InvalidInputException("查询参数不能为空");
        }
        if (!StpUtil.hasRole("admin")){
            throw new InvalidInputException("无权限查询日志");
        }
        if(query.getOrderNo() != null){
            orderId = orderMapper.selectOne(new QueryWrapper<Order>().eq("order_no", query.getOrderNo())).getId();
        }
        if (query.getUserName() != null){
            userId = userFeignService.getUserIdByUserName(query.getUserName());
        }
        Page<OrderLog> page = query.toMpPage(query.getSortBy(),query.isAsc());
        lambdaQuery()
                .eq(query.getOrderNo() != null, OrderLog::getOrderId, orderId)
                .eq(query.getUserName() != null, OrderLog::getUserId, userId)
                .eq(query.getAction() != null, OrderLog::getAction, query.getAction())
                .page(page);
        PageDto<OrderLogVo> orderLogVos = new PageDto<>();
        orderLogVos.setTotal(page.getTotal());
        orderLogVos.setPages(page.getPages());
        List<OrderLogVo> vos = new ArrayList<>();
        if (CollUtil.isEmpty(page.getRecords())){
            orderLogVos.setList(Collections.emptyList());
            return orderLogVos;
        }
        for (OrderLog record : page.getRecords()){
            OrderLogVo orderLogVo = BeanUtil.copyProperties(record, OrderLogVo.class);
            orderLogVo.setOrderNo(orderMapper.selectOne(new QueryWrapper<Order>().eq("id", record.getOrderId())).getOrderNo());
            orderLogVo.setUserName(userFeignService.getUserNameById(record.getUserId()));
            vos.add(orderLogVo);
        }
        orderLogVos.setList(vos);
        return orderLogVos;
    }

    @Override
    public void addLog(Integer orderId, Integer userId, String action, String content) {
        OrderLog log = new OrderLog();
        log.setOrderId(orderId)
           .setUserId(userId)
           .setAction(action)
           .setContent(content)
           .setCreateTime(LocalDateTime.now())
           .setIsDelete(0);
        save(log);
    }
}
