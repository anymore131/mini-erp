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
@TableName("order")
public class Order implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 订单编号
     */
    @TableField("order_no")
    private String orderNo;

    /**
     * 客户ID
     */
    @TableField("client_id")
    private Integer clientId;

    /**
     * 销售员ID
     */
    @TableField("user_id")
    private Integer userId;

    /**
     * 订单总金额(分)
     */
    @TableField("total_amount")
    private Integer totalAmount;

    /**
     * 订单状态
     * DRAFT 起草
     * PENDING 待检验
     * APPROVED 检验通过
     * REJECTED 未通过
     * COMPLETED 完成的
     * CANCELLED 取消的
     */
    @TableField("status")
    private String status;

    /**
     * 备注
     */
    @TableField("remark")
    private String remark;

    /**
     * 创建时间
     */
    @TableField("create_time")
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    @TableField("update_time")
    private LocalDateTime updateTime;

    /**
     * 是否删除
     */
    @TableLogic
    private Integer isDelete;
}
