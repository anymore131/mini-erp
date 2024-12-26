package cn.edu.zust.se.entity.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * 合同进度VO
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ContractProgressVo {
    /**
     * ID
     */
    private Integer id;

    /**
     * 合同ID
     */
    private Integer contractId;

    /**
     * 进度记录日期
     */
    private LocalDateTime progressTime;

    /**
     * 进度类型
     */
    private String type;

    /**
     * 进度详情
     */
    private String detail;

    /**
     * 版本号
     */
    private Integer version;

    /**
     * 执行人ID
     */
    private Integer userId;

    /**
     * 执行人姓名
     */
    private String userName;

    /**
     * 风险问题
     */
    private String riskIssues;
}
