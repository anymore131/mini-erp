package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.po.OrderApproval;
import cn.edu.zust.se.entity.vo.OrderApprovalVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 订单审批表 服务类
 * </p>
 *
 * @author anymore131
 * @since 2024-12-21
 */
public interface IOrderApprovalService extends IService<OrderApproval> {
    public boolean addOrderApproval(OrderApproval orderApproval);
    public List<OrderApprovalVo> getOrderApprovalByOrderId(Integer orderId);
    public boolean passOrderApproval(Integer id, String comment);
    public boolean rejectOrderApproval(Integer id, String comment);
    public void updateOrderApproval(OrderApproval orderApproval);
    public void deleteOrderApproval(Integer id);
}
