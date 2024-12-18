package cn.edu.zust.se.controller;


import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.query.ClientQuery;
import cn.edu.zust.se.entity.vo.ClientVo;
import cn.edu.zust.se.service.IClientService;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

/**
 * @author anymore131
 * @since 2024-12-18
 */
@RestController
@RequestMapping("/client")
public class ClientController {
    private final IClientService clientService;
    public ClientController(IClientService clientService) {
        this.clientService = clientService;
    }

    @RequestMapping("/pageAll")
    public SaResult pageAll(@RequestBody(required = false) ClientQuery clientQuery){
        PageDto<ClientVo> clientVoPage = clientService.getClientVoPage(clientQuery);
        return SaResult.data(clientVoPage);
    }
}
