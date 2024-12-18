package cn.edu.zust.se.service.impl;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Client;
import cn.edu.zust.se.entity.query.ClientQuery;
import cn.edu.zust.se.entity.vo.ClientVo;
import cn.edu.zust.se.enums.ClientStatusEnum;
import cn.edu.zust.se.feign.UserFeignServiceI;
import cn.edu.zust.se.mapper.ClientMapper;
import cn.edu.zust.se.service.IClientService;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * @author anymore131
 * @since 2024-12-18
 */
@Service
public class ClientServiceImpl extends ServiceImpl<ClientMapper, Client> implements IClientService {
    @Autowired
    private UserFeignServiceI userFeignService;
    @Autowired
    private UserFeignServiceI userFeignServiceI;

    @Override
    public PageDto<ClientVo> getClientVoPage(ClientQuery clientQuery) {
        Page<Client> page = clientQuery.toMpPage(clientQuery.getSortBy(), clientQuery.isAsc());
        if (clientQuery.getStatus() != null){
            lambdaQuery()
                    .eq(clientQuery.getUserId() != null,Client::getUserId, clientQuery.getUserId())
                    .eq(clientQuery.getStatus() != null,Client::getStatus, ClientStatusEnum.fromMessage(clientQuery.getStatus()))
                    .like(clientQuery.getName() != null,Client::getName, clientQuery.getName())
                    .ge(clientQuery.getSum() != null,Client::getSum, clientQuery.getSum())
                    .page(page);
        }else{
            lambdaQuery()
                    .eq(clientQuery.getUserId() != null,Client::getUserId, clientQuery.getUserId())
                    .like(clientQuery.getName() != null,Client::getName, clientQuery.getName())
                    .ge(clientQuery.getSum() != null,Client::getSum, clientQuery.getSum())
                    .page(page);
        }
        PageDto<ClientVo> voPageDto = new PageDto<>();
        voPageDto.setTotal(page.getTotal());
        voPageDto.setPages(page.getPages());
        List<Client> records = page.getRecords();
        if (CollUtil.isEmpty(records)){
            voPageDto.setList(Collections.emptyList());
            return voPageDto;
        }
        List<ClientVo> vos = new ArrayList<>();
        for (Client record : records){
            int status = record.getStatus();
            ClientVo clientVo = BeanUtil.copyProperties(record, ClientVo.class);
            clientVo.setStatus(ClientStatusEnum.fromCode(status).toString());
            clientVo.setUserName(userFeignService.getUserNameById(record.getUserId()));
            vos.add(clientVo);
        }
        voPageDto.setList(vos);
        return voPageDto;
    }

    @Override
    public void userSignOut(Integer userId) {
        String s = userFeignService.getUserNameById(userId);
        if (s == null){
            QueryWrapper<Client> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("user_id", userId);
            List<Client> clients = baseMapper.selectList(queryWrapper);
            for (Client client : clients){
                client.setUserId(0);
                baseMapper.updateById(client);
            }
        }
    }
}
