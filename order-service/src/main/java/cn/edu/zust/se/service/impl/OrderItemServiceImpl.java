package cn.edu.zust.se.service.impl;

import cn.edu.zust.se.entity.po.OrderItem;
import cn.edu.zust.se.mapper.OrderItemMapper;
import cn.edu.zust.se.service.IOrderItemService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author anymore131
 * @since 2024-12-21
 */
@Service
public class OrderItemServiceImpl extends ServiceImpl<OrderItemMapper, OrderItem> implements IOrderItemService {

}
