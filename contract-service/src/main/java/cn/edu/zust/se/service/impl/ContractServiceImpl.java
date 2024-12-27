package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.po.Message;
import cn.edu.zust.se.entity.po.Order;
import cn.edu.zust.se.entity.query.ContractQuery;
import cn.edu.zust.se.entity.vo.ContractVo;
import cn.edu.zust.se.enums.ContractStatusEnum;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.ClientFeignServiceI;
import cn.edu.zust.se.feign.MessageFeignServiceI;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
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
    private final MessageFeignServiceI messageFeignService;
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
        if (contractQuery.getUserId() == null && !StpUtil.hasRole("admin")) {
            throw new InvalidInputException("用户id不能为空！");
        }
        if (!StpUtil.hasRole("admin") && !contractQuery.getUserId().equals(currentUserId)) {
            throw new InvalidInputException("无权查询合同！");
        }
        Page<Contract> page = contractQuery.toMpPage(contractQuery.getSortBy(), contractQuery.isAsc());
        if (contractQuery.getStartTime() != null) {
            contractQuery.setStartTime(contractQuery.getStartTime().substring(0,19).replace('T', ' '));
        }
        if (contractQuery.getLastUpdate() != null) {
            contractQuery.setLastUpdate(contractQuery.getLastUpdate().substring(0,19).replace('T', ' '));

        }
        lambdaQuery()
                .eq(contractQuery.getNumber() != null, Contract::getNumber, contractQuery.getNumber())
                .eq(contractQuery.getClientId() != null, Contract::getClientId, contractQuery.getClientId())
                .eq(contractQuery.getUserId() != null, Contract::getUserId, contractQuery.getUserId())
                .eq(contractQuery.getStatus() != null, Contract::getStatus, contractQuery.getStatus())
                .ge(contractQuery.getMinAmount() != null, Contract::getTotalAmout, contractQuery.getMinAmount())
                .le(contractQuery.getMaxAmount() != null, Contract::getTotalAmout, contractQuery.getMaxAmount())
                .ge(contractQuery.getStartTime() != null, Contract::getStartTime, contractQuery.getStartTime())
                .le(contractQuery.getLastUpdate() != null, Contract::getLastUpdate, contractQuery.getLastUpdate())
                .page(page);
        PageDto<ContractVo> contractVos = new PageDto<>();
        contractVos.setTotal(page.getTotal());
        contractVos.setPages(page.getPages());
        List<Contract> records = page.getRecords();
        if (CollUtil.isEmpty(records)) {
            contractVos.setList(Collections.emptyList());
            return contractVos;
        }
        List<ContractVo> vos = new ArrayList<>();
        for (Contract record : records) {
            ContractVo contractVo = BeanUtil.copyProperties(record, ContractVo.class);
            contractVo.setUserName(userFeignService.getUserNameById(record.getUserId()));
            contractVo.setClientName(clientFeignService.getClientNameById(record.getClientId()));
            vos.add(contractVo);
        }
        contractVos.setList(vos);
        return contractVos;
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
        System.out.println("\n========== 合同审批通过处理开始 ==========");
        System.out.println("接收到合同审批通过请求，合同ID: " + id);

        checkInput(id,"id不能为空!");
        Contract contract = getAndCheckContractLive(id);
        System.out.println("获取到合同信息: " + contract);

        if (!Objects.equals(contract.getStatus(), "PENDING")){
            System.out.println("错误：合同状态错误，当前状态: " + contract.getStatus());
            throw new InvalidInputException("合同状态错误！");
        }
        contract.setStatus("APPROVED");
        System.out.println("合同状态已更新为: APPROVED");

        // 创建消息
        Message message = new Message();
        message.setContent("你的合同" + contract.getNumber() + "检验通过");
        message.setSendTime(LocalDateTime.now());
        message.setUserId(contract.getUserId());
        message.setType(0);

        System.out.println("准备创建消息:");
        System.out.println("- content: " + message.getContent());
        System.out.println("- userId: " + message.getUserId());
        System.out.println("- sendTime: " + message.getSendTime());
        System.out.println("- type: " + message.getType());

        try {
            System.out.println("开始调用消息服务...");
            SaResult result = messageFeignService.add(message);
            System.out.println("消息服务返回结果:");
            System.out.println("- code: " + result.getCode());
            System.out.println("- msg: " + result.getMsg());
            System.out.println("- data: " + result.getData());
        } catch (Exception e) {
            System.out.println("错误：创建消息失败");
            System.out.println("异常类型: " + e.getClass().getName());
            System.out.println("异常消息: " + e.getMessage());
            if (e.getCause() != null) {
                System.out.println("根本原因: " + e.getCause().getMessage());
            }
            e.printStackTrace();
        }

        boolean updated = updateById(contract);
        System.out.println("合同更新结果: " + (updated ? "成功" : "失败"));
        System.out.println("========== 合同审批通过处理结束 ==========\n");
        return updated ? id : null;
    }

    @Override
    public Integer RejectContract(Integer id) {
        System.out.println("\n========== 合同驳回处理开始 ==========");
        System.out.println("接收到合同驳回请求，合同ID: " + id);

        checkInput(id,"id不能为空!");
        Contract contract = getAndCheckContractLive(id);
        System.out.println("获取到合同信息: " + contract);


        if (!Objects.equals(contract.getStatus(), "PENDING")){
            System.out.println("错误：合同状态错误，当前状态: " + contract.getStatus());
            throw new InvalidInputException("合同状态错误！");
        }
        contract.setStatus("REJECTED");
        System.out.println("合同状态已更新为: REJECTED");

        // 创建消息
        Message message = new Message();
        message.setContent("你的合同" + contract.getNumber() + "检验不通过");
        message.setSendTime(LocalDateTime.now());
        message.setUserId(contract.getUserId());
        message.setType(0);

        System.out.println("准备创建消息:");
        System.out.println("- content: " + message.getContent());
        System.out.println("- userId: " + message.getUserId());
        System.out.println("- sendTime: " + message.getSendTime());
        System.out.println("- type: " + message.getType());

        try {
            System.out.println("开始调用消息服务...");
            SaResult result = messageFeignService.add(message);
            System.out.println("消息服务返回结果:");
            System.out.println("- code: " + result.getCode());
            System.out.println("- msg: " + result.getMsg());
            System.out.println("- data: " + result.getData());
        } catch (Exception e) {
            System.out.println("错误：创建消息失败");
            System.out.println("异常类型: " + e.getClass().getName());
            System.out.println("异常消息: " + e.getMessage());
            if (e.getCause() != null) {
                System.out.println("根本原因: " + e.getCause().getMessage());
            }
            e.printStackTrace();
        }

        boolean updated = updateById(contract);
        System.out.println("合同更新结果: " + (updated ? "成功" : "失败"));
        System.out.println("========== 合同驳回处理结束 ==========\n");
        return updated ? id : null;
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
//
//    // 检查合同到期提醒
//    @Scheduled(cron = "0 0 9 * * ?") // 每天早上9点执行
//    public void checkContractExpiration() {
//        // 获取即将到期的合同(7天内)
//        List<Contract> expiringContracts = this.getExpiringContracts(7);
//
//        for(Contract contract : expiringContracts) {
//            // 发送提醒消息
//            Message message = new Message();
//            message.setUserId(contract.getUserId());
//            message.setContent("合同" + contract.getNumber() + "即将到期，请注意处理");
//            message.setType(0); // 未读
//            messageFeignService.add(message);
//        }
//    }
}