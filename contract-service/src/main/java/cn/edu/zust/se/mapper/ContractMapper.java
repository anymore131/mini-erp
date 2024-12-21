package cn.edu.zust.se.mapper;

import cn.edu.zust.se.entity.po.Contract;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ContractMapper extends BaseMapper<Contract> {

    @Select("select client_id, user_id, name, number, type, content, sign_time, start_time, end_time, total_amout, last_update, version, status from contract where user_id = #{userId}")
    List<Contract> selectByUserId(Integer userId);
}
