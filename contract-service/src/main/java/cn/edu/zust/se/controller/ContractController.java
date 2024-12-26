package cn.edu.zust.se.controller;

import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.query.ContractQuery;
import cn.edu.zust.se.entity.vo.ContractVo;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.service.IContractService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

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
        Integer i = contractService.createContract(contract);
        if (i == null){
            return SaResult.error("合同添加失败！");
        }
        return SaResult.ok("合同添加成功！").setData(i);
    }

    /**
     * 根据id获取合同信息
     */
    @GetMapping(value = "/get/{id}")
    public SaResult getContractById(@PathVariable Integer id) {
        ContractVo contract = contractService.getTContractById(id);
        if (contract == null) {
            throw new InvalidInputException("合同信息为空！");
        }
        return SaResult.data(contract).setMsg("查询成功！");
    }

    /**
     * 根据用户id获取用户创建合同信息
     */
    @RequestMapping("/page")
    public SaResult pageContract(@RequestBody ContractQuery contractQuery) {
        return SaResult.data(contractService.getContract(contractQuery)).setMsg("查询成功！");
    }

    @RequestMapping("/pending/{id}")
    public SaResult pendingOrder(@PathVariable("id") Integer id) {
        if (contractService.PendingContract(id) != null){
            return SaResult.ok("合同状态修改待检验成功！");
        }
        return SaResult.error("合同状态修改待检验失败！");
    }

    @RequestMapping("/approve/{id}")
    public SaResult approveOrder(@PathVariable("id") Integer id) {
        if (contractService.ApproveContract(id) != null){
            return SaResult.ok("合同状态检验通过成功！");
        }
        return SaResult.error("合同状态检验通过失败！");
    }

    @RequestMapping("/reject/{id}")
    public SaResult rejectOrder(@PathVariable("id") Integer id) {
        if (contractService.RejectContract(id) != null){
            return SaResult.ok("合同状态检验不通过成功！");
        }
        return SaResult.error("合同状态检验不通过失败！");
    }

    @RequestMapping("/complete/{id}")
    public SaResult completeOrder(@PathVariable("id") Integer id) {
        if (contractService.CompleteContract(id) != null){
            return SaResult.ok("合同完成成功！");
        }
        return SaResult.error("合同完成失败！");
    }

    @RequestMapping("/cancel/{id}")
    public SaResult cancelOrder(@PathVariable("id") Integer id) {
        if (contractService.CancelledContract(id) != null){
            return SaResult.ok("合同取消成功！");
        }
        return SaResult.error("合同取消失败！");
    }
    /**
     * 删除合同
     */
    @DeleteMapping(value = "/delete/{id}")
    public SaResult deleteContract(@PathVariable Integer id) {
        contractService.deleteContract(id);
        return SaResult.ok("删除成功！");
    }

}
