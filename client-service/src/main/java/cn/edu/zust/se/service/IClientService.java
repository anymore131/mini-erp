package cn.edu.zust.se.service;

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
    PageDto<ClientVo> getClientVoPage(ClientQuery clientQuery);
    ClientVo getClientVoById(Integer id);
    List<ClientVo> getClientVoList(Integer userId);
    Long getCount(Integer userId);
    void userSignOut(Integer userId);
    ClientVo addClient(Client client);
    ClientVo updateClient(Client client);
    void deleteClient(Integer id);
    void changeUser(Integer clientId, Integer userIdm, String password);
    String getClientNameById(Integer id);
    String toWaitting(Integer id);
    String toCooperation(Integer id);
    String updateClientSum(Integer id,Integer amount);
    Map<String,Long> getOrderStatusDistribution(Integer userId);
    List<Client> getAllClientList(Integer userId);
    List<Integer> getAllClientIdsByUserId(Integer userId);
//    ClientOrderStatusDto getClientOrderStatus(Integer clientId) ;
}