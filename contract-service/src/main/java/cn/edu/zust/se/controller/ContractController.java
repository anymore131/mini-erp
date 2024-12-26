package cn.edu.zust.se.controller;

import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.query.ContractQuery;
import cn.edu.zust.se.entity.vo.ContractVo;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.service.IContractLogService;
import cn.edu.zust.se.service.IContractService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/contract")
@AllArgsConstructor
public class ContractController {
    private final IContractService contractService;
    private final IContractLogService contractLogService;
    /**
     * 创建合同
     */
    @PostMapping(value = "/create")
    public SaResult createContract(@RequestBody Contract contract) {
        Integer i = contractService.createContract(contract);
        if (i == null){
            contractLogService.addLog(contract.getId(),contract.getUserId(),"创建合同","创建合同失败");
            return SaResult.error("合同添加失败！");
        }
        contractLogService.addLog(contract.getId(),contract.getUserId(),"创建合同","创建合同成功");
        return SaResult.ok("合同添加成功！").setData(i);
    }

    /**
     * 根据id获取合同信息
     */
    @GetMapping(value = "/get/{id}")
    public SaResult getContractById(@PathVariable Integer id) {
        ContractVo contract = contractService.getTContractById(id);
        if (contract == null) {
            contractLogService.addLog(id,null,"获取合同信息","获取合同信息失败");
            throw new InvalidInputException("合同信息为空！");
        }
        contractLogService.addLog(id,contract.getUserId(),"获取合同信息","获取合同信息成功");
        return SaResult.data(contract).setMsg("查询成功！");
    }

    /**
     * 根据用户id获取用户创建合同信息
     */
    @RequestMapping("/page")
    public SaResult pageContract(@RequestBody ContractQuery contractQuery) {
        if (contractQuery.getPageNum() == null || contractQuery.getPageSize() == null) {
            throw new InvalidInputException("页码和页大小不能为空！");
        }
        contractLogService.addLog(null,null,"分页获取合同信息","获取合同信息成功");
        return SaResult.data(contractService.getContract(contractQuery)).setMsg("查询成功！");
    }

    @RequestMapping("/pending/{id}")
    public SaResult pendingContract(@PathVariable("id") Integer id) {
        if (contractService.PendingContract(id) != null){
            contractLogService.addLog(id,null,"合同状态修改待检验","合同状态修改待检验成功");
            return SaResult.ok("合同状态修改待检验成功！");
        }
        contractLogService.addLog(id,null,"合同状态修改待检验","合同状态修改待检验失败");
        return SaResult.error("合同状态修改待检验失败！");
    }

    @RequestMapping("/approve/{id}")
    public SaResult approveContract(@PathVariable("id") Integer id) {
        if (contractService.ApproveContract(id) != null){
            contractLogService.addLog(id,null,"合同状态修改待检验","合同状态修改待检验成功");
            return SaResult.ok("合同状态检验通过成功！");
        }
        contractLogService.addLog(id,null,"合同状态修改待检验","合同状态修改待检验失败");
        return SaResult.error("合同状态检验通过失败！");
    }

    @RequestMapping("/reject/{id}")
    public SaResult rejectContract(@PathVariable("id") Integer id) {
        if (contractService.RejectContract(id) != null){
            contractLogService.addLog(id,null,"合同状态修改待检验","合同状态修改待检验成功");
            return SaResult.ok("合同状态检验不通过成功！");
        }
        contractLogService.addLog(id,null,"合同状态修改待检验","合同状态修改待检验失败");
        return SaResult.error("合同状态检验不通过失败！");
    }

    @RequestMapping("/complete/{id}")
    public SaResult completeContract(@PathVariable("id") Integer id) {
        if (contractService.CompleteContract(id) != null){
            contractLogService.addLog(id,null,"合同状态修改待检验","合同状态修改待检验成功");
            return SaResult.ok("合同完成成功！");
        }
        contractLogService.addLog(id,null,"合同状态修改待检验","合同状态修改待检验失败");
        return SaResult.error("合同完成失败！");
    }

    @RequestMapping("/cancel/{id}")
    public SaResult cancelContract(@PathVariable("id") Integer id) {
        if (contractService.CancelledContract(id) != null){
            contractLogService.addLog(id,null,"合同状态修改待检验","合同状态修改待检验成功");
            return SaResult.ok("合同取消成功！");
        }
        contractLogService.addLog(id,null,"合同状态修改待检验","合同状态修改待检验失败");
        return SaResult.error("合同取消失败！");
    }
    /**
     * 删除合同
     */
    @DeleteMapping(value = "/delete/{id}")
    public SaResult deleteContract(@PathVariable Integer id) {
        contractService.deleteContract(id);
        contractLogService.addLog(id,null,"删除合同","删除合同成功");
        return SaResult.ok("删除成功！");
    }

}
