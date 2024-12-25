package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.po.ContractApproval;
import cn.edu.zust.se.entity.vo.ContractApprovalVo;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.UserFeignServiceI;
import cn.edu.zust.se.mapper.ContractApprovalMapper;
import cn.edu.zust.se.service.IContractApprovalService;
import cn.edu.zust.se.service.IContractService;
import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

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
    private final IContractService contractService;
    private final UserFeignServiceI userFeignService;

    @Override
    public List<ContractApprovalVo> getAllContractApprovals() {
        List<ContractApproval> contractApprovals = contractApprovalMapper.selectAll();
        List<ContractApprovalVo> contractApprovalVos = BeanUtil.copyToList(contractApprovals, ContractApprovalVo.class);
        return contractApprovalVos;
    }

    @Override
    public ContractApprovalVo getContractApprovalById(Integer id) {
        checkInput(id,"参数为空");
        ContractApproval contractApproval = contractApprovalMapper.selectById(id);
        ContractApprovalVo contractApprovalVo = BeanUtil.copyProperties(contractApproval, ContractApprovalVo.class);
        return contractApprovalVo;
    }

    @Override
    public List<ContractApprovalVo> getByContractId(Integer contractId) {
        checkInput(contractId,"参数为空");
        checkAdmin();
        ContractApproval contract = contractApprovalMapper.selectById(contractId);
        checkInput(contract, "合同不存在");
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(contract.getUserId())){
            throw new InvalidInputException("权限不足！");
        }
        QueryWrapper<ContractApproval> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("contract_id", contractId).orderBy(true, false,"create_time");
        List<ContractApproval> contractApprovals = list(queryWrapper);
        if (contractApprovals == null){
            return null;
        }
        List<ContractApprovalVo> vos = new ArrayList<>();
        for (ContractApproval contractApproval : contractApprovals){
            ContractApprovalVo vo = BeanUtil.copyProperties(contractApproval, ContractApprovalVo.class);
            vo.setContractId(contract.getContractId());
            vo.setUserName(userFeignService.getUserNameById(contractApproval.getUserId()));
            vos.add(vo);
        }
        return vos;
    }

    @Override
    public List<ContractApprovalVo> getByUserId(Integer userId) {
        checkInput(userId,"参数为空");
        checkAdmin();
        List<ContractApproval> contractApprovals = contractApprovalMapper.selectByUserId(userId);
        List<ContractApprovalVo> contractApprovalVos = BeanUtil.copyToList(contractApprovals, ContractApprovalVo.class);
        return contractApprovalVos;
    }

//    @Override
//    public PageDto<ContractApprovalVo> getContract(ContractApprovalQuery contractApprovalQuery) {
//        Page<ContractApproval> page = contractApprovalQuery.toMpPage(contractApprovalQuery.getSortBy(), contractApprovalQuery.isAsc());
//        if (contractApprovalQuery.getStatus() != null){
//            lambdaQuery()
//                    .eq(contractApprovalQuery.getUserId() != null,ContractApproval::getUserId, contractApprovalQuery.getUserId())
//                    .eq(contractApprovalQuery.getStatus() != null,ContractApproval::getStatus, ContractApprovalEnum.fromMessage(contractApprovalQuery.getStatus()))
//                    .like(contractApprovalQuery.getApprovalOpinion() != null,ContractApproval::getApprovalOpinion, contractApprovalQuery.getApprovalOpinion())
//                    .ge(contractApprovalQuery.getContractId() != null,ContractApproval::getContractId, contractApprovalQuery.getContractId())
//                    .page(page);
//        }else{
//            lambdaQuery()
//                    .eq(contractApprovalQuery.getUserId() != null,ContractApproval::getUserId, contractApprovalQuery.getUserId())
//                    .like(contractApprovalQuery.getApprovalOpinion() != null,ContractApproval::getApprovalOpinion, contractApprovalQuery.getApprovalOpinion())
//                    .ge(contractApprovalQuery.getContractId() != null,ContractApproval::getContractId, contractApprovalQuery.getContractId())
//                    .page(page);
//        }
//        PageDto<ContractApprovalVo> voPageDto = new PageDto<>();
//        voPageDto.setTotal(page.getTotal());
//        voPageDto.setPages(page.getPages());
//        List<ContractApproval> records = page.getRecords();
//        if (CollUtil.isEmpty(records)){
//            voPageDto.setList(Collections.emptyList());
//            return voPageDto;
//        }
//        List<ContractApprovalVo> vos = new ArrayList<>();
//        for (ContractApproval record : records){
//            int status = record.getStatus();
//            ContractApprovalVo contractApprovalVo = BeanUtil.copyProperties(record, ContractApprovalVo.class);
//            contractApprovalVo.setStatus(ContractApprovalEnum.fromCode(status).toString());
//            vos.add(contractApprovalVo);
//        }
//        voPageDto.setList(vos);
//        return voPageDto;
//    }
//

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
    public boolean passContractApproval(Integer id, String approvalOpinion) {
        checkInput(id, "参数为空");
        checkAdmin();
        ContractApproval contractApproval = getById(id);
        checkInput(contractApproval, "审批记录不存在");
        if (!Objects.equals(contractApproval.getStatus(), 0)){
            throw new InvalidInputException("审批记录已结束！");
        }
        contractApproval.setApprovalOpinion(approvalOpinion);
        contractApproval.setStatus(1);
        return updateById(contractApproval);
    }

    @Override
    public boolean rejectContractApproval(Integer id, String approvalOpinion) {
        checkInput(id, "参数为空");
        checkAdmin();
        ContractApproval contractApproval = getById(id);
        checkInput(contractApproval, "审批记录不存在");
        if (!Objects.equals(contractApproval.getStatus(), 0)){
            throw new InvalidInputException("审批记录已结束！");
        }
        contractApproval.setApprovalOpinion(approvalOpinion);
        contractApproval.setStatus(2);
        return updateById(contractApproval);
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

    private <T> void checkInput(T t,String s){
        if (t == null){
            throw new InvalidInputException(s);
        }
    }

    private void checkAdmin(){
        if (!StpUtil.hasRole("admin")){
            throw new InvalidInputException("权限不足！");
        }
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
