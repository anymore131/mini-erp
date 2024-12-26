package cn.edu.zust.se.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.ContractApproval;
import cn.edu.zust.se.entity.vo.ContractApprovalVo;
import cn.edu.zust.se.mapper.ContractApprovalMapper;
import cn.edu.zust.se.service.IContractApprovalService;
import cn.edu.zust.se.service.IContractService;
import cn.edu.zust.se.service.impl.ContractApprovalServiceImpl;
import lombok.AllArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author author
 * @since 2024-12-21
 */
@RestController
@RequestMapping("/contract-approval")
@AllArgsConstructor
public class ContractApprovalController {
    private static final Logger logger = LoggerFactory.getLogger(ContractApprovalController.class);
    private final IContractApprovalService contractApprovalService;
    private final IContractService contractService;
    private final ContractApprovalServiceImpl contractApprovalServiceImpl;

    // 获取所有合同审批记录
    @GetMapping
    public SaResult getAllContractApprovals() {
        logger.info("Fetching all contract approvals");
        List<ContractApprovalVo> approvals = contractApprovalService.getAllContractApprovals();
        return SaResult.data(approvals);
    }

    // 根据 ID 获取单个合同审批记录
    @GetMapping("/{id}")
    public SaResult getContractApprovalById(@PathVariable Integer id) {
        logger.info("Fetching contract approval with ID: {}", id);
        ContractApprovalVo approval = contractApprovalService.getContractApprovalById(id);
        return SaResult.data(approval);
    }

    // 创建新的合同审批记录
    @PostMapping
    public SaResult createContractApproval(@RequestBody ContractApproval contractApproval) {
        logger.info("Creating new contract approval: {}", contractApproval);
        if (contractApprovalService.createContractApproval(contractApproval)){
            return SaResult.ok("添加成功");
        }
        return SaResult.error("添加失败");
    }

    // 更新合同审批记录
    @PutMapping("/{id}")
    public SaResult updateContractApproval(@PathVariable Integer id,
                                           @RequestBody ContractApproval contractApproval) {
        contractApproval.setId(id); // 确保更新的记录 ID 是正确的
        logger.info("Updating contract approval with ID: {}, new data: {}", id, contractApproval);
        ContractApprovalVo updatedApproval = contractApprovalService.updateContractApproval(contractApproval);
        if (updatedApproval != null) {
            SaResult.data(updatedApproval);
            return SaResult.ok("更新成功");
        } else {
            return SaResult.error("更新失败");
        }
    }


    // 根据合同ID获取合同审批记录
    @GetMapping("/by-contract-id/{contractId}")
    public SaResult getByContractId(@PathVariable Integer contractId) {
        logger.info("Fetching contract approvals by contract ID: {}", contractId);
        if(contractApprovalService.getByContractId(contractId)==null){
            return SaResult.error("合同不存在");
        }
        return SaResult.data(contractApprovalService.getByContractId(contractId));
    }

    // 根据用户ID获取合同审批记录
    @GetMapping("/by-user-id/{userId}")
    public SaResult getByUserId(@PathVariable Integer userId) {
        logger.info("Fetching contract approvals by user ID: {}", userId);
        if (contractApprovalService.getByUserId(userId)==null){
            return SaResult.error("用户不存在");
        }
        return SaResult.data(contractApprovalService.getByUserId(userId));
    }

    // 根据状态获取合同审批记录
    @GetMapping("/by-status/{status}")
    public SaResult getByStatus(@PathVariable int status) {
        logger.info("Fetching contract approvals by status: {}", status);
        if (contractApprovalService.getByStatus(status)==null){
            return SaResult.error("状态不存在");
        }
        return SaResult.data(contractApprovalService.getByStatus(status));
    }

    //审批通过
    @RequestMapping("/pass/{id}")
    public SaResult passOrderApproval(@PathVariable Integer id,@RequestParam("comment")String comment){
        if (contractApprovalService.passContractApproval(id,comment)){
            return SaResult.ok("通过成功");
        }
        return SaResult.error("通过失败");
    }

    //审批不通过
    @RequestMapping("/reject/{id}")
    public SaResult rejectOrderApproval(@PathVariable Integer id,@RequestParam("comment")String comment){
        if (contractApprovalService.rejectContractApproval(id,comment)){
            return SaResult.ok("驳回成功");
        }
        return SaResult.error("驳回失败");
    }
    // 软删除合同审批记录
    @DeleteMapping("/{id}")
    public SaResult deleteContractApproval(@PathVariable Integer id) {
        logger.info("Deleting contract approval with ID: {}", id);
        contractApprovalService.softDelete(id);
        if(contractService.getById(id)==null){
            return SaResult.ok("删除成功");
        }
        return SaResult.error("删除失败");
    }

}
