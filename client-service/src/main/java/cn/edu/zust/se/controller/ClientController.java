package cn.edu.zust.se.controller;


import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.query.ClientQuery;
import cn.edu.zust.se.entity.vo.ClientVo;
import cn.edu.zust.se.exception.ForbiddenException;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.service.IClientService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

/**
 * @author anymore131
 * @since 2024-12-18
 */
@RestController
@RequestMapping
public class ClientController {
    private final IClientService clientService;
    public ClientController(IClientService clientService) {
        this.clientService = clientService;
    }

    @RequestMapping("/pageAll")
    public SaResult pageAll(@RequestBody(required = false) ClientQuery clientQuery){
        if (!StpUtil.hasRole("admin")) {
            throw new ForbiddenException("无权查看其他用户信息！");
        }
        PageDto<ClientVo> clientVoPage = clientService.getClientVoPage(clientQuery);
        return SaResult.data(clientVoPage);
    }

    @RequestMapping("/page/{id}")
    public SaResult pageByUserId(@PathVariable Integer id, @RequestBody(required = false) ClientQuery clientQuery){
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(id)) {
            throw new ForbiddenException("无权查看其他用户信息！");
        }
        if (clientQuery.getUserId() == null ) {
            throw new InvalidInputException("输入信息有误！");
        }
        if (!id.equals(clientQuery.getUserId())){
            throw new InvalidInputException("输入信息不一致！");
        }
        PageDto<ClientVo> clientVoPage = clientService.getClientVoPage(clientQuery);
        return SaResult.data(clientVoPage);
    }
}
