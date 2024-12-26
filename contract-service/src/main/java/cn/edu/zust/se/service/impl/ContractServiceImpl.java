package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.query.ContractQuery;
import cn.edu.zust.se.entity.vo.ContractVo;
import cn.edu.zust.se.enums.ContractStatusEnum;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.ClientFeignServiceI;
import cn.edu.zust.se.feign.UserFeignServiceI;
import cn.edu.zust.se.mapper.ContractMapper;
import cn.edu.zust.se.service.IContractLogService;
import cn.edu.zust.se.service.IContractService;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.*;

@Service
@RequiredArgsConstructor
@Transactional
public class ContractServiceImpl extends ServiceImpl<ContractMapper, Contract> implements IContractService {
    private final ContractMapper contractMapper;
    private final IContractLogService contractLogService;
    private final ClientFeignServiceI clientFeignService;
    private final UserFeignServiceI userFeignService;
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
    private static final Random random = new Random();

    public Integer createContract(Contract contract) {
        checkInput(contract,"合同不能为空！");
        checkInput(contract.getOrderId(), "订单不能为空！");
        checkInput(contract.getName(), "合同名称不能为空！");
        checkInput(contract.getClientId(), "客户不能为空！");
        checkInput(contract.getUserId(), "用户不能为空！");
        checkRoleAdmin(contract, "无权添加订单！");
        contract.setNumber(generateNumber());
        contract.setStatus("DRAFT");
        contract.setTotalAmout(BigDecimal.valueOf(0));
        contract.setStartTime(LocalDateTime.now());
        contract.setLastUpdate(LocalDateTime.now());
        contract.setIsDelete(0);
        save(contract);
        contractLogService.addLog(contract.getId(), contract.getUserId(), "CREATE", "创建合同");
        return contract.getId();
    }

    @Override
    public ContractVo getTContractById(Integer id) {
        checkInput(id,"id不能为空！");
        if (contractMapper.selectById(id) != null) {
            Contract contract = contractMapper.selectById(id);
            contractLogService.addLog(contract.getId(), contract.getUserId(), "SELECT", "查找信息");
            return BeanUtil.copyProperties(contract, ContractVo.class);
        }
        contractLogService.addLog(id, StpUtil.getLoginIdAsInt(), "SELECT", "查找信息");
        return null;
    }

    @Override
    public ContractVo getContractByNumber(String number) {
        checkInput(number,"合同号不能为空！");
        QueryWrapper<Contract> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("number",number);
        Contract contract = getOne(queryWrapper);
        if (contract == null){
            return null;
        }
        contractLogService.addLog(Integer.valueOf(number), StpUtil.getLoginIdAsInt(), "SELECT", "查找信息");
        return putContractVo(contract);
    }

    @Override
    public List<ContractVo> getContractByUserId(Integer userId) {
        checkInput(userId,"参数为空!");
        if (contractMapper.selectByUserId(userId) != null) {
            List<Contract> contracts = contractMapper.selectByUserId(userId);
            List<ContractVo> contractVos = new ArrayList<>();
            for (Contract contract : contracts) {
                ContractVo contractVo = putContractVo(contract);
                contractVos.add(contractVo);
            }
            contractLogService.addLog(userId, StpUtil.getLoginIdAsInt(), "SELECT", "查找信息");
            return contractVos;
        }
        contractLogService.addLog(userId, StpUtil.getLoginIdAsInt(), "SELECT", "查找信息");
        return null;
    }


    @Override
    public PageDto<ContractVo> getContract(ContractQuery contractQuery) {
        checkInput(contractQuery,"参数为空!");
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !contractQuery.getUserId().equals(currentUserId)){
            throw new InvalidInputException("无权查询订单！");
        }
        Page<Contract> page = contractQuery.toMpPage(contractQuery.getSortBy(), contractQuery.isAsc());
        if (contractQuery.getStartTime()!= null){
            contractQuery.setStartTime(contractQuery.getStartTime().substring(0,19).replace('T', ' '));

        }
        if (contractQuery.getLastUpdate()!= null){
            contractQuery.setLastUpdate(contractQuery.getLastUpdate().substring(0,19).replace('T', ' '));
        }
        lambdaQuery()
                .eq(contractQuery.getNumber() != null, Contract::getNumber, contractQuery.getNumber())
                .eq(contractQuery.getUserId() != null, Contract::getUserId, contractQuery.getUserId())
                .eq(contractQuery.getStatus() != null, Contract::getStatus, ContractStatusEnum.fromMessage(contractQuery.getStatus()))
                .like(contractQuery.getName() != null, Contract::getName, contractQuery.getName())
                .ge(contractQuery.getSignTime() != null, Contract::getSignTime, contractQuery.getSignTime())
                .ge(contractQuery.getStartTime() != null, Contract::getStartTime, contractQuery.getStartTime())
                .ge(contractQuery.getOrderId() != null, Contract::getOrderId, contractQuery.getOrderId())
                .ge(contractQuery.getContent() != null, Contract::getContent, contractQuery.getContent())
                .le(contractQuery.getLastUpdate() != null, Contract::getLastUpdate, contractQuery.getLastUpdate())
                .ge(contractQuery.getClientId() != null, Contract::getClientId, contractQuery.getClientId())
                .page(page);
        PageDto<ContractVo> voPageDto = new PageDto<>();
        voPageDto.setTotal(page.getTotal());
        voPageDto.setPages(page.getPages());
        List<Contract> records = page.getRecords();
        if (CollUtil.isEmpty(records)) {
            voPageDto.setList(Collections.emptyList());
            return voPageDto;
        }
        List<ContractVo> vos = new ArrayList<>();
        for (Contract record : records) {
            String status = record.getStatus();
            ContractVo contractVo = putContractVo(record);
            contractVo.setStatus(ContractStatusEnum.fromCode(Integer.parseInt(status)));
            vos.add(contractVo);
        }
        voPageDto.setList(vos);
        return voPageDto;
    }


    @Override
    public Integer backDraft(Integer id) {
        checkInput(id,"id不能为空！");
        Contract contract = getAndCheckContractLive(id);
        checkRoleAdmin(contract,"无权修改订单状态！");
        contract.setStatus("DRAFT");
        contractLogService.addLog(id, StpUtil.getLoginIdAsInt(), "UPDATE", "修改草稿");
        return updateById(contract)? id : null;
    }

    @Override
    public Integer PendingContract(Integer id) {
        checkInput(id,"id不能为空");
        Contract contract= getAndCheckContractLive(id);
        checkRoleAdmin(contract,"无权修改订单状态！");
        if (!Objects.equals(contract.getStatus(), "DRAFT")&&!Objects.equals(contract.getStatus(), "REJECTED")){
            throw new InvalidInputException("订单状态错误！");
        }
        contract.setStatus("PENDING");
        contractLogService.addLog(id, StpUtil.getLoginIdAsInt(), "SUBMIT", "提交检验");
        return updateById(contract)? id : null;
    }

    @Override
    public Integer ApproveContract(Integer id) {
        checkInput(id,"id不能为空");
        Contract contract= getAndCheckContractLive(id);
        checkRoleAdmin(contract,"无权修改订单状态！");
        if (!Objects.equals(contract.getStatus(), "PENDING")){
            throw new InvalidInputException("订单状态错误！");
        }
        contract.setStatus("APPROVED");

        contractLogService.addLog(id, StpUtil.getLoginIdAsInt(), "APPROVED", "通过审批");
        return updateById(contract)? id : null;
    }

    @Override
    public Integer RejectContract(Integer id) {
        checkInput(id,"id不能为空");
        Contract contract= getAndCheckContractLive(id);
        checkRoleAdmin(contract,"无权修改订单状态！");
        if (!Objects.equals(contract.getStatus(), "PENDING")){
            throw new InvalidInputException("订单状态错误！");
        }
        contract.setStatus("REJECTED");

        contractLogService.addLog(id, StpUtil.getLoginIdAsInt(), "REJECTED", "审批拒绝");
        return updateById(contract)? id : null;
    }

    @Override
    public Integer CompleteContract(Integer id) {
        checkInput(id,"id不能为空");
        Contract contract= getAndCheckContractLive(id);
        checkRoleAdmin(contract,"无权修改订单状态！");
        if (!Objects.equals(contract.getStatus(), "APPROVED")){
            throw new InvalidInputException("订单状态错误！");
        }
        contract.setStatus("COMPLETED");

        contractLogService.addLog(id, StpUtil.getLoginIdAsInt(), "COMPLETED", "结束合同");
        return updateById(contract)? id : null;
    }

    @Override
    public Integer CancelledContract(Integer id) {
        checkInput(id,"id不能为空");
        Contract contract= getAndCheckContractLive(id);
        checkRoleAdmin(contract,"无权修改订单状态！");
        contract.setStatus("CANCELLED");

        contractLogService.addLog(id, StpUtil.getLoginIdAsInt(), "CANCELLED", "取消合同");
        return updateById(contract)? id : null;
    }

    @Override
    public void deleteContract(Integer id) {
        contractMapper.deleteById(id);
    }

    @Override
    public void updateContractStatus(Integer id, int status) {
        contractMapper.updateStatus(id, status);
    }

    private ContractVo putContractVo(Contract contract) {
        ContractVo contractVo = BeanUtil.copyProperties(contract, ContractVo.class);
        String userName = userFeignService.getUserNameById(contractVo.getUserId());
        if (userName == null) {
            userName = userFeignService.getDeleteUserNameById(contractVo.getUserId()).getUserName();
            contractVo.setUserId(null);
            contractVo.setUserName(userName);
        } else {
            contractVo.setUserName(userName);
        }
        String clientName = clientFeignService.getClientNameById(contract.getClientId());
        contractVo.setClientName(clientName);
        return contractVo;
    }

    private <T> void checkInput(T t, String s) {
        if (t == null) {
            throw new InvalidInputException(s);
        }
    }

    private void checkRoleAdmin(Contract contract, String s) {
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") || !currentUserId.equals(contract.getUserId())) {
            throw new InvalidInputException(s);
        }
    }

    //生成合同编号
    private String generateNumber() {
        String timestamp = dateFormat.format(new Date());
        int randomNumber = 1000 + random.nextInt(9000); // 生成4位随机数
        return timestamp + randomNumber;
    }

    private Contract getAndCheckContractLive(Integer id) {
        checkInput(id, "合同id不能为空");
        Contract contract = getById(id);
        checkInput(contract, "合同不存在");
        return contract;
    }



}