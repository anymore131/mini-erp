package cn.edu.zust.se.service.impl;

import cn.edu.zust.se.entity.po.ContractApproval;
import cn.edu.zust.se.mapper.ContractApprovalMapper;
import cn.edu.zust.se.service.IContractApprovalService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    public List<ContractApproval> getAllContractApprovals() {
        return contractApprovalMapper.selectAll();
    }

    @Override
    public ContractApproval getContractApprovalById(Integer id) {
        return contractApprovalMapper.selectById(id);
    }

    @Override
    public List<ContractApproval> getByContractId(Integer contractId) {
        return contractApprovalMapper.selectByContractId(contractId);
    }

    @Override
    public List<ContractApproval> getByUserId(Integer userId) {
        return contractApprovalMapper.selectByUserId(userId);
    }

    @Override
    public Page<ContractApproval> getPageByStartTime(int currentPage, int pageSize) {
        Page<ContractApproval> page = new Page<>(currentPage, pageSize);
        return contractApprovalMapper.selectPageByStartTime(page);
    }

    @Override
    public Page<ContractApproval> selectPageByStartTime(Integer contractId, Integer userId, int status, int pageNo, int pageSize) {
        Page<ContractApproval> page = new Page<>(pageNo, pageSize);
        return contractApprovalMapper.selectPageByStartTimeAsc(contractId, userId, status, pageNo, pageSize);
    }

    @Override
    public List<ContractApproval> getByStatus(int status) {
        return contractApprovalMapper.selectByStatus(status);
    }

    @Override
    @Transactional
    public ContractApproval createContractApproval(ContractApproval contractApproval) {
        return executeWithLogging(() -> {
            int result = contractApprovalMapper.insert(contractApproval);
            return result > 0 ? contractApproval : null;
        }, "create", contractApproval);
    }

    @Override
    @Transactional
    public ContractApproval updateContractApproval(ContractApproval contractApproval) {
        return executeWithLogging(() -> {
            int result = contractApprovalMapper.updateById(contractApproval);
            return result > 0 ? contractApproval : null;
        }, "update", contractApproval);
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
