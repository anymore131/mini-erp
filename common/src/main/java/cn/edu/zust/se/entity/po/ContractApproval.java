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
@TableName("contract_approval")
public class ContractApproval implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 合同id
     */
    private Integer contractId;

    /**
     * 审批人id
     */
    private Integer userId;


    /**
     * 审批开始时间
     */
    private LocalDateTime startTime;

    /**
     * 审批结束时间
     */
    private LocalDateTime endTime;

    /**
     * 审批意见，审批人填写的对合同的看法、修改建议或批准说明等内容
     */
    private String approvalOpinion;

    /**
     * 审批结果，0 表示未批准，1 表示批准，2表示需修改，方便后续判断合同审批是否通过
     */
    private int status;


    private Integer isDelete;


}
