package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.po.ContractLog;
import cn.edu.zust.se.entity.po.Order;
import cn.edu.zust.se.entity.po.OrderLog;
import cn.edu.zust.se.entity.query.ContractLogQuery;
import cn.edu.zust.se.entity.vo.ContractLogVo;
import cn.edu.zust.se.entity.vo.OrderLogVo;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.UserFeignServiceI;
import cn.edu.zust.se.mapper.ContractLogMapper;
import cn.edu.zust.se.mapper.ContractMapper;
import cn.edu.zust.se.service.IContractLogService;
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

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author author
 * @since 2024-12-24
 */
@Service
@Transactional
@RequiredArgsConstructor
public class ContractLogServiceImpl extends ServiceImpl<ContractLogMapper, ContractLog> implements IContractLogService {
    private final ContractMapper contractMapper;
    private final ContractLogMapper contractLogMapper;
    private UserFeignServiceI userFeignService;

    @Override
    public PageDto<ContractLogVo> pageLogs(ContractLogQuery query) {
        Integer contractId = null, userId = null;
        String userName = null;
        if (query == null){
            throw new InvalidInputException("查询参数不能为空");
        }
        if (!StpUtil.hasRole("admin")){
            throw new InvalidInputException("无权限查询日志");
        }
        if(query.getContractId() != null){
            contractId = contractMapper.selectOne(new QueryWrapper<Contract>().eq("contract_id", query.getContractId())).getId();
        }
        if (query.getUserId() != null){
            userName = userFeignService.getUserNameById(query.getUserId());
        }
        Page<ContractLog> page = query.toMpPage(query.getSortBy(),query.isAsc());
        lambdaQuery()
                .eq(query.getContractId() != null, ContractLog::getContractId, contractId)
                .eq(query.getUserId() != null, ContractLog::getUserId, userId)
                .eq(query.getAction() != null, ContractLog::getAction, query.getAction())
                .page(page);
        PageDto<ContractLogVo> vos = new PageDto<>();
        vos.setTotal(page.getTotal());
        vos.setPages(page.getPages());
        List<ContractLogVo> contractLogVos = new ArrayList<>();
        if (CollUtil.isEmpty(page.getRecords())){
            vos.setList(Collections.emptyList());
            return vos;
        }
        for (ContractLog record : page.getRecords()){
            ContractLogVo contractLogVo = BeanUtil.copyProperties(record, ContractLogVo.class);
            contractLogVo.setContractId(Integer.valueOf(contractMapper.selectOne(new QueryWrapper<Contract>().eq("contract_id", record.getContractId())).getNumber()));
            contractLogVo.setUserName(userFeignService.getUserNameById(record.getUserId()));
            contractLogVos.add(contractLogVo);
        }
        vos.setList(contractLogVos);
        return vos;
    }

    @Override
    public void addLog(Integer contractId, Integer userId, String action, String content) {
        ContractLog log = new ContractLog();
        log.setContractId(contractId)
                .setUserId(userId)
                .setAction(action)
                .setContent(content)
                .setCreateTime(LocalDateTime.now())
                .setIsDelete(0);
        save(log);
    }
}
