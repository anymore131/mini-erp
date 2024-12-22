package cn.edu.zust.se.mapper;

import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.vo.ContractVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.*;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;

public interface ContractMapper extends BaseMapper<Contract> {
    //创建合同
    @Insert("insert into erp.contract (client_id, user_id, name, number, order_id, content, sign_time, start_time, end_time, total_amout, last_update, version, status) " +
            "values (#{clientId}, #{userId}, #{name}, #{number}, #{orderId}, #{content}, #{signTime}, #{startTime}, #{endTime}, #{totalAmout}, #{lastUpdate}, 1, 0)")
    void insertContract(Integer clientId, Integer userId, String name, String number, Integer orderId, String content,
                        LocalDateTime signTime, LocalDateTime startTime, LocalDateTime endTime, BigDecimal totalAmout, LocalDateTime lastUpdate);
    @Select("select client_id, user_id, name, number, order_id, content, sign_time, start_time, end_time, total_amout, last_update, version, status " +
            "from contract " +
            "where name = #{name} and is_delete = 0")
    ContractVo getContractByName(String name);
    //获取用户所有合同
    @Select("select client_id, user_id, name, number, order_id, content, sign_time, start_time, end_time, total_amout, last_update, version, status " +
            "from contract " +
            "where user_id = #{userId} and is_delete = 0")
    List<Contract> selectByUserId(Integer userId);
    //通过用户id,只找当前未通过审批的合同，返回数量
    @Select("SELECT COUNT(id) " +
            "from erp.contract " +
            "where user_id = #{userId} and status = 0 and is_delete = 0")
    Integer selectNewContractNumByUserId(@Param("userId") Integer userId,
                                      @Param("nowTime") Date nowTime);
    //通过用户id,只找当前未通过审批的合同，返回具体信息
    @Select("SELECT client_id, user_id, name, number, order_id, content, sign_time, start_time, end_time, total_amout, last_update, version,status " +
            "from erp.contract " +
            "where user_id = #{userId} and status = 0 and is_delete = 0 " +
            "limit #{pageSize} offset ${(pageNo - 1) * pageSize}")
    List<ContractVo> selectNewContractByUserId(@Param("userId") Integer userId,
                                            @Param("pageNo") int pageNo,
                                            @Param("pageSize") int pageSize,
                                            @Param("nowTime") Date nowTime);
    //通过用户id,只找当前时间还没开始并且已经通过审批的合同，返回数量
    @Select("SELECT COUNT(id) " +
            "from erp.contract " +
            "where user_id = #{userId} and status = 1 and date(start_time) between #{nowTime} and '2100-01-01 00:00:00' and is_delete = 0")
    Integer selectContractNumByUserId(@Param("userId") Integer userId,
                               @Param("nowTime") Date nowTime);
    //通过用户id,只找当前时间还没开始并且已经通过审批的合同，返回具体信息
    @Select("SELECT client_id, user_id, name, number, order_id, content, sign_time, start_time, end_time, total_amout, last_update, version,status " +
            "from erp.contract " +
            "where user_id = #{userId} and status = 1 and date(start_time) between #{nowTime} and '2100-01-01 00:00:00' and is_delete = 0 " +
            "limit #{pageSize} offset ${(pageNo - 1) * pageSize}")
    List<ContractVo> selectContractByUserId(@Param("userId") Integer userId,
                                            @Param("pageNo") int pageNo,
                                            @Param("pageSize") int pageSize,
                                            @Param("nowTime") Date nowTime);
    //通过用户id,只找当前时间执行中的合同，返回数量
    @Select("SELECT COUNT(id) " +
            "from erp.contract " +
            "where user_id = #{userId} and status = 2 and #{nowTime} between date(start_time) and date(end_time) and is_delete = 0")
    Integer selectContractNumExecByUserId(@Param("userId") Integer userId,
                                      @Param("nowTime") Date nowTime);
    //通过用户id,只找当前时间执行中的合同，返回具体信息
    @Select("SELECT client_id, user_id, name, number, order_id, content, sign_time, start_time, end_time, total_amout, last_update, version,status " +
            "from erp.contract " +
            "where user_id = #{userId} and status = 2 and #{nowTime} between date(start_time) and date(end_time) and is_delete = 0 " +
            "limit #{pageSize} offset ${(pageNo - 1) * pageSize}")
    List<ContractVo> selectContractExecByUserId(@Param("userId") Integer userId,
                                            @Param("pageNo") int pageNo,
                                            @Param("pageSize") int pageSize,
                                            @Param("nowTime") Date nowTime);
    //获取合同版本号信息
    @Select("select version " +
            "from erp.contract " +
            "where id = #{id} and is_delete = 0")
    Integer getVersion(Integer id);
//    @Update("update erp.contract " +
//            "set client_id = #{clientId},user_id = #{userId}, name =#{name}, number =#{number}, order_id = #{orderId}, content = #{content}, sign_time = #{signTime}, start_time = #{startTime}, end_time = #{endTime}, total_amout = #{totalAmout}, last_update = #{lastUpdate},version = version + 1,status = 0 " +
//            "where id = #{id}")
//    void changeContract(Integer id,Integer clientId, Integer userId, String name, String number, Integer orderId, String content, LocalDateTime signTime, LocalDateTime startTime, LocalDateTime endTime, BigDecimal totalAmout, LocalDateTime lastUpdate);
    //生成新合同，版本号+1，状态置为0，方便追溯合同版本
    @Insert("insert into erp.contract (client_id, user_id, name, number, order_id, content, sign_time, start_time, end_time, total_amout, last_update, version, status) " +
            "values (#{clientId}, #{userId}, #{name}, #{number}, #{orderId}, #{content}, #{signTime}, #{startTime}, #{endTime}, #{totalAmout}, #{lastUpdate}, #{version + 1}, 0)")
    void changeContract(Integer clientId, Integer userId, String name, String number, Integer orderId, String content,
                        LocalDateTime signTime, LocalDateTime startTime, LocalDateTime endTime, BigDecimal totalAmout, LocalDateTime lastUpdate, Integer version);
    //结束旧合同状态
    @Update("update erp.contract " +
            "set status = 3 " +
            "where id = #{id} and is_delete = 0")
    void updateContract(Integer id);
    //合同状态变更
    @Update("update erp.contract " +
            "set status = #{status} " +
            "where id = #{id} and is_delete = 0")
    void updateStatus(Integer id,int status);
    //删除
    @Delete("delete from contract " +
            "where id = #{id} and is_delete = 0")
    int deleteById(Integer id);
    //软删除
    @Delete("update contract " +
            "set is_delete = 1 " +
            "where id = #{id} and is_delete = 0")
    int softDeleteById(Integer id);
}
