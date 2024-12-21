package cn.edu.zust.se.controller;


import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.service.IOrderFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 * 订单文件表 前端控制器
 * </p>
 *
 * @author anymore131
 * @since 2024-12-21
 */
@RestController
@RequestMapping("/order-file")
public class OrderFileController {
    @Autowired
    private IOrderFileService orderFileService;

    @PostMapping("/add/{id}")
    public SaResult addOrderFile(@PathVariable("id") Integer orderId
            ,@RequestParam("remark") String remark
            ,@RequestParam("file") MultipartFile file) {
        return orderFileService.addOrderFile(orderId, remark, file);
    }

    @GetMapping("/list/{id}")
    public SaResult listOrderFile(@PathVariable("id") Integer orderId) {
        return orderFileService.getOrderFile(orderId);
    }

    @DeleteMapping("/remove/{id}")
    public SaResult removeOrderFile(@PathVariable("id") Integer id) {
        if (!orderFileService.removeOrderFile(id)) {
            return SaResult.error("删除失败！");
        }
        return SaResult.ok("删除成功！");
    }
}
