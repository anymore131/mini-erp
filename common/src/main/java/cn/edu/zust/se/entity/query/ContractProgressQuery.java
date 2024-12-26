package cn.edu.zust.se.entity.query;


import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 合同进度查询参数
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ContractProgressQuery extends PageQuery {
    /**
     * 合同ID
     */
    private Integer contractId;

    /**
     * 执行人ID
     */
    private Integer userId;

    /**
     * 进度类型
     */
    private String type;

    /**
     * 开始时间
     */
    private String startTime;

    /**
     * 结束时间
     */
    private String endTime;
}
