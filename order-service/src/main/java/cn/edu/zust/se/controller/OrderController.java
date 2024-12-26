package cn.edu.zust.se.controller;


import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.Order;
import cn.edu.zust.se.entity.query.OrderQuery;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.ClientFeignServiceI;
import cn.edu.zust.se.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

/**
 * <p>
 * 订单表 前端控制器
 * </p>
 * @author anymore131
 * @since 2024-12-21
 */
@RestController
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private IOrderService orderService;

    @RequestMapping("/add")
    public SaResult addOrder(@RequestBody Order order) {
        if (order == null){
            return SaResult.error("订单不能为空！");
        }
        Integer i = orderService.addOrder(order);
        if (i == null){
            return SaResult.error("订单添加失败！");
        }
        return SaResult.ok("订单添加成功！").setData(i);
    }

    @RequestMapping("/page")
    public SaResult pageOrders(@RequestBody OrderQuery orderQuery) {
        if (orderQuery == null){
            return SaResult.error("查询条件不能为空！");
        }
        return SaResult.data(orderService.pageOrders(orderQuery)).setMsg("查询成功！");
    }

    @RequestMapping("/get/{id}")
    public SaResult getOrderVoById(@PathVariable("id") Integer id) {
        if (id == null){
            return SaResult.error("订单id不能为空！");
        }
        return SaResult.data(orderService.getOrderVoById(id)).setMsg("查询成功！");
    }

    /**
     * 待订单添加完明细之后即可添加为待检验
     */
    @RequestMapping("/pending/{id}")
    public SaResult pendingOrder(@PathVariable("id") Integer id) {
        if (id == null){
            return SaResult.error("订单id不能为空！");
        }
        if (orderService.PendingOrder(id) != null){
            return SaResult.ok("订单状态修改待检验成功！");
        }
        return SaResult.error("订单状态修改待检验失败！");
    }

    /**
     * 失效
     * 检验通过
     */
    @RequestMapping("/approve/{id}")
    public SaResult approveOrder(@PathVariable("id") Integer id) {
        if (id == null){
            return SaResult.error("订单id不能为空！");
        }
        if (!StpUtil.hasRole("admin")){
            return SaResult.error("无权操作！");
        }
        if (orderService.ApproveOrder(id) != null){
            return SaResult.ok("订单检验通过成功！");
        }
        return SaResult.error("订单检验通过失败！");
    }

    /**
     * 失效
     * 检验不通过
     */
    @RequestMapping("/reject/{id}")
    public SaResult rejectOrder(@PathVariable("id") Integer id) {
        if (id == null){
            return SaResult.error("订单id不能为空！");
        }
        if (!StpUtil.hasRole("admin")){
            return SaResult.error("无权操作！");
        }
        if (orderService.RejectOrder(id) != null){
            return SaResult.ok("订单检验不通过成功！");
        }
        return SaResult.error("订单检验不通过失败！");
    }

    /**
     * 完成(待使用)
     */
    @RequestMapping("/complete/{id}")
    public SaResult completeOrder(@PathVariable("id") Integer id) {
        if (id == null){
            return SaResult.error("订单id不能为空！");
        }
        if (orderService.CompleteOrder(id) != null){
            return SaResult.ok("订单完成成功！");
        }
        return SaResult.error("订单完成失败！");
    }

    /**
     * 取消
     */
    @RequestMapping("/cancel/{id}")
    public SaResult cancelOrder(@PathVariable("id") Integer id) {
        if (id == null){
            return SaResult.error("订单id不能为空！");
        }
        if (orderService.CancelledOrder(id) != null){
            return SaResult.ok("订单取消成功！");
        }
        return SaResult.error("订单取消失败！");
    }

    @RequestMapping("/status-distribution")
    public SaResult getOrderStatusDistribution(@RequestParam(value = "id",required = false) Integer id){
        return SaResult.data(orderService.getOrderStatusDistribution(id));
    }

    @RequestMapping("/trend")
    public SaResult getTend(@RequestParam(value = "userId",required = false)Integer userId){
        return SaResult.data(orderService.getTend(userId));
    }

    @GetMapping("/getLastOrderTime/{clientId}")
    public LocalDateTime getLastOrderTime(@PathVariable("clientId") Integer clientId){
        return orderService.getLastOrderTime(clientId);
    }

    @GetMapping("/getOrderFrequency/{clientId}")
    public long getOrderFrequency(@PathVariable("clientId") Integer clientId){
        return orderService.getOrderFrequency(clientId);
    }

    @GetMapping("/getTotalAmount/{clientId}")
    public Integer getTotalAmount(@PathVariable("clientId") Integer clientId){
        return orderService.getTotalAmount(clientId);
    }
}
