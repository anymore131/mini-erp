package cn.edu.zust.se.controller;


import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Client;
import cn.edu.zust.se.entity.query.ClientQuery;
import cn.edu.zust.se.entity.vo.ClientVo;
import cn.edu.zust.se.exception.ForbiddenException;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.service.IClientService;
import org.springframework.web.bind.annotation.*;

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
        if (clientQuery == null){
            throw new InvalidInputException("输入信息为空！");
        }
        if (!StpUtil.hasRole("admin")) {
            throw new ForbiddenException("无权查看其他用户信息！");
        }
        PageDto<ClientVo> clientVoPage = clientService.getClientVoPage(clientQuery);
        return SaResult.data(clientVoPage);
    }

    @RequestMapping("/get/{id}")
    public SaResult getById(@PathVariable Integer id){
        if (id == null){
            throw new InvalidInputException("输入信息为空！");
        }
        ClientVo clientVo = clientService.getClientVoById(id);
        return SaResult.data(clientVo);
    }

    @RequestMapping("/page/{id}")
    public SaResult pageByUserId(@PathVariable Integer id, @RequestBody(required = false) ClientQuery clientQuery){
        if (clientQuery == null || id == null){
            throw new InvalidInputException("输入信息为空！");
        }
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(id)) {
            throw new ForbiddenException("无权查看其他用户信息！");
        }
        if (clientQuery.getUserId() == null ) {
            throw new InvalidInputException("输入信息为空！");
        }
        if (!id.equals(clientQuery.getUserId())){
            throw new InvalidInputException("输入信息不一致！");
        }
        PageDto<ClientVo> clientVoPage = clientService.getClientVoPage(clientQuery);
        return SaResult.data(clientVoPage);
    }

    @RequestMapping("/add")
    public SaResult add(@RequestBody(required = false) Client client){
        if (client == null){
            throw new InvalidInputException("输入信息为空！");
        }
        ClientVo clientVo = clientService.addClient(client);
        return SaResult.data(clientVo).setMsg("添加成功！");
    }

    @RequestMapping("/update")
    public SaResult update(@RequestBody(required = false) Client client){
        if (client == null){
            throw new InvalidInputException("输入信息为空！");
        }
        ClientVo clientVo = clientService.updateClient(client);
        return SaResult.data(clientVo).setMsg("更新成功！");
    }

    @RequestMapping("/delete/{id}")
    public SaResult delete(@PathVariable Integer id){
        if (id == null){
            throw new InvalidInputException("输入信息为空！");
        }
        clientService.deleteClient(id);
        return SaResult.ok("删除成功！");
    }

    @RequestMapping("/changeUser")
    public SaResult changeUser(@RequestParam("clientId") Integer clientId
            , @RequestParam("userId") Integer userId, @RequestParam("password") String password){
        if (clientId == null || userId == null || password == null){
            throw new InvalidInputException("输入信息为空！");
        }
        clientService.changeUser(clientId, userId, password);
        return SaResult.ok("修改成功！");
    }

    @PostMapping("/signOut/{id}")
    public String signOut(@PathVariable("id") Integer userId){
        clientService.userSignOut(userId);
        return "success";
    }

    @GetMapping("/getClientName/{id}")
    public String getClientNameById(@PathVariable("id") Integer id){
        if (id == null){
            return null;
        }
        return clientService.getClientNameById(id);
    }
}
