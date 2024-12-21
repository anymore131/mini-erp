package cn.edu.zust.se.service.impl;

import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.po.ContractTemplate;
import cn.edu.zust.se.mapper.ContractMapper;
import cn.edu.zust.se.service.IContractService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContractServiceImpl extends ServiceImpl<ContractMapper, Contract> implements IContractService {
    private final ContractMapper contractMapper;
    private Integer creatorId;

    public Contract createContract(Contract contract) {
        contractMapper.insert(contract);
        return contract;
    }

    @Override
    public Contract getTContractById(Integer id) {
        if (contractMapper.selectById(id) != null) {
            return contractMapper.selectById(id);
        }
        return null;
    }

    @Override
    public List<Contract> getContractByUserId(Integer userId) {
        if (contractMapper.selectByUserId(userId) != null) {
            return contractMapper.selectByUserId(userId);
        }
        return null;
    }

    @Override
    public Contract updateContract(Integer id, Contract updatedContract) {
        contractMapper.updateById(updatedContract);
        return updatedContract;
    }

    @Override
    public Page<Contract> getContract(String category, String keyword, Page page) {
        QueryWrapper<Contract> queryWrapper = new QueryWrapper<>();
        if (category != null && !category.isEmpty()) {
            queryWrapper.eq("category", category);
        }
        if (keyword != null && !keyword.isEmpty()) {
            queryWrapper.like("content", keyword);
        }
        return page(page, queryWrapper);
    }

    @Override
    public void deleteContract(Integer id) {
        contractMapper.deleteById(id);
    }

    @Override
    public void changeContractStatus(Integer id, boolean enabled) {
        Contract contract = contractMapper.selectById(id);
        if(enabled){
            contract.setStatus(String.valueOf(1));
        }else{
            contract.setStatus(String.valueOf(2));
        }
    }

    @Override
    public void setCreator(Integer userId) {
        this.creatorId = userId;
    }
}
