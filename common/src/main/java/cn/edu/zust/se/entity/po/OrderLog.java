package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.*;

import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 订单日志表
 * </p>
 *
 * @author anymore131
 * @since 2024-12-21
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("order_log")
public class OrderLog implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 订单ID
     */
    @TableField("order_id")
    private Integer orderId;

    /**
     * 操作人ID
     */
    @TableField("user_id")
    private Integer userId;

    /**
     * 操作类型
     */
    @TableField("action")
    private String action;

    /**
     * 操作内容
     */
    @TableField("content")
    private String content;

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
