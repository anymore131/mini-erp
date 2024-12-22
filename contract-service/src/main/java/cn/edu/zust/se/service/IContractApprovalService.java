package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.po.ContractApproval;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
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
public interface IContractApprovalService extends IService<ContractApproval> {
    // 获取所有合同审批记录
    List<ContractApproval> getAllContractApprovals();

    // 根据 ID 获取单个合同审批记录
    ContractApproval getContractApprovalById(Integer id);

    // 根据合同ID查询审批记录
    List<ContractApproval> getByContractId(Integer contractId);

    // 根据用户ID查询审批记录
    List<ContractApproval> getByUserId(Integer userId);

    // 分页查询，按start_time降序排列
    Page<ContractApproval> getPageByStartTime(int currentPage, int pageSize);

    // 合并的分页查询，按start_time降序排列
    Page<ContractApproval> selectPageByStartTime(Integer contractId, Integer userId, int status, int pageNo, int pageSize);

    // 根据审批状态查询审批记录
    List<ContractApproval> getByStatus(int status);

    // 创建新的合同审批记录
    ContractApproval createContractApproval(ContractApproval contractApproval);

    // 更新合同审批记录
    ContractApproval updateContractApproval(ContractApproval contractApproval);

    // 删除合同审批记录
    void deleteContractApproval(Integer id);

    // 软删除合同审批记录
    void softDelete(Integer id);
}
