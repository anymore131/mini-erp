package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.po.Contract;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Date;
import java.util.List;

public interface IContractService  extends IService<Contract> {
    //创建合同
    Contract createContract(Contract contract);
    //根据id获取合同信息
    Contract getTContractById(Integer id);
    //根据用户id获取用户创建合同信息
    List<Contract> getContractByUserId(Integer userId);
    //更新合同
    Contract updateContract(Integer id, Contract updatedContract);
    //获取合同列表
    Page<Contract> getContract(String category, String keyword, Page page);
    //删除合同
    void deleteContract(Integer id);
    //合同状态变更
    void updateContractStatus(Integer id,int status);
    //设置创建者
    void setCreator(Integer userId);
}
