package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Client;
import cn.edu.zust.se.entity.po.ClientRfm;
import cn.edu.zust.se.entity.query.ClientRfmQuery;
import cn.edu.zust.se.entity.vo.ClientRfmVo;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.UserFeignServiceI;
import cn.edu.zust.se.mapper.ClientRfmMapper;
import cn.edu.zust.se.service.IClientRfmService;
import cn.edu.zust.se.service.IClientService;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;

/**
 * <p>
 * 服务实现类
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
    private UserFeignServiceI userFeignService;
    @Autowired
    private RestTemplate restTemplate;

    @Override
    public void updateManual() {
        // 简单GET（自动解析JSON到对象）
        String result = restTemplate.getForObject("http://localhost:8000/client-analysis/all", String.class);
    }

    @Override
    public PageDto<ClientRfmVo> getValueCustomers(ClientRfmQuery query) {
        if (query == null) {
            throw new InvalidInputException("查询条件不能为空");
        }
        if (query.getUserId() == null && !StpUtil.hasRole("admin")) {
            throw new InvalidInputException("用户id不能为空");
        }
        Integer userId = query.getUserId();
        if (!StpUtil.hasRole("admin") && !userId.equals(StpUtil.getLoginIdAsInt())) {
            throw new InvalidInputException("无权查看！");
        }

        if (query.getClientId() != null) {
            ClientRfm clientRfm = getById(query.getClientId());
            Client client = clientService.getById(clientRfm.getClientId());
            ClientRfmVo vo = BeanUtil.copyProperties(clientRfm, ClientRfmVo.class);
            vo.setClientName(client.getName());
            vo.setUserId(client.getUserId());
            vo.setUserName(userFeignService.getUserNameById(client.getUserId()));
            PageDto<ClientRfmVo> pageDto = new PageDto<>();
            pageDto.setTotal(1L);
            pageDto.setList(List.of(vo));
            pageDto.setPages(1L);
            return pageDto;
        }
        List<Integer> lists = new ArrayList<>();
        if (query.getUserId() != null) {
            lists = clientService.getAllClientIdsByUserId(query.getUserId());
            if (CollUtil.isEmpty(lists)) {
                PageDto<ClientRfmVo> pageDto = new PageDto<>();
                pageDto.setTotal(0L);
                pageDto.setPages(0L);
                pageDto.setList(Collections.emptyList());
                return pageDto;
            }
        }
        Page<ClientRfm> page = new Page<>(query.getPageNum(), query.getPageSize());
        Integer min = query.getMinChurnRisk();
        double minChurnRisk = 0;
        if (min == null || min > 100 || min < 0) {
            min = 0;
        } else {
            min = min / 100;
            minChurnRisk = min / 100.0;
        }
        lambdaQuery()
                .in(!lists.isEmpty(), ClientRfm::getClientId, lists)
                .eq(query.getTier() != null, ClientRfm::getTier, query.getTier())
                .eq(query.getCluster() != null, ClientRfm::getCluster, query.getCluster())
                .eq(query.getIsAnomaly() != null, ClientRfm::getIsAnomaly, query.getIsAnomaly())
                .gt(true, ClientRfm::getChurnRisk, minChurnRisk)
                .orderBy(query.getSortBy().equals("churnRisk"), query.isAsc(), ClientRfm::getChurnRisk)
                .orderBy(query.getSortBy().equals("frequency"), query.isAsc(), ClientRfm::getFrequency)
                .orderBy(query.getSortBy().equals("monetary"), query.isAsc(), ClientRfm::getMonetary)
                .orderBy(query.getSortBy().equals("clientId"), query.isAsc(), ClientRfm::getClientId)
                .orderBy(query.getSortBy().equals("lastOrderTime"), query.isAsc(), ClientRfm::getLastOrderTime)
                .orderBy(query.getSortBy().equals("cluster"), query.isAsc(), ClientRfm::getCluster)
                .page(page);
        PageDto<ClientRfmVo> pageDto = new PageDto<>();
        pageDto.setTotal(page.getTotal());
        pageDto.setPages(page.getPages());
        List<ClientRfm> records = page.getRecords();
        if (CollUtil.isEmpty(records)) {
            pageDto.setList(Collections.emptyList());
            return pageDto;
        }
        List<ClientRfmVo> vos = BeanUtil.copyToList(records, ClientRfmVo.class);
        for (ClientRfmVo vo : vos) {
            Client client = clientService.getById(vo.getClientId());
            vo.setClientName(client.getName());
            vo.setMonetary(Double.parseDouble(String.format("%.2f", vo.getMonetary())));
            vo.setUserId(client.getUserId());
            vo.setUserName(userFeignService.getUserNameById(client.getUserId()));
        }
        pageDto.setList(vos);
        return pageDto;
    }

    @Override
    public List<ClientRfmVo> getByUserId(Integer userId) {
        if (userId == null && !StpUtil.hasRole("admin")) {
            throw new InvalidInputException("用户id不能为空");
        }
        if (!StpUtil.hasRole("admin") && !userId.equals(StpUtil.getLoginIdAsInt())) {
            throw new InvalidInputException("无权查看！");
        }
        List<Integer> clientIds;
        clientIds = clientService.getAllClientIdsByUserId(userId);
        if (CollUtil.isEmpty(clientIds)) {
            return Collections.emptyList();
        }
        List<ClientRfm> list = lambdaQuery()
                .in(!clientIds.isEmpty(), ClientRfm::getClientId, clientIds)
                .list();
        List<ClientRfmVo> vos = BeanUtil.copyToList(list, ClientRfmVo.class);
        for (ClientRfmVo vo : vos) {
            Client client = clientService.getById(vo.getClientId());
            vo.setClientName(client.getName());
            vo.setMonetary(Double.parseDouble(String.format("%.2f", vo.getMonetary())));
        }
        return vos;
    }

    @Override
    public List<ClientRfmVo> getAll() {
        if (!StpUtil.hasRole("admin")) {
            throw new InvalidInputException("无权查看！");
        }
        List<ClientRfm> list = lambdaQuery()
                .list();
        List<ClientRfmVo> vos = BeanUtil.copyToList(list, ClientRfmVo.class);
        for (ClientRfmVo vo : vos) {
            Client client = clientService.getById(vo.getClientId());
            vo.setClientName(client.getName());
            vo.setMonetary(Double.parseDouble(String.format("%.2f", vo.getMonetary())));
        }
        return vos;
    }
}
