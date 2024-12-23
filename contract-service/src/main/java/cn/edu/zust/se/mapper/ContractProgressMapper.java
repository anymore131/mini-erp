package cn.edu.zust.se.mapper;

import cn.edu.zust.se.entity.po.ContractProgress;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author author
 * @since 2024-12-21
 */
public interface ContractProgressMapper extends BaseMapper<ContractProgress> {
    @Select("SELECT * FROM contract_progress")
    List<ContractProgress> selectAll();

    @Select("SELECT * FROM contract_progress WHERE id = #{id}")
    ContractProgress selectById(Integer id);


    @Delete("DELETE FROM contract_progress WHERE id = #{id}")
    void deleteById(Integer id);
}
