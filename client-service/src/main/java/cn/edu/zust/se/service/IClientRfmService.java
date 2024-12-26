package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.ClientRfm;
import cn.edu.zust.se.entity.query.ClientRfmQuery;
import cn.edu.zust.se.entity.vo.ClientRfmVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * @author anymore131
 * @since 2024-12-26
 */
public interface IClientRfmService extends IService<ClientRfm> {
    void updateAllRfmScores();
    Map<String, Long> getCustomerLevelDistribution(Integer userId);
    PageDto<ClientRfmVo> getValueCustomers(ClientRfmQuery clientRfmQuery);
    void insertRfm(Integer clientId);
    void updateRfmByUserId(Integer userId);
}
