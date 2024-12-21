package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Order;
import cn.edu.zust.se.entity.query.OrderQuery;
import cn.edu.zust.se.entity.vo.OrderVo;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * @author anymore131
 * @since 2024-12-21
 */
public interface IOrderService extends IService<Order> {
    public OrderVo getOrderVoById(Integer id);
    public PageDto<OrderVo> pageOrders(OrderQuery orderQuery);
    public void addOrder(Order order);
    public Integer PendingOrder(Integer id);
    public Integer ApproveOrder(Integer id);
    public Integer RejectOrder(Integer id);
    public Integer CompleteOrder(Integer id);
    public Integer CancelledOrder(Integer id);
}
