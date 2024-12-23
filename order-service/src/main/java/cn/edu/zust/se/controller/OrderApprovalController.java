package cn.edu.zust.se.controller;


import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.OrderApproval;
import cn.edu.zust.se.service.IOrderApprovalService;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 订单审批表 前端控制器
 * </p>
 *
 * @author anymore131
 * @since 2024-12-21
 */
@RestController
@RequestMapping("/order-approval")
public class OrderApprovalController {
    private final IOrderApprovalService orderApprovalService;

    public OrderApprovalController(IOrderApprovalService orderApprovalService) {
        this.orderApprovalService = orderApprovalService;
    }

    @RequestMapping("/add")
    public SaResult addOrderApproval(@RequestBody OrderApproval orderApproval){
        if (orderApprovalService.addOrderApproval(orderApproval)){
            return SaResult.ok("添加成功");
        }
        return SaResult.error("添加失败");
    }

    @RequestMapping("/list/{orderId}")
    public SaResult getOrderApprovalById(@PathVariable Integer orderId){
        return SaResult.data(orderApprovalService.getOrderApprovalByOrderId(orderId));
    }

    /**
     * 失效
     * 通过
     */
    @RequestMapping("/pass/{id}")
    public SaResult passOrderApproval(@PathVariable Integer id,@RequestParam("comment")String comment){
        if (orderApprovalService.passOrderApproval(id,comment)){
            return SaResult.ok("通过成功");
        }
        return SaResult.error("通过失败");
    }

    /**
     * 失效
     * 不通过
     */
    @RequestMapping("/reject/{id}")
    public SaResult rejectOrderApproval(@PathVariable Integer id,@RequestParam("comment")String comment){
        if (orderApprovalService.rejectOrderApproval(id,comment)){
            return SaResult.ok("驳回成功");
        }
        return SaResult.error("驳回失败");
    }
}
