package cn.edu.zust.se.mapper;

import cn.edu.zust.se.entity.po.OrderItem;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 订单明细表 Mapper 接口
 * </p>
 *
 * @author anymore131
 * @since 2024-12-21
 */
public interface OrderItemMapper extends BaseMapper<OrderItem> {
    @Select("select * from erp.order_item where order_id = #{orderId} and is_delete = 0")
    public List<OrderItem> getByOrderId(Integer orderId);
}
