package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.dto.ClientOrderStatusDto;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Client;
import cn.edu.zust.se.entity.po.Order;
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
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;

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
    public List<ClientVo> getClientVoList(Integer userId) {
        if (userId == null && !StpUtil.hasRole("admin")){
            throw new ForbiddenException("权限不足！");
        }
        List<Client> clients = lambdaQuery()
                .eq(userId != null, Client::getUserId, userId)
                .list();
        if (CollUtil.isNotEmpty(clients)){
            List<ClientVo> vos = new ArrayList<>();
            for (Client client : clients){
                ClientVo clientVo = BeanUtil.copyProperties(client, ClientVo.class);
                clientVo.setUserName(userFeignService.getUserNameById(client.getUserId()));
                clientVo.setStatus(ClientStatusEnum.fromCode(client.getStatus()));
                vos.add(clientVo);
            }
            return vos;
        }
        return null;
    }

    @Override
    public Long getCount(Integer userId) {
        if (userId == null && !StpUtil.hasRole("admin")){
            throw new ForbiddenException("权限不足！");
        }
        return lambdaQuery()
                .eq(userId != null, Client::getUserId, userId)
                .count();
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
        if (!Objects.equals(client.getStatus(), ClientStatusEnum.START.getCode())){
            throw new InvalidInputException("客户已有合作记录，无法删除！");
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

    @Override
    public String getClientNameById(Integer id) {
        if (id == null){
            return null;
        }
        if (getById(id) != null){
            return getById(id).getName();
        }
        return null;
    }

    @Override
    public String toWaitting(Integer id) {
        if (id == null){
            return "客户id为空!";
        }
        Client client = getById(id);
        if (client == null){
            return "未找到该客户！";
        }
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(getById(id).getUserId())){
            return "无权修改客户信息！";
        }
        client.setStatus(ClientStatusEnum.WAITING.getCode());
        client.setLastTime(LocalDateTime.now());
        if (updateById(client)){
            return null;
        }
        return "修改错误";
    }

    @Override
    public String toCooperation(Integer id) {
        if (id == null){
            return "客户id为空!";
        }
        Client client = getById(id);
        if (client == null){
            return "未找到该客户！";
        }
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(getById(id).getUserId())){
            return "无权修改客户信息！";
        }
        client.setStatus(ClientStatusEnum.COOPERATION.getCode());
        client.setLastTime(LocalDateTime.now());
        if (updateById(client)){
            return null;
        }
        return "修改错误";
    }

    @Override
    public String updateClientSum(Integer id,Integer amount) {
        if (id == null){
            return "客户id为空!";
        }
        if (amount == null){
            return null;
        }
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(getById(id).getUserId())){
            return "无权修改客户信息！";
        }
        Client client = getById(id);
        if (client == null){
            return "未找到该客户！";
        }
        client.setSum(client.getSum() + amount);
        if (updateById(client)){
            return null;
        }
        return "更新失败";
    }

    @Override
    public Map<String, Long> getOrderStatusDistribution(Integer userId) {
        if (userId == null && !StpUtil.hasRole("admin")){
            throw new InvalidInputException("无权查看！");
        }
        Map<String, Long> map = new HashMap<>();
        QueryWrapper<Client> queryWrapper = new QueryWrapper<>();
        Map<String,Integer> statusMap = new HashMap<>();
        statusMap.put("START", ClientStatusEnum.START.getCode());
        statusMap.put("COOPERATION", ClientStatusEnum.COOPERATION.getCode());
        statusMap.put("WAITING", ClientStatusEnum.WAITING.getCode());
        for (String s: statusMap.keySet()){
            queryWrapper.clear();
            queryWrapper
                    .eq("status", statusMap.get(s))
                    .eq(userId != null, "user_id", userId);
            Long count = count(queryWrapper);
            map.put(s, count);
        }
        return map;
    }

    @Override
    public List<Client> getAllClientList(Integer userId) {
        return lambdaQuery()
                .ne(Client::getStatus, ClientStatusEnum.START.getCode())
                .eq(userId != null, Client::getUserId, userId)
                .list();
    }

    @Override
    public List<Integer> getAllClientIdsByUserId(Integer userId) {
        return lambdaQuery()
                .eq(true, Client::getUserId, userId)
                .list()
                .stream()
                .map(Client::getId)
                .toList();
    }

//    @Override
//    public ClientOrderStatusDto getClientOrderStatus(Integer clientId) {
//        ClientOrderStatusDto dto = new ClientOrderStatusDto();
//        dto.setClientId(clientId);
//
//        // 获取客户信息
//        Client client = clientMapper.selectById(clientId);
//        if (client != null) {
//            dto.setClientName(client.getName());
//        }
//
//        // 查询订单状态
//        LambdaQueryWrapper<Order> wrapper = new LambdaQueryWrapper<>();
//        wrapper.eq(Order::getClientId, clientId);
//        List<Order> orders = orderMapper.selectList(wrapper);
//
//        // 统计订单信息
//        dto.setTotalOrders(orders.size());
//
//        // 统计进行中订单（已通过审批但未完成的订单）
//        long activeOrders = orders.stream()
//                .filter(order -> "APPROVED".equals(order.getStatus()))
//                .count();
//        dto.setActiveOrders((int) activeOrders);
//        dto.setHasActiveOrders(activeOrders > 0);
//
//        // 统计已完成订单
//        long completedOrders = orders.stream()
//                .filter(order -> "COMPLETED".equals(order.getStatus()))
//                .count();
//        dto.setCompletedOrders((int) completedOrders);
//
//        // 计算总金额
//        double totalAmount = orders.stream()
//                .mapToDouble(order -> order.getTotalAmount().doubleValue())
//                .sum();
//        dto.setTotalAmount(totalAmount);
//
//        // 获取最近订单时间
//        orders.stream()
//                .map(Order::getCreateTime)
//                .max(LocalDateTime::compareTo)
//                .ifPresent(time -> dto.setLatestOrderTime(time.toString()));
//
//        return dto;
//    }
}
