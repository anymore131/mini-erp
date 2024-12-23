package cn.edu.zust.se.controller;


import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.query.OrderLogQuery;
import cn.edu.zust.se.service.IOrderLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 订单日志表 前端控制器
 * </p>
 *
 * @author anymore131
 * @since 2024-12-21
 */
@RestController
@RequestMapping("/order-log")
public class OrderLogController {
    @Autowired
    private IOrderLogService orderLogService;

    @RequestMapping("/pageLogs")
    public SaResult pageLogs(@RequestBody OrderLogQuery query) {
        return SaResult.data(orderLogService.pageLogs(query));
    }
}
