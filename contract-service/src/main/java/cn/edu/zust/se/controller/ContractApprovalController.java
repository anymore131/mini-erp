package cn.edu.zust.se.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.ContractApproval;
import cn.edu.zust.se.entity.query.ContractApprovalQuery;
import cn.edu.zust.se.entity.vo.ContractApprovalVo;
import cn.edu.zust.se.exception.ForbiddenException;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.service.IContractApprovalService;
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
    private final IContractApprovalService contractService;

    // 获取所有合同审批记录
    @GetMapping
    public ResponseEntity<List<ContractApprovalVo>> getAllContractApprovals() {
        logger.info("Fetching all contract approvals");
        List<ContractApprovalVo> approvals = contractService.getAllContractApprovals();
        return ResponseEntity.ok(approvals);
    }

    // 根据 ID 获取单个合同审批记录
    @GetMapping("/{id}")
    public ResponseEntity<ContractApprovalVo> getContractApprovalById(@PathVariable Integer id) {
        logger.info("Fetching contract approval with ID: {}", id);
        ContractApprovalVo approval = contractService.getContractApprovalById(id);
        if (approval != null) {
            return ResponseEntity.ok(approval);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // 创建新的合同审批记录
    @PostMapping
    public ResponseEntity<ContractApprovalVo> createContractApproval(@RequestBody ContractApproval contractApproval) {
        logger.info("Creating new contract approval: {}", contractApproval);
        ContractApprovalVo createdApproval = contractService.createContractApproval(contractApproval);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdApproval);
    }

    // 更新合同审批记录
    @PutMapping("/{id}")
    public ResponseEntity<ContractApprovalVo> updateContractApproval(@PathVariable Integer id,
                                                                   @RequestBody ContractApproval contractApproval) {
        contractApproval.setId(id); // 确保更新的记录 ID 是正确的
        logger.info("Updating contract approval with ID: {}, new data: {}", id, contractApproval);
        ContractApprovalVo updatedApproval = contractService.updateContractApproval(contractApproval);
        if (updatedApproval != null) {
            return ResponseEntity.ok(updatedApproval);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    /**
     * 获取合同审批列表
     */
    @GetMapping(value = "/page/{id}")
    public SaResult getContractList(@PathVariable Integer id,
                                    @RequestBody(required = false) ContractApprovalQuery contractApprovalQuery) {
        if (contractApprovalQuery == null || id == null){
            throw new InvalidInputException("输入信息为空！");
        }
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(id)) {
            throw new ForbiddenException("无权查看其他用户的合同信息！");
        }
        if (contractApprovalQuery.getUserId() == null ) {
            throw new InvalidInputException("输入信息为空！");
        }
        if (!id.equals(contractApprovalQuery.getUserId())){
            throw new InvalidInputException("输入信息不一致！");
        }
        PageDto<ContractApprovalVo> contracts = contractService.getContract(contractApprovalQuery);
        return SaResult.data(contracts);
    }

//    // 综合查询合同审批记录
//    @GetMapping("/search")
//    public ResponseEntity<Page<ContractApprovalVo>> searchContractApprovals(
//            @RequestParam(required = false) Integer contractId,
//            @RequestParam(required = false) Integer userId,
//            @RequestParam(required = false) int status,
//            @RequestParam int pageNo,
//            @RequestParam int pageSize) {
//        logger.info("Searching contract approvals with contractId: {}, userId: {}, status: {}, page: {}, size: {}", contractId, userId, status, pageNo, pageSize);
//        Page<ContractApprovalVo> page = contractService.selectPageByStartTime(contractId, userId, status, pageNo, pageSize);
//        return ResponseEntity.ok(page);
//    }
//
//    // 分页获取合同审批记录
//    @GetMapping("/page")
//    public ResponseEntity<Page<ContractApprovalVo>> getPageByStartTime(
//            @RequestParam int currentPage,
//            @RequestParam int pageSize) {
//        logger.info("Fetching contract approvals by start time, page: {}, size: {}", currentPage, pageSize);
//        Page<ContractApprovalVo> page = contractService.getPageByStartTime(currentPage, pageSize);
//        return ResponseEntity.ok(page);
//    }

    // 根据合同ID获取合同审批记录
    @GetMapping("/by-contract-id/{contractId}")
    public ResponseEntity<List<ContractApprovalVo>> getByContractId(@PathVariable Integer contractId) {
        logger.info("Fetching contract approvals by contract ID: {}", contractId);
        List<ContractApprovalVo> approvals = contractService.getByContractId(contractId);
        return ResponseEntity.ok(approvals);
    }

    // 根据用户ID获取合同审批记录
    @GetMapping("/by-user-id/{userId}")
    public ResponseEntity<List<ContractApprovalVo>> getByUserId(@PathVariable Integer userId) {
        logger.info("Fetching contract approvals by user ID: {}", userId);
        List<ContractApprovalVo> approvals = contractService.getByUserId(userId);
        return ResponseEntity.ok(approvals);
    }

    // 根据状态获取合同审批记录
    @GetMapping("/by-status/{status}")
    public ResponseEntity<List<ContractApprovalVo>> getByStatus(@PathVariable int status) {
        logger.info("Fetching contract approvals by status: {}", status);
        List<ContractApprovalVo> approvals = contractService.getByStatus(status);
        return ResponseEntity.ok(approvals);
    }

    // 软删除合同审批记录
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteContractApproval(@PathVariable Integer id) {
        logger.info("Deleting contract approval with ID: {}", id);
        contractService.softDelete(id);
        return ResponseEntity.noContent().build();
    }

}
