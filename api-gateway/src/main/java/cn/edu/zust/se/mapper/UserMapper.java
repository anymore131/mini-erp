package cn.edu.zust.se.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserMapper {
    @Select("select role from user where id = #{id}")
    public String getRole(int id);
}
