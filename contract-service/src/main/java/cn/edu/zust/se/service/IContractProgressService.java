package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.po.ContractProgress;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author author
 * @since 2024-12-21
 */
public interface IContractProgressService extends IService<ContractProgress> {
    // 获取所有合同进度记录
    List<ContractProgress> getAllContractProgresses();

    // 根据 ID 获取单个合同进度记录
    ContractProgress getContractProgressById(Integer id);

    // 创建新的合同进度记录
    ContractProgress createContractProgress(ContractProgress contractProgress);

    // 更新合同进度记录
    ContractProgress updateContractProgress(ContractProgress contractProgress);

    // 删除合同进度记录
    void deleteContractProgress(Integer id);
}
