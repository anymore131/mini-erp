package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.OrderItem;
import cn.edu.zust.se.entity.query.OrderItemQuery;
import cn.edu.zust.se.entity.vo.OrderItemVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * @author anymore131
 * @since 2024-12-21
 */
public interface IOrderItemService extends IService<OrderItem> {
    public OrderItemVo getOrderItemById(Integer id);
    public PageDto<OrderItemVo> page(OrderItemQuery query);
    public List<OrderItemVo> listByOrderId(Integer orderId);
    public boolean addOrderItem(OrderItem item);
    public boolean updateOrderItem(OrderItem item);
    public boolean removeOrderItemById(Integer id);
    public boolean removeOrderItemByOrderId(Integer orderId);
}
