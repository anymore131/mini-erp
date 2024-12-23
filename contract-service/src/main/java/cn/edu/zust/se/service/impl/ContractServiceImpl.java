package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Client;
import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.query.ContractQuery;
import cn.edu.zust.se.entity.vo.ClientVo;
import cn.edu.zust.se.entity.vo.ContractVo;
import cn.edu.zust.se.enums.ClientStatusEnum;
import cn.edu.zust.se.enums.ContractStatusEnum;
import cn.edu.zust.se.exception.ForbiddenException;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.mapper.ContractMapper;
import cn.edu.zust.se.service.IContractService;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class ContractServiceImpl extends ServiceImpl<ContractMapper, Contract> implements IContractService {
    private final ContractMapper contractMapper;
//    private Integer currentUserId = StpUtil.getLoginIdAsInt();

    public ContractVo createContract(Contract contract) {
        if (contract.getUserId() == null){
            throw new InvalidInputException("用户不能为空！");
        }
        if (contract.getName() == null || contract.getName().isEmpty()){
            throw new InvalidInputException("合同名称不能为空！");
        }
//        if (!contract.getUserId().equals(currentUserId) && !StpUtil.hasRole("admin")){
//            throw new ForbiddenException("无权添加其他用户的客户信息！");
//        }
        if(contractMapper.getContractByName(contract.getName()) != null){
            throw new InvalidInputException("合同名称重复！");
        }
        contract.setLastUpdate(LocalDateTime.now());
        contractMapper.insertContract(contract.getClientId(), contract.getUserId(), contract.getName(), contract.getNumber(), contract.getOrderId(), contract.getContent(), contract.getSignTime(), contract.getStartTime(), contract.getEndTime(), contract.getTotalAmout(), contract.getLastUpdate());
        ContractVo contractVo = BeanUtil.copyProperties(contract, ContractVo.class);
        return  contractVo;
    }

    @Override
    public ContractVo getTContractById(Integer id) {
        if (contractMapper.selectById(id) != null) {
           Contract contract = contractMapper.selectById(id);
           return BeanUtil.copyProperties(contract, ContractVo.class);
        }
        return null;
    }

    @Override
    public List<ContractVo> getContractByUserId(Integer userId) {
        if (contractMapper.selectByUserId(userId) != null) {
            List<Contract> contracts = contractMapper.selectByUserId(userId);
            List<ContractVo> contractVos = BeanUtil.copyToList(contracts, ContractVo.class);
            return contractVos;
        }
        return null;
    }

    @Override
    public ContractVo updateContract(Integer id, Contract updatedContract) {
        if (updatedContract.getUserId() == null){
            throw new InvalidInputException("用户不能为空！");
        }
        if (updatedContract.getName() == null || updatedContract.getName().isEmpty()){
            throw new InvalidInputException("合同名称不能为空！");
        }
//        if (!updatedContract.getUserId().equals(currentUserId) && !StpUtil.hasRole("admin")){
//            throw new ForbiddenException("无权添加其他用户的客户信息！");
//        }
        if(contractMapper.getContractByName(updatedContract.getName()) != null){
            throw new InvalidInputException("合同名称重复！");
        }
        int version = contractMapper.getVersion(id);
        contractMapper.changeContract(updatedContract.getClientId(),
                updatedContract.getUserId(), updatedContract.getName(),
                updatedContract.getNumber(), updatedContract.getOrderId(),
                updatedContract.getContent(), updatedContract.getSignTime(),
                updatedContract.getStartTime(), updatedContract.getEndTime(),
                updatedContract.getTotalAmout(), updatedContract.getLastUpdate(),version+1);
        contractMapper.updateContract(id);
        ContractVo contractVo = BeanUtil.copyProperties(updatedContract, ContractVo.class);
        return contractVo;
    }

    @Override
    public PageDto<ContractVo> getContract(ContractQuery contractQuery) {
        Page<Contract> page = contractQuery.toMpPage(contractQuery.getSortBy(), contractQuery.isAsc());
        if (contractQuery.getStatus() != null){
            lambdaQuery()
                    .eq(contractQuery.getUserId() != null,Contract::getUserId, contractQuery.getUserId())
                    .eq(contractQuery.getStatus() != null,Contract::getStatus, ContractStatusEnum.fromMessage(contractQuery.getStatus()))
                    .like(contractQuery.getName() != null,Contract::getName, contractQuery.getName())
                    .ge(contractQuery.getClientId() != null,Contract::getClientId, contractQuery.getClientId())
                    .page(page);
        }else{
            lambdaQuery()
                    .eq(contractQuery.getUserId() != null,Contract::getUserId, contractQuery.getUserId())
                    .like(contractQuery.getName() != null,Contract::getName, contractQuery.getName())
                    .ge(contractQuery.getClientId() != null,Contract::getClientId, contractQuery.getClientId())
                    .page(page);
        }
        PageDto<ContractVo> voPageDto = new PageDto<>();
        voPageDto.setTotal(page.getTotal());
        voPageDto.setPages(page.getPages());
        List<Contract> records = page.getRecords();
        if (CollUtil.isEmpty(records)){
            voPageDto.setList(Collections.emptyList());
            return voPageDto;
        }
        List<ContractVo> vos = new ArrayList<>();
        for (Contract record : records){
            int status = record.getStatus();
            ContractVo contractVo = BeanUtil.copyProperties(record, ContractVo.class);
            contractVo.setStatus(ContractStatusEnum.fromCode(status).toString());
            vos.add(contractVo);
        }
        voPageDto.setList(vos);
        return voPageDto;
    }

    @Override
    public void deleteContract(Integer id) {
        contractMapper.deleteById(id);
    }

    @Override
    public void updateContractStatus(Integer id,int status) {
        contractMapper.updateStatus(id,status);
    }

}
