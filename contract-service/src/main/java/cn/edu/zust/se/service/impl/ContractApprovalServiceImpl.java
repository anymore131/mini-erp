package cn.edu.zust.se.service.impl;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.po.ContractApproval;
import cn.edu.zust.se.entity.query.ContractApprovalQuery;
import cn.edu.zust.se.entity.query.ContractQuery;
import cn.edu.zust.se.entity.vo.ContractApprovalVo;
import cn.edu.zust.se.entity.vo.ContractVo;
import cn.edu.zust.se.enums.ContractApprovalEnum;
import cn.edu.zust.se.enums.ContractStatusEnum;
import cn.edu.zust.se.mapper.ContractApprovalMapper;
import cn.edu.zust.se.service.IContractApprovalService;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author author
 * @since 2024-12-21
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class ContractApprovalServiceImpl extends ServiceImpl<ContractApprovalMapper, ContractApproval> implements IContractApprovalService {
    private final ContractApprovalMapper contractApprovalMapper;

    @Override
    public List<ContractApprovalVo> getAllContractApprovals() {
        List<ContractApproval> contractApprovals = contractApprovalMapper.selectAll();
        List<ContractApprovalVo> contractApprovalVos = BeanUtil.copyToList(contractApprovals, ContractApprovalVo.class);
        return contractApprovalVos;
    }

    @Override
    public ContractApprovalVo getContractApprovalById(Integer id) {
        ContractApproval contractApproval = contractApprovalMapper.selectById(id);
        ContractApprovalVo contractApprovalVo = BeanUtil.copyProperties(contractApproval, ContractApprovalVo.class);
        return contractApprovalVo;
    }

    @Override
    public List<ContractApprovalVo> getByContractId(Integer contractId) {
        List<ContractApproval> contractApprovals = contractApprovalMapper.selectByContractId(contractId);
        List<ContractApprovalVo> contractApprovalVos = BeanUtil.copyToList(contractApprovals, ContractApprovalVo.class);
        return contractApprovalVos;
    }

    @Override
    public List<ContractApprovalVo> getByUserId(Integer userId) {
        List<ContractApproval> contractApprovals = contractApprovalMapper.selectByUserId(userId);
        List<ContractApprovalVo> contractApprovalVos = BeanUtil.copyToList(contractApprovals, ContractApprovalVo.class);
        return contractApprovalVos;
    }

    @Override
    public PageDto<ContractApprovalVo> getContract(ContractApprovalQuery contractApprovalQuery) {
        Page<ContractApproval> page = contractApprovalQuery.toMpPage(contractApprovalQuery.getSortBy(), contractApprovalQuery.isAsc());
        if (contractApprovalQuery.getStatus() != null){
            lambdaQuery()
                    .eq(contractApprovalQuery.getUserId() != null,ContractApproval::getUserId, contractApprovalQuery.getUserId())
                    .eq(contractApprovalQuery.getStatus() != null,ContractApproval::getStatus, ContractApprovalEnum.fromMessage(contractApprovalQuery.getStatus()))
                    .like(contractApprovalQuery.getApprovalOpinion() != null,ContractApproval::getApprovalOpinion, contractApprovalQuery.getApprovalOpinion())
                    .ge(contractApprovalQuery.getContractId() != null,ContractApproval::getContractId, contractApprovalQuery.getContractId())
                    .page(page);
        }else{
            lambdaQuery()
                    .eq(contractApprovalQuery.getUserId() != null,ContractApproval::getUserId, contractApprovalQuery.getUserId())
                    .like(contractApprovalQuery.getApprovalOpinion() != null,ContractApproval::getApprovalOpinion, contractApprovalQuery.getApprovalOpinion())
                    .ge(contractApprovalQuery.getContractId() != null,ContractApproval::getContractId, contractApprovalQuery.getContractId())
                    .page(page);
        }
        PageDto<ContractApprovalVo> voPageDto = new PageDto<>();
        voPageDto.setTotal(page.getTotal());
        voPageDto.setPages(page.getPages());
        List<ContractApproval> records = page.getRecords();
        if (CollUtil.isEmpty(records)){
            voPageDto.setList(Collections.emptyList());
            return voPageDto;
        }
        List<ContractApprovalVo> vos = new ArrayList<>();
        for (ContractApproval record : records){
            int status = record.getStatus();
            ContractApprovalVo contractApprovalVo = BeanUtil.copyProperties(record, ContractApprovalVo.class);
            contractApprovalVo.setStatus(ContractApprovalEnum.fromCode(status).toString());
            vos.add(contractApprovalVo);
        }
        voPageDto.setList(vos);
        return voPageDto;
    }

//    @Override
//    public PageDto<ContractApprovalVo> getPageByStartTime(int currentPage, int pageSize) {
//        Page<ContractApproval> page = new Page<>(currentPage, pageSize);
//        return contractApprovalMapper.selectPageByStartTime(page);
//    }
//
//    @Override
//    public PageDto<ContractApprovalVo> selectPageByStartTime(Integer contractId, Integer userId, int status, int pageNo, int pageSize) {
//        Page<ContractApproval> page = new Page<>(pageNo, pageSize);
//        return contractApprovalMapper.selectPageByStartTimeAsc(contractId, userId, status, pageNo, pageSize);
//    }

    @Override
    public List<ContractApprovalVo> getByStatus(int status) {
        List<ContractApproval> contractApprovals = contractApprovalMapper.selectByStatus(status);
        List<ContractApprovalVo> contractApprovalVos = BeanUtil.copyToList(contractApprovals, ContractApprovalVo.class);
        return contractApprovalVos;
    }

    @Override
    @Transactional
    public ContractApprovalVo createContractApproval(ContractApproval contractApproval) {
        ContractApprovalVo contractApprovalVo = BeanUtil.copyProperties(contractApproval, ContractApprovalVo.class);
        return executeWithLogging(() -> {
            int result = contractApprovalMapper.insert(contractApproval);
            return result > 0 ? contractApprovalVo : null;
        }, "create", contractApprovalVo);
    }

    @Override
    @Transactional
    public ContractApprovalVo updateContractApproval(ContractApproval contractApproval) {
        ContractApprovalVo contractApprovalVo = BeanUtil.copyProperties(contractApproval, ContractApprovalVo.class);
        return executeWithLogging(() -> {
            int result = contractApprovalMapper.updateById(contractApproval);
            return result > 0 ? contractApprovalVo : null;
        }, "update", contractApprovalVo);
    }

    @Override
    @Transactional
    public void deleteContractApproval(Integer id) {
        executeWithLogging(() -> {
            contractApprovalMapper.deleteById(id);
            return null;
        }, "delete", id);
    }

    @Override
    @Transactional
    public void softDelete(Integer id) {
        executeWithLogging(() -> {
            contractApprovalMapper.softDeleteById(id);
            return null;
        }, "soft delete", id);
    }

    private <T> T executeWithLogging(SupplierWithException<T> action, String actionName, Object... params) {
        try {
            T result = action.get();
            if (result != null) {
                log.info("ContractApproval {} successfully: {}", actionName, params[0]);
            } else {
                log.error("Failed to {} ContractApproval: {}", actionName, params[0]);
            }
            return result;
        } catch (Exception e) {
            log.error("Error {} ContractApproval: {}", actionName, params[0], e);
            throw new RuntimeException("Failed to " + actionName + " ContractApproval", e);
        }
    }

    @FunctionalInterface
    private interface SupplierWithException<T> {
        T get() throws Exception;
    }
}
