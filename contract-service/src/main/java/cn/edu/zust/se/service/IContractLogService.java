package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.ContractLog;
import cn.edu.zust.se.entity.query.ContractLogQuery;
import cn.edu.zust.se.entity.query.OrderLogQuery;
import cn.edu.zust.se.entity.vo.ContractLogVo;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author author
 * @since 2024-12-24
 */
public interface IContractLogService extends IService<ContractLog> {
    public PageDto<ContractLogVo> pageLogs(ContractLogQuery query);
    void addLog(Integer contractId, Integer userId, String action, String content);
}
