package cn.edu.zust.se.mapper;

import cn.edu.zust.se.entity.po.ContractProgress;
import cn.edu.zust.se.entity.query.ContractProgressQuery;
import cn.edu.zust.se.entity.vo.ContractProgressVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 合同进度Mapper接口
 */
@Mapper
public interface ContractProgressMapper extends BaseMapper<ContractProgress> {
    /**
     * 分页查询合同进度
     * @param page 分页参数
     * @param query 查询条件
     * @return 分页结果
     */
    IPage<ContractProgressVo> selectPageVo(IPage<ContractProgressVo> page, @Param("query") ContractProgressQuery query);

    /**
     * 根据合同ID获取最新进度
     * @param contractId 合同ID
     * @return 最新进度
     */
    ContractProgress selectLatestByContractId(@Param("contractId") Integer contractId);
}
