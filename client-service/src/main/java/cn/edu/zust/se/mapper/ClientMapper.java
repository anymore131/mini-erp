package cn.edu.zust.se.mapper;

import cn.edu.zust.se.entity.po.Client;
import cn.edu.zust.se.entity.po.ClientRfm;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author anymore131
 * @since 2024-12-18
 */
@Mapper
public interface ClientMapper extends BaseMapper<Client> {
    @Select("SELECT cr.* FROM client c JOIN client_rfm cr ON c.id = cr.client_id WHERE c.user_id = #{userId} and cr.customer_level = 'A'")
    List<ClientRfm> getClientRfmAByUserId(@Param("userId") Integer userId);
}
