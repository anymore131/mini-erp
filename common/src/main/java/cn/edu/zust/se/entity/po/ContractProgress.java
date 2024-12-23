package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *
 * @author author
 * @since 2024-12-21
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("contract_progress")
public class ContractProgress implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 合同id
     */
    private Integer contractId;

    /**
     * 进度记录日期，表明该进度是何时更新的
     */
    private LocalDateTime progressTime;

    /**
     * 进度类型，例如 “货物交付进度”“服务完成百分比”“收款进度” 等，用于区分不同方面的进展情况
     */
    private String type;

    /**
     * 进度细节详细描述内容，如交付了多少货物、服务完成到什么程度、本次收款金额等具体信息
     */
    private String detail;

    /**
     * 对于执行进度的更新，设置版本号字段，每次更新进度时版本号递增，便于数据的版本控制和历史追溯
     */
    private Integer version;

    /**
     * 确定执行人id
     */
    private Integer userId;

    /**
     * 记录执行过程中出现的风险问题
     */
    private String riskIssues;

    private Integer isDelete;


}
