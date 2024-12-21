package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Client;
import cn.edu.zust.se.entity.query.ClientQuery;
import cn.edu.zust.se.entity.vo.ClientVo;
import cn.edu.zust.se.enums.ClientStatusEnum;
import cn.edu.zust.se.exception.ForbiddenException;
import cn.edu.zust.se.exception.InvalidInputException;
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

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

/**
 * @author anymore131
 * @since 2024-12-18
 */
@Service
public class ClientServiceImpl extends ServiceImpl<ClientMapper, Client> implements IClientService {
    @Autowired
    private UserFeignServiceI userFeignService;

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
    public ClientVo getClientVoById(Integer id) {
        if (id == null){
            throw new InvalidInputException("客户id不能为空！");
        }
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        Client client = getById(id);
        if (client == null){
            throw new InvalidInputException("客户不存在！");
        }
        if(!StpUtil.hasRole("admin") && !currentUserId.equals(client.getUserId())){
            throw new ForbiddenException("无权查看其他用户的客户信息！");
        }
        ClientVo clientVo = BeanUtil.copyProperties(client, ClientVo.class);
        clientVo.setUserName(userFeignService.getUserNameById(client.getUserId()));
        clientVo.setStatus(ClientStatusEnum.fromCode(client.getStatus()));
        return clientVo;
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

    @Override
    public ClientVo addClient(Client client) {
        if (client.getUserId() == null){
            throw new InvalidInputException("用户不能为空！");
        }
        if (client.getName() == null || client.getName().isEmpty()){
            throw new InvalidInputException("客户姓名不能为空！");
        }
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!client.getUserId().equals(currentUserId) && !StpUtil.hasRole("admin")){
            throw new ForbiddenException("无权添加其他用户的客户信息！");
        }
        if (client.getMobile() == null || client.getMobile().isEmpty() && client.getEmail() == null || client.getEmail().isEmpty()){
            throw new InvalidInputException("手机号或邮箱不能为空！");
        }
        client.setSum(0);
        client.setStatus(ClientStatusEnum.START.getCode());
        client.setCreateTime(LocalDateTime.now());
        client.setLastTime(LocalDateTime.now());
        client.setIsDelete(0);
        save(client);
        ClientVo clientVo = BeanUtil.copyProperties(client, ClientVo.class);
        clientVo.setUserName(userFeignService.getUserNameById(client.getUserId()));
        clientVo.setStatus(ClientStatusEnum.fromCode(client.getStatus()));
        return clientVo;
    }

    @Override
    public ClientVo updateClient(Client client) {
        if (client.getId() == null){
            throw new InvalidInputException("客户id不能为空！");
        }
        if (client.getUserId() == null){
            throw new InvalidInputException("用户不能为空！");
        }
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(client.getUserId())){
            throw new ForbiddenException("无权修改客户信息！");
        }
        if (client.getName() == null || client.getName().isEmpty()){
            throw new InvalidInputException("客户姓名不能为空！");
        }
        Client oldClient = getById(client.getId());
        if (oldClient == null){
            throw new InvalidInputException("客户不存在！");
        }
        client.setSum(oldClient.getSum());
        client.setCreateTime(oldClient.getCreateTime());
        client.setLastTime(LocalDateTime.now());
        updateById(client);
        ClientVo clientVo = BeanUtil.copyProperties(client, ClientVo.class);
        clientVo.setUserName(userFeignService.getUserNameById(client.getUserId()));
        clientVo.setStatus(ClientStatusEnum.fromCode(client.getStatus()));
        return clientVo;
    }

    @Override
    public void deleteClient(Integer id) {
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        Client client = getById(id);
        if (client == null){
            throw new InvalidInputException("客户不存在！");
        }
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(client.getUserId())){
            throw new ForbiddenException("无权删除客户信息！");
        }
        if (Objects.equals(client.getStatus(), ClientStatusEnum.COOPERATION.getCode())){
            throw new InvalidInputException("客户正在合作中，无法删除！");
        }
        removeById(id);
    }

    @Override
    public void changeUser(Integer clientId, Integer userId, String password) {
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!userFeignService.checkUser(currentUserId, password)){
            throw new InvalidInputException("用户信息有误！");
        }
        if (userFeignService.getUserNameById(userId) == null){
            throw new InvalidInputException("用户不存在！");
        }
        Client client = getById(clientId);
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(client.getUserId())){
            throw new ForbiddenException("无权修改客户信息！");
        }
        if (client == null){
            throw new InvalidInputException("客户不存在！");
        }
        if (Objects.equals(client.getStatus(), ClientStatusEnum.COOPERATION.getCode())){
            throw new InvalidInputException("客户正在合作中，无法进行修改！");
        }
        client.setUserId(userId);
        client.setLastTime(LocalDateTime.now());
        updateById(client);
    }
}
