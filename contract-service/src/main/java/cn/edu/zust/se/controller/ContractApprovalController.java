package cn.edu.zust.se.controller;

import cn.edu.zust.se.entity.po.ContractApproval;
import cn.edu.zust.se.service.IContractApprovalService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
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
    public ResponseEntity<List<ContractApproval>> getAllContractApprovals() {
        logger.info("Fetching all contract approvals");
        List<ContractApproval> approvals = contractService.getAllContractApprovals();
        return ResponseEntity.ok(approvals);
    }

    // 根据 ID 获取单个合同审批记录
    @GetMapping("/{id}")
    public ResponseEntity<ContractApproval> getContractApprovalById(@PathVariable Integer id) {
        logger.info("Fetching contract approval with ID: {}", id);
        ContractApproval approval = contractService.getContractApprovalById(id);
        if (approval != null) {
            return ResponseEntity.ok(approval);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // 创建新的合同审批记录
    @PostMapping
    public ResponseEntity<ContractApproval> createContractApproval(@RequestBody ContractApproval contractApproval) {
        logger.info("Creating new contract approval: {}", contractApproval);
        ContractApproval createdApproval = contractService.createContractApproval(contractApproval);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdApproval);
    }

    // 更新合同审批记录
    @PutMapping("/{id}")
    public ResponseEntity<ContractApproval> updateContractApproval(@PathVariable Integer id,
                                                                   @RequestBody ContractApproval contractApproval) {
        contractApproval.setId(id); // 确保更新的记录 ID 是正确的
        logger.info("Updating contract approval with ID: {}, new data: {}", id, contractApproval);
        ContractApproval updatedApproval = contractService.updateContractApproval(contractApproval);
        if (updatedApproval != null) {
            return ResponseEntity.ok(updatedApproval);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // 综合查询合同审批记录
    @GetMapping("/search")
    public ResponseEntity<Page<ContractApproval>> searchContractApprovals(
            @RequestParam(required = false) Integer contractId,
            @RequestParam(required = false) Integer userId,
            @RequestParam(required = false) int status,
            @RequestParam int pageNo,
            @RequestParam int pageSize) {
        logger.info("Searching contract approvals with contractId: {}, userId: {}, status: {}, page: {}, size: {}", contractId, userId, status, pageNo, pageSize);
        Page<ContractApproval> page = contractService.selectPageByStartTime(contractId, userId, status, pageNo, pageSize);
        return ResponseEntity.ok(page);
    }

    // 分页获取合同审批记录
    @GetMapping("/page")
    public ResponseEntity<Page<ContractApproval>> getPageByStartTime(
            @RequestParam int currentPage,
            @RequestParam int pageSize) {
        logger.info("Fetching contract approvals by start time, page: {}, size: {}", currentPage, pageSize);
        com.baomidou.mybatisplus.extension.plugins.pagination.Page<ContractApproval> page = contractService.getPageByStartTime(currentPage, pageSize);
        return ResponseEntity.ok(page);
    }

    // 根据合同ID获取合同审批记录
    @GetMapping("/by-contract-id/{contractId}")
    public ResponseEntity<List<ContractApproval>> getByContractId(@PathVariable Integer contractId) {
        logger.info("Fetching contract approvals by contract ID: {}", contractId);
        List<ContractApproval> approvals = contractService.getByContractId(contractId);
        return ResponseEntity.ok(approvals);
    }

    // 根据用户ID获取合同审批记录
    @GetMapping("/by-user-id/{userId}")
    public ResponseEntity<List<ContractApproval>> getByUserId(@PathVariable Integer userId) {
        logger.info("Fetching contract approvals by user ID: {}", userId);
        List<ContractApproval> approvals = contractService.getByUserId(userId);
        return ResponseEntity.ok(approvals);
    }

    // 根据状态获取合同审批记录
    @GetMapping("/by-status/{status}")
    public ResponseEntity<List<ContractApproval>> getByStatus(@PathVariable int status) {
        logger.info("Fetching contract approvals by status: {}", status);
        List<ContractApproval> approvals = contractService.getByStatus(status);
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
