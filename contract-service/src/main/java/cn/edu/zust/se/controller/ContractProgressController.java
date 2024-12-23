package cn.edu.zust.se.controller;

import cn.edu.zust.se.entity.po.ContractProgress;
import cn.edu.zust.se.service.IContractProgressService;
import lombok.AllArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
@RequestMapping("/contract-progress")
@AllArgsConstructor
public class ContractProgressController {
    private static final Logger logger = LoggerFactory.getLogger(ContractProgressController.class);
    private final IContractProgressService contractProgressService;

    // 获取所有合同进度记录
    @GetMapping
    public List<ContractProgress> getAllContractProgresses() {
        logger.info("Fetching all contract progresses");
        return contractProgressService.getAllContractProgresses();
    }

    // 根据 ID 获取单个合同进度记录
    @GetMapping("/{id}")
    public ContractProgress getContractProgressById(@PathVariable Integer id) {
        logger.info("Fetching contract progress with ID: {}", id);
        return contractProgressService.getContractProgressById(id);
    }

    // 创建新的合同进度记录
    @PostMapping
    public ContractProgress createContractProgress(@RequestBody ContractProgress contractProgress) {
        logger.info("Creating new contract progress: {}", contractProgress);
        return contractProgressService.createContractProgress(contractProgress);
    }

    // 更新合同进度记录
    @PutMapping("/{id}")
    public ContractProgress updateContractProgress(@PathVariable Integer id, @RequestBody ContractProgress contractProgress) {
        contractProgress.setId(id); // 确保更新的记录 ID 是正确的
        logger.info("Updating contract progress with ID: {}, new data: {}", id, contractProgress);
        return contractProgressService.updateContractProgress(contractProgress);
    }

    // 删除合同进度记录
    @DeleteMapping("/{id}")
    public void deleteContractProgress(@PathVariable Integer id) {
        logger.info("Deleting contract progress with ID: {}", id);
        contractProgressService.deleteContractProgress(id);
    }
}
