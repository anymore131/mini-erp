package cn.edu.zust.se.controller;

import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.service.IContractService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.alibaba.nacos.api.model.v2.Result;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/contract")
@AllArgsConstructor
public class ContractController {
    private final IContractService contractService;

    /**
     * 创建合同
     */
    @PostMapping(value = "/create")
    public Result<?> createContract(@RequestBody Contract contract) {
        Contract createdContract = contractService.createContract(contract);
        return Result.success(createdContract);
    }

    /**
     * 根据id获取合同信息
     */
    @GetMapping(value = "/{id}")
    public Result<?> getContractById(@PathVariable Integer id) {
        Contract contract = contractService.getTContractById(id);
        if (contract == null) {
            return Result.failure("Contract not found");
        }
        return Result.success(contract);
    }

    /**
     * 根据用户id获取用户创建合同信息
     */
    @GetMapping(value = "/user/{userId}")
    public Result<?> getContractByUserId(@PathVariable Integer userId) {
        List<Contract> contracts = contractService.getContractByUserId(userId);
        return Result.success(contracts);
    }

    /**
     * 更新合同
     */
    @PutMapping(value = "/update/{id}")
    public Result<?> updateContract(@PathVariable Integer id, @RequestBody Contract updatedContract) {
        Contract updated = contractService.updateContract(id, updatedContract);
        if (updated == null) {
            return Result.failure("Contract not found");
        }
        return Result.success(updated);
    }

    /**
     * 获取合同列表
     */
    @GetMapping(value = "/list")
    public Result<?> getContractList(@RequestParam(required = false) String category,
                                     @RequestParam(required = false) String keyword,
                                     @RequestParam(name = "pageNo", defaultValue = "1") Integer pageNo,
                                     @RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize) {
        Page<Contract> page = new Page<>(pageNo, pageSize);
        Page<Contract> contractPage = contractService.getContract(category, keyword, page);
        return Result.success(contractPage);
    }

    /**
     * 删除合同
     */
    @DeleteMapping(value = "/delete/{id}")
    public Result<?> deleteContract(@PathVariable Integer id) {
        contractService.deleteContract(id);
        return Result.success("Contract deleted successfully");
    }

    /**
     * 改变合同状态
     */
    @PutMapping(value = "/status/{id}")
    public Result<?> changeContractStatus(@PathVariable Integer id, @RequestParam int status) {
        contractService.updateContractStatus(id,status);
        return Result.success("Contract status updated successfully");
    }

    /**
     * 设置创建者
     */
    @PutMapping(value = "/creator/{userId}")
    public Result<?> setCreator(@PathVariable Integer userId) {
        contractService.setCreator(userId);
        return Result.success("Creator set successfully");
    }
}
