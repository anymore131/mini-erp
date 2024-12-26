package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.ClientOrderStatusDto;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Client;
import cn.edu.zust.se.entity.query.ClientQuery;
import cn.edu.zust.se.entity.vo.ClientVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * @author anymore131
 * @since 2024-12-18
 */
public interface IClientService extends IService<Client> {
    public PageDto<ClientVo> getClientVoPage(ClientQuery clientQuery);
    public ClientVo getClientVoById(Integer id);
    public List<ClientVo> getClientVoList(Integer userId);
    public Long getCount(Integer userId);
    public void userSignOut(Integer userId);
    public ClientVo addClient(Client client);
    public ClientVo updateClient(Client client);
    public void deleteClient(Integer id);
    public void changeUser(Integer clientId, Integer userIdm, String password);
    public String getClientNameById(Integer id);
    public String toWaitting(Integer id);
    public String toCooperation(Integer id);
    public String updateClientSum(Integer id,Integer amount);
    public Map<String,Long> getOrderStatusDistribution(Integer userId);
    public List<Client> getAllClientList(Integer userId);
//    ClientOrderStatusDto getClientOrderStatus(Integer clientId) ;
}