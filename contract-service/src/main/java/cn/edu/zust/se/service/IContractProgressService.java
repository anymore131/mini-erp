package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.ContractProgress;
import cn.edu.zust.se.entity.query.ContractProgressQuery;
import cn.edu.zust.se.entity.vo.ContractProgressVo;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 合同进度服务接口
 */
public interface IContractProgressService extends IService<ContractProgress> {
    /**
     * 分页查询合同进度
     * @param query 查询条件
     * @return 分页结果
     */
    PageDto<ContractProgressVo> pageContractProgresses(ContractProgressQuery query);

    /**
     * 根据ID获取合同进度
     * @param id 进度ID
     * @return 合同进度VO
     */
    ContractProgressVo getContractProgressVoById(Integer id);

    /**
     * 创建合同进度
     * @param contractProgress 合同进度信息
     * @return 创建的进度ID
     */
    Integer addContractProgress(ContractProgress contractProgress);

    /**
     * 更新合同进度
     * @param contractProgress 合同进度信息
     * @return 是否成功
     */
    boolean updateContractProgress(ContractProgress contractProgress);

    /**
     * 删除合同进度
     * @param id 进度ID
     * @return 是否成功
     */
    boolean deleteContractProgress(Integer id);

    /**
     * 根据合同ID获取最新进度
     * @param contractId 合同ID
     * @return 最新进度
     */
    ContractProgressVo getLatestProgressByContractId(Integer contractId);
}
