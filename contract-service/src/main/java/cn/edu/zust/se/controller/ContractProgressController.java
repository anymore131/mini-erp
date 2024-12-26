package cn.edu.zust.se.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.ContractProgress;
import cn.edu.zust.se.entity.query.ContractProgressQuery;
import cn.edu.zust.se.service.IContractProgressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 合同进度控制器
 */
@RestController
@RequestMapping("/contract-progress")
public class ContractProgressController {
    private static final org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(ContractProgressController.class);

    @Autowired
    private IContractProgressService contractProgressService;

    @PostMapping("/page")
    public SaResult page(@RequestBody ContractProgressQuery query) {
        logger.info("分页查询合同进度, 参数: {}", query);
        return SaResult.data(contractProgressService.pageContractProgresses(query))
                .setMsg("查询成功");
    }

    @GetMapping("/{id}")
    public SaResult get(@PathVariable Integer id) {
        logger.info("获取合同进度详情, ID: {}", id);
        return SaResult.data(contractProgressService.getContractProgressVoById(id))
                .setMsg("查询成功");
    }

    @PostMapping
    public SaResult add(@RequestBody ContractProgress contractProgress) {
        logger.info("创建合同进度: {}", contractProgress);
        return SaResult.data(contractProgressService.addContractProgress(contractProgress))
                .setMsg("创建成功");
    }

    @PutMapping("/{id}")
    public SaResult update(@PathVariable Integer id, @RequestBody ContractProgress contractProgress) {
        logger.info("更新合同进度, ID: {}, 内容: {}", id, contractProgress);
        contractProgress.setId(id);
        return SaResult.data(contractProgressService.updateContractProgress(contractProgress))
                .setMsg("更新成功");
    }

    @DeleteMapping("/{id}")
    public SaResult delete(@PathVariable Integer id) {
        logger.info("删除合同进度, ID: {}", id);
        return SaResult.data(contractProgressService.deleteContractProgress(id))
                .setMsg("删除成功");
    }

    @GetMapping("/latest/{contractId}")
    public SaResult getLatest(@PathVariable Integer contractId) {
        logger.info("获取最新合同进度, 合同ID: {}", contractId);
        return SaResult.data(contractProgressService.getLatestProgressByContractId(contractId))
                .setMsg("查询成功");
    }
}
