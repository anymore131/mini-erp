package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.*;

import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @author anymore131
 * @since 2024-12-21
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("order_approval")
public class OrderApproval implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 订单ID
     */
    @TableField("order_id")
    private Integer orderId;

    /**
     * 审批人ID
     */
    @TableField("approver_id")
    private Integer approverId;

    /**
     * 审批状态
     */
    @TableField("status")
    private String status;

    /**
     * 审批意见
     */
    @TableField("comment")
    private String comment;

    /**
     * 审批时间
     */
    @TableField("approve_time")
    private LocalDateTime approveTime;

    /**
     * 创建时间
     */
    @TableField("create_time")
    private LocalDateTime createTime;

    /**
     * 是否删除
     */
    @TableLogic
    private Integer isDelete;
}
