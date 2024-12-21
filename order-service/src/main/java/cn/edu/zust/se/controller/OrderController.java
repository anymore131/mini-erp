package cn.edu.zust.se.controller;


import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.Order;
import cn.edu.zust.se.entity.query.OrderQuery;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

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
            throw new InvalidInputException("订单不能为空！");
        }
        orderService.addOrder(order);
        return SaResult.ok("订单添加成功！");
    }

    @RequestMapping("/page")
    public SaResult pageOrders(@RequestBody OrderQuery orderQuery) {
        if (orderQuery == null){
            throw new InvalidInputException("查询条件不能为空！");
        }
        return SaResult.data(orderService.pageOrders(orderQuery)).setMsg("查询成功！");
    }

    @RequestMapping("/get/{id}")
    public SaResult getOrderVoById(@PathVariable("id") Integer id) {
        if (id == null){
            throw new InvalidInputException("订单id不能为空！");
        }
        return SaResult.data(orderService.getOrderVoById(id)).setMsg("查询成功！");
    }

    /**
     * 待订单添加完明细之后即可添加为待检验
     */
    @RequestMapping("/pending/{id}")
    public SaResult pendingOrder(@PathVariable("id") Integer id) {
        return null;
    }

    /**
     * 检验通过
     */
    @RequestMapping("/approve/{id}")
    public SaResult approveOrder(@PathVariable("id") Integer id) {
        return null;
    }

    /**
     * 检验不通过
     */
    @RequestMapping("/reject/{id}")
    public SaResult rejectOrder(@PathVariable("id") Integer id) {
        return null;
    }

    /**
     * 完成
     */
    @RequestMapping("/complete/{id}")
    public SaResult completeOrder(@PathVariable("id") Integer id) {
        return null;
    }

    /**
     * 取消
     */
    @RequestMapping("/cancel/{id}")
    public SaResult cancelOrder(@PathVariable("id") Integer id) {
        return null;
    }
}
