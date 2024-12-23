package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.OrderLog;
import cn.edu.zust.se.entity.query.OrderLogQuery;
import cn.edu.zust.se.entity.vo.OrderLogVo;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 订单日志表 服务类
 * </p>
 *
 * @author anymore131
 * @since 2024-12-21
 */
public interface IOrderLogService extends IService<OrderLog> {
    public PageDto<OrderLogVo> pageLogs(OrderLogQuery query);
    void addLog(Integer orderId, Integer userId, String action, String content);
}
