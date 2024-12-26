package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.po.ContractApproval;
import cn.edu.zust.se.entity.po.Order;
import cn.edu.zust.se.entity.vo.ContractApprovalVo;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.UserFeignServiceI;
import cn.edu.zust.se.mapper.ContractApprovalMapper;
import cn.edu.zust.se.service.IContractApprovalService;
import cn.edu.zust.se.service.IContractLogService;
import cn.edu.zust.se.service.IContractService;
import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
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
@Transactional
public class ContractApprovalServiceImpl extends ServiceImpl<ContractApprovalMapper, ContractApproval> implements IContractApprovalService {
    private final ContractApprovalMapper contractApprovalMapper;
    private final IContractService contractService;
    private final IContractLogService contractLogService;
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
    public ContractApprovalVo getByOrderId(Integer orderId) {
        checkInput(orderId,"参数为空");
        ContractApproval contractApproval = contractApprovalMapper.selectByOrderId(orderId);
        ContractApprovalVo contractApprovalVo = BeanUtil.copyProperties(contractApproval, ContractApprovalVo.class);
        return contractApprovalVo;
    }

    @Override
    public List<ContractApprovalVo> getByUserId(Integer userId) {
        checkInput(userId,"参数为空");
        checkAdmin();
        List<ContractApproval> contractApprovals = contractApprovalMapper.selectByUserId(userId);
        List<ContractApprovalVo> contractApprovalVos = BeanUtil.copyToList(contractApprovals, ContractApprovalVo.class);
        return contractApprovalVos;
    }


    @Override
    public List<ContractApprovalVo> getByStatus(int status) {
        List<ContractApproval> contractApprovals = contractApprovalMapper.selectByStatus(status);
        List<ContractApprovalVo> contractApprovalVos = BeanUtil.copyToList(contractApprovals, ContractApprovalVo.class);
        return contractApprovalVos;
    }

    @Override
    public boolean createContractApproval(ContractApproval contractApproval) {
        checkInput(contractApproval, "参数为空");
        checkAdmin();
        checkInput(contractApproval.getContractId(),"合同id不能为空！");
        checkInput(contractApproval.getOrderId(), "订单id不能为空！");
        checkInput(contractApproval.getUserId(), "审批人不能为空！");
        checkInput(contractApprovalMapper.selectById(contractApproval.getContractId()),"订单不存在！");
        contractApproval.setStartTime(LocalDateTime.now()).setIsDelete(0);
        boolean b = save(contractApproval);
        String result = "PASS".equals(contractApproval.getStatus()) ? "通过" : "不通过";
        contractLogService.addLog(contractApproval.getContractId(), contractApproval.getUserId(), "APPROVE",
                String.format("审批%s，意见：%s", result, contractApproval.getApprovalOpinion()));
        if (b && "PASS".equals(contractApproval.getStatus())){
            contractService.ApproveContract(contractApproval.getId());
        }else if (b && "REJECT".equals(contractApproval.getStatus())) {
            contractService.RejectContract(contractApproval.getId());
        }
        updateContractTime(contractApproval.getOrderId());
        return b;
    }

    @Override
    public ContractApprovalVo updateContractApproval(ContractApproval contractApproval) {
        checkInput(contractApproval.getId(), "参数为空");
        int result = contractApprovalMapper.updateById(contractApproval);
        if (result > 0){
            ContractApprovalVo contractApprovalVo = BeanUtil.copyProperties(contractApproval, ContractApprovalVo.class);
            return contractApprovalVo;
        }
        return null;
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
        contractApproval.setStatus("PASS");
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
        contractApproval.setStatus("REJECT");
        return updateById(contractApproval);
    }

    @Override
    public void deleteContractApproval(Integer id) {
        checkInput(id, "参数为空");
        contractApprovalMapper.deleteById(id);
    }

    @Override
    public void softDelete(Integer id) {
        contractApprovalMapper.softDeleteById(id);
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
    private void updateContractTime(Integer orderId){
        Contract contract = contractService.getById(orderId);
        contract.setLastUpdate(LocalDateTime.now());
        contractService.save(contract);
        contractLogService.addLog(contract.getId(), contract.getUserId(), "UPDATE", "更新合同时间");
    }
}
