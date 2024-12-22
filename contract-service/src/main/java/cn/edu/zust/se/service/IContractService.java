package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.query.ContractQuery;
import cn.edu.zust.se.entity.vo.ContractVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

public interface IContractService  extends IService<Contract> {
    //创建合同
    ContractVo createContract(Contract contract);
    //根据id获取合同信息
    ContractVo getTContractById(Integer id);
    //根据用户id获取用户创建合同信息
    List<ContractVo> getContractByUserId(Integer userId);
    //更新合同
    ContractVo updateContract(Integer id, Contract updatedContract);
    //获取合同列表
    PageDto<ContractVo> getContract(ContractQuery contractQuery);
    //删除合同
    void deleteContract(Integer id);
    //合同状态变更
    void updateContractStatus(Integer id,int status);
}
