package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.dto.TendDto;
import cn.edu.zust.se.entity.po.Order;
import cn.edu.zust.se.entity.query.OrderQuery;
import cn.edu.zust.se.entity.vo.OrderVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * @author anymore131
 * @since 2024-12-21
 */
public interface IOrderService extends IService<Order> {
    public OrderVo getOrderVoById(Integer id);
    public PageDto<OrderVo> pageOrders(OrderQuery orderQuery);
    public Integer addOrder(Order order);
    public Integer getOrderIdByOrderNo(String orderNo);
    public void refreshOrderAmount(Integer id);
    public Integer backDraft(Integer id);
    public Integer PendingOrder(Integer id);
    public Integer ApproveOrder(Integer id);
    public Integer RejectOrder(Integer id);
    public Integer CompleteOrder(Integer id);
    public Integer CancelledOrder(Integer id);
    public OrderVo getOrderVoByOrderNo(String orderNo);
    public Map<String,Long> getOrderStatusDistribution(Integer userId);
    public List<TendDto> getTend(Integer userId);
}
