package cn.edu.zust.se.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.query.ContractQuery;
import cn.edu.zust.se.entity.vo.ContractVo;
import cn.edu.zust.se.exception.ForbiddenException;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.service.IContractService;
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
    public SaResult createContract(@RequestBody Contract contract) {
        ContractVo createdContract = contractService.createContract(contract);
        return SaResult.data(createdContract).setMsg("添加成功！");
    }

    /**
     * 根据id获取合同信息
     */
    @GetMapping(value = "/{id}")
    public SaResult getContractById(@PathVariable Integer id) {
        ContractVo contract = contractService.getTContractById(id);
        if (contract == null) {
            throw new InvalidInputException("输入信息为空！");
        }
        return SaResult.data(contract);
    }

    /**
     * 根据用户id获取用户创建合同信息
     */
    @GetMapping(value = "/user/{userId}")
    public SaResult getContractByUserId(@PathVariable Integer userId) {
        List<ContractVo> contracts = contractService.getContractByUserId(userId);
        return SaResult.data(contracts);
    }

    /**
     * 更新合同
     */
    @PutMapping(value = "/update/{id}")
    public SaResult updateContract(@PathVariable Integer id, @RequestBody Contract updatedContract) {
        ContractVo updated = contractService.updateContract(id, updatedContract);
        if (updated == null) {
            throw new InvalidInputException("输入信息为空！");
        }
        return SaResult.data(updated).setMsg("更新成功！");
    }

    /**
     * 获取合同列表
     */
    @GetMapping(value = "/page/{id}")
    public SaResult getContractList(@PathVariable Integer id,
                                     @RequestBody(required = false) ContractQuery contractQuery) {
        if (contractQuery == null || id == null){
            throw new InvalidInputException("输入信息为空！");
        }
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(id)) {
            throw new ForbiddenException("无权查看其他用户的合同信息！");
        }
        if (contractQuery.getUserId() == null ) {
            throw new InvalidInputException("输入信息为空！");
        }
        if (!id.equals(contractQuery.getUserId())){
            throw new InvalidInputException("输入信息不一致！");
        }
        PageDto<ContractVo> contracts = contractService.getContract(contractQuery);
        return SaResult.data(contracts);
    }

    /**
     * 删除合同
     */
    @DeleteMapping(value = "/delete/{id}")
    public SaResult deleteContract(@PathVariable Integer id) {
        contractService.deleteContract(id);
        return SaResult.ok("删除成功！");
    }

    /**
     * 改变合同状态
     */
    @PutMapping(value = "/status/{id}")
    public SaResult changeContractStatus(@PathVariable Integer id, @RequestParam int status) {
        contractService.updateContractStatus(id,status);
        ContractVo contractVo = contractService.getTContractById(id);
        return SaResult.data(contractVo).setMsg("更新成功！");
    }
//
//    /**
//     * 设置创建者
//     */
//    @PutMapping(value = "/creator/{userId}")
//    public Result<?> setCreator(@PathVariable Integer userId) {
//        contractService.setCreator(userId);
//        return Result.success("Creator set successfully");
//    }
}
