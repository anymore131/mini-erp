package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Client;
import cn.edu.zust.se.entity.po.ClientRfm;
import cn.edu.zust.se.entity.query.ClientRfmQuery;
import cn.edu.zust.se.entity.vo.ClientRfmVo;
import cn.edu.zust.se.entity.vo.ClientVo;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.OrderFeignServiceI;
import cn.edu.zust.se.feign.UserFeignServiceI;
import cn.edu.zust.se.mapper.ClientMapper;
import cn.edu.zust.se.mapper.ClientRfmMapper;
import cn.edu.zust.se.service.IClientRfmService;
import cn.edu.zust.se.service.IClientService;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author anymore131
 * @since 2024-12-26
 */
@Service
public class ClientRfmServiceImpl extends ServiceImpl<ClientRfmMapper, ClientRfm> implements IClientRfmService {
    @Autowired
    private IClientService clientService;
    @Autowired
    private OrderFeignServiceI orderFeignService;
    @Autowired
    private ClientMapper clientMapper;
    @Autowired
    private UserFeignServiceI userFeignService;

    @Override
    public void updateAllRfmScores() {
        List<Client> clients = clientService.getAllClientList(null);
        for (Client client : clients){
            ClientRfm clientRfm = getById(client.getId());
            if (clientRfm == null){
                insertRfm(client.getId());
            }else{
                ClientRfm clientRfm1 = calculateRfmScore(clientRfm);
                update(clientRfm1, new QueryWrapper<ClientRfm>().eq("client_id", clientRfm1.getClientId()));
            }
        }
    }

    @Override
    public Map<String, Long> getCustomerLevelDistribution(Integer userId) {
        if (userId == null && !StpUtil.hasRole("admin")){
            throw new InvalidInputException("权限错误！");
        }
        Map<String, Long> map = new HashMap<>();
        QueryWrapper<ClientRfm> queryWrapper = new QueryWrapper<>();
        for (String s: List.of(new String[]{"A","B","C","D"})){
            queryWrapper.clear();
            queryWrapper
                    .eq("customer_level",s)
                    .eq(userId != null, "user_id", userId);
            Long count = count(queryWrapper);
            map.put(s, count);
        }
        return map;
    }

    @Override
    public PageDto<ClientRfmVo> getValueCustomers(ClientRfmQuery query) {
        if (query == null){
            throw new InvalidInputException("查询条件不能为空");
        }
        query.setSortBy("rfm_score");
        if (query.getUserId() == null && !StpUtil.hasRole("admin")){
            throw new InvalidInputException("用户id不能为空");
        }
        Integer userId = query.getUserId();
        if (!StpUtil.hasRole("admin") && !userId.equals(StpUtil.getLoginIdAsInt())){
            throw new InvalidInputException("无权查看！");
        }
        Page<ClientRfm> page = new Page<>(query.getPageNum(), query.getPageSize());
        lambdaQuery()
                .eq(userId != null, ClientRfm::getUserId, userId)
                .eq(query.getCustomerLevel() != null, ClientRfm::getCustomerLevel, query.getCustomerLevel())
                .page(page);
        PageDto<ClientRfmVo> pageDto = new PageDto<>();
        pageDto.setTotal(page.getTotal());
        pageDto.setPages(page.getPages());
        List<ClientRfm> records = page.getRecords();
        if (CollUtil.isEmpty(records)){
            pageDto.setList(Collections.emptyList());
            return pageDto;
        }
        List<ClientRfmVo> vos = new ArrayList<>();
        for(ClientRfm clientRfm : records){
            ClientRfmVo vo = new ClientRfmVo();
            BeanUtil.copyProperties(clientRfm, vo);
            vo.setUserName(userFeignService.getUserNameById(clientRfm.getUserId()));
            vo.setClientName(clientService.getById(clientRfm.getClientId()).getName());
            vos.add(vo);
        }
        pageDto.setList(vos);
        return pageDto;
    }

    @Override
    public void insertRfm(Integer clientId) {
        ClientRfm clientRfm = new ClientRfm();
        clientRfm.setClientId(clientId);
        clientRfm.setUserId(clientService.getById(clientId).getUserId());
        save(calculateRfmScore(clientRfm));
    }

    @Override
    public void updateRfmByUserId(Integer userId) {
        List<ClientVo> clients = clientService.getClientVoList(userId);
        for (ClientVo client : clients){
            ClientRfm clientRfm = getById(client.getId());
            if (clientRfm == null){
                insertRfm(client.getId());
            }else{
                ClientRfm c = calculateRfmScore(clientRfm);
                update(c, new QueryWrapper<ClientRfm>().eq("client_id", c.getClientId()));
            }
        }
    }

    public ClientRfm calculateRfmScore(ClientRfm clientRfm) {
        clientRfm.setLastOrderTime(orderFeignService.getLastOrderTime(clientRfm.getClientId()));
        clientRfm.setOrderFrequency(orderFeignService.getOrderFrequency(clientRfm.getClientId()));
        clientRfm.setTotalAmount(orderFeignService.getTotalAmount(clientRfm.getClientId()));
        // 计算R分数 (1-5分)
        int rScore = calculateRecencyScore(clientRfm.getLastOrderTime());
        // 计算F分数 (1-5分)
        int fScore = calculateFrequencyScore(clientRfm.getOrderFrequency());
        // 计算M分数 (1-5分)
        int mScore = calculateMonetaryScore(clientRfm.getTotalAmount());
        // 计算总分
        int rfmScore = rScore * 100 + fScore * 10 + mScore;
        // 确定客户等级
        String level = determineCustomerLevel(rfmScore);
        // 更新客户信息
        clientRfm.setRfmScore(rfmScore);
        clientRfm.setCustomerLevel(level);
        return clientRfm;
    }

    private int calculateRecencyScore(LocalDateTime lastOrderTime) {
        if (lastOrderTime == null) return 1;

        long daysDiff = ChronoUnit.DAYS.between(lastOrderTime, LocalDateTime.now());

        if (daysDiff <= 30) return 5;
        if (daysDiff <= 90) return 4;
        if (daysDiff <= 180) return 3;
        if (daysDiff <= 365) return 2;
        return 1;
    }

    private int calculateFrequencyScore(long frequency) {
        if (frequency == 0) return 1;

        if (frequency >= 20) return 5;
        if (frequency >= 10) return 4;
        if (frequency >= 5) return 3;
        if (frequency >= 2) return 2;
        return 1;
    }

    private int calculateMonetaryScore(Integer amount) {
        if (amount == null || amount == 0) return 1;

        // 金额单位：分
        if (amount >= 1000000) return 5;  // 1万元
        if (amount >= 500000) return 4;   // 5千元
        if (amount >= 200000) return 3;   // 2千元
        if (amount >= 100000) return 2;   // 1千元
        return 1;
    }

    private String determineCustomerLevel(int rfmScore) {
        if (rfmScore >= 450) return "A";  // 高价值客户
        if (rfmScore >= 350) return "B";  // 重要发展客户
        if (rfmScore >= 250) return "C";  // 一般价值客户
        return "D";                       // 低价值客户
    }
}
