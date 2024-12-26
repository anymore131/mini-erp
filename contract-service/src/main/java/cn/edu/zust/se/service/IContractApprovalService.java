package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.ContractApproval;
import cn.edu.zust.se.entity.query.ContractApprovalQuery;
import cn.edu.zust.se.entity.query.ContractQuery;
import cn.edu.zust.se.entity.vo.ContractApprovalVo;
import cn.edu.zust.se.entity.vo.ContractVo;
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
    List<ContractApprovalVo> getAllContractApprovals();

    // 根据 ID 获取单个合同审批记录
    ContractApprovalVo getContractApprovalById(Integer id);

    // 根据合同ID查询审批记录
    List<ContractApprovalVo> getByContractId(Integer contractId);

    // 根据合同ID查询审批记录
    ContractApprovalVo getByOrderId(Integer orderId);

    // 根据用户ID查询审批记录
    List<ContractApprovalVo> getByUserId(Integer userId);

//    //获取合同审批列表
//    PageDto<ContractApprovalVo> getContract(ContractApprovalQuery contractApprovalQuery);

    // 根据审批状态查询审批记录
    List<ContractApprovalVo> getByStatus(int status);

    // 创建新的合同审批记录
    boolean createContractApproval(ContractApproval contractApproval);

    // 更新合同审批记录
    ContractApprovalVo updateContractApproval(ContractApproval contractApproval);

    //通过审批
    boolean passContractApproval(Integer id, String approvalOpinion);

    //拒绝通过审批
    boolean rejectContractApproval(Integer id, String approvalOpinion);

    // 删除合同审批记录
    void deleteContractApproval(Integer id);

    // 软删除合同审批记录
    void softDelete(Integer id);
}
