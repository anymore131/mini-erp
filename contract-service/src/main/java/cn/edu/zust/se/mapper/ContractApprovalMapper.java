package cn.edu.zust.se.mapper;

import cn.edu.zust.se.entity.po.ContractApproval;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author author
 * @since 2024-12-21
 */
public interface ContractApprovalMapper extends BaseMapper<ContractApproval> {
    //审批列表
    @Select("select contract_id, user_id, start_time, end_time, approval_opinion, status " +
            "from contract_approval " +
            "where is_delete = 0 " +
            "order by start_time desc")
    List<ContractApproval> selectAll();
    //根据id查询
    @Select("select contract_id, user_id, start_time, end_time, approval_opinion, status " +
            "from contract_approval " +
            "where id = #{id} and is_delete = 0 " +
            "order by start_time desc")
    ContractApproval selectById(Integer id);
    //根据合同id查询
    @Select("select contract_id, user_id, start_time, end_time, approval_opinion, status " +
            "from contract_approval " +
            "where contract_id = #{contractId} and is_delete = 0 " +
            "order by start_time desc")
    List<ContractApproval> selectByContractId(Integer contractId);
    //根据用户id查询
    @Select("select contract_id, user_id, start_time, end_time, approval_opinion, status " +
            "from contract_approval " +
            "where user_id = #{userId} and is_delete = 0 " +
            "order by start_time desc")
    List<ContractApproval> selectByUserId(Integer userId);
    //根据状态查询
    @Select("select contract_id, user_id, start_time, end_time, approval_opinion, status " +
            "from contract_approval " +
            "where status = #{status} and is_delete = 0 " +
            "order by start_time desc")
    List<ContractApproval> selectByStatus(Integer status);
    //插入
    @Insert("insert into contract_approval (contract_id, user_id, start_time, end_time, approval_opinion, status, is_delete) " +
            "values (#{contractId}, #{userId}, #{startTime}, #{endTime}, #{approvalOpinion}, 0, 0)")
    int insert(ContractApproval contractApproval);
    //更新
    @Update("update contract_approval " +
            "set contract_id = #{contractId}, user_id = #{userId}, start_time = #{startTime}, " +
            "end_time = #{endTime}, approval_opinion = #{approvalOpinion}, status = #{status} " +
            "where id = #{id} and is_delete = 0")
    int updateById(ContractApproval contractApproval);
    //删除
    @Delete("delete from contract_approval " +
            "where id = #{id} and is_delete = 0")
    int deleteById(Integer id);
    //软删除
    @Delete("update contract_approval " +
            "set is_delete = 1 " +
            "where id = #{id} and is_delete = 0")
    int softDeleteById(Integer id);
    //分页查询，按start_time降序排列
    @Select("select contract_id, user_id, start_time, end_time, approval_opinion, status " +
            "from contract_approval " +
            "where is_delete = 0 " +
            "order by start_time desc")
    Page<ContractApproval> selectPageByStartTime(Page<ContractApproval> page);
    //分页查询，按start_time降序排列
    @Select("select contract_id, user_id, start_time, end_time, approval_opinion, status " +
            "from contract_approval " +
            "where user_id = #{userId} and contract_id = #{contractId} and status = #{status} and is_delete = 0 " +
            "order by start_time desc " +
            "limit #{pageSize} offset ${(pageNo - 1) * pageSize} "
            )
    Page<ContractApproval> selectPageByStartTimeAsc(Integer contractId,Integer userId,int status,int pageNo,int pageSize);
}
