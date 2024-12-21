package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Client;
import cn.edu.zust.se.entity.query.ClientQuery;
import cn.edu.zust.se.entity.vo.ClientVo;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * @author anymore131
 * @since 2024-12-18
 */
public interface IClientService extends IService<Client> {
    public PageDto<ClientVo> getClientVoPage(ClientQuery clientQuery);
    public void userSignOut(Integer userId);
    public ClientVo addClient(Client client);
    public ClientVo updateClient(Client client);
    public void deleteClient(Integer id);
    public void changeUser(Integer clientId, Integer userIdm, String password);
}