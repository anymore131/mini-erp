package cn.edu.zust.se.mapper;

import cn.edu.zust.se.entity.po.ContractTemplate;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDateTime;
import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author author
 * @since 2024-12-09
 */
public interface ContractTemplateMapper extends BaseMapper<ContractTemplate> {
    @Insert("insert into contract_template " +
            "(name,content,description,create_time,status,user_id,is_delete) " +
            "values(#{name},#{content},#{description},#{createTime},#{status},#{userId},0) ")
    void insertContractTemplate(String name, String content, String description, LocalDateTime createTime, int status, Integer userId);
    @Select("select name,content,description,create_time,status " +
            "from contract_template " +
            "where user_id = #{userId}")
    List<ContractTemplate> selectContractTemplatesByUserId(Integer userId);
}
