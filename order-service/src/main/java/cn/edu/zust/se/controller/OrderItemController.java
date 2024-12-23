package cn.edu.zust.se.controller;


import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.OrderItem;
import cn.edu.zust.se.entity.query.OrderItemQuery;
import cn.edu.zust.se.entity.vo.OrderItemVo;
import cn.edu.zust.se.service.IOrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * <p>
 * 订单明细表 前端控制器
 * </p>
 *
 * @author anymore131
 * @since 2024-12-21
 */
@RestController
@RequestMapping("/order-item")
public class OrderItemController {
    @Autowired
    private IOrderItemService orderItemService;

    @RequestMapping("/list/{id}")
    public SaResult list(@PathVariable("id") Integer id){
        List<OrderItemVo> items = orderItemService.listByOrderId(id);
        return new SaResult().setData(items).setMsg("获取订单明细成功！");
    }

    @RequestMapping("/page")
    public SaResult page(@RequestBody OrderItemQuery query){
        return new SaResult().setData(orderItemService.page(query)).setMsg("获取订单明细成功！");
    }

    @RequestMapping("/add")
    public SaResult add(@RequestBody OrderItem item){
        boolean add = orderItemService.addOrderItem(item);
        return new SaResult().setData(add).setMsg("添加订单明细成功！");
    }

    @RequestMapping("/update")
    public SaResult update(@RequestBody OrderItem item){
        boolean update = orderItemService.updateOrderItem(item);
        return new SaResult().setData(update).setMsg("修改订单明细成功！");
    }

    @RequestMapping("/remove/{id}")
    public SaResult remove(@PathVariable("id") Integer id){
        boolean remove = orderItemService.removeOrderItemById(id);
        return new SaResult().setData(remove).setMsg("删除订单明细成功！");
    }
}
