package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.po.Order;
import cn.edu.zust.se.entity.query.ContractQuery;
import cn.edu.zust.se.entity.query.OrderQuery;
import cn.edu.zust.se.entity.vo.ContractVo;
import cn.edu.zust.se.entity.vo.OrderVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

public interface IContractService  extends IService<Contract> {
    //创建合同
    Integer createContract(Contract contract);
    //根据id获取合同信息
    ContractVo getTContractById(Integer id);
    //根据number获取合同信息
    ContractVo getContractByNumber(String number);
    //根据用户id获取用户创建合同信息
    List<ContractVo> getContractByUserId(Integer userId);
    //获取合同列表
    PageDto<ContractVo> getContract(ContractQuery contractQuery);
    //合同草稿
    Integer backDraft(Integer id);
    //合同审批
    Integer PendingContract(Integer id);
    //合同审批通过
    Integer ApproveContract(Integer id);
    //合同审批拒绝
    Integer RejectContract(Integer id);
    //合同完成
    Integer CompleteContract(Integer id);
    //合同取消
    Integer CancelledContract(Integer id);
    //删除合同
    void deleteContract(Integer id);
    //合同状态变更
    void updateContractStatus(Integer id,int status);
}
