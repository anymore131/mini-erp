package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @author anymore131
 * @since 2024-11-16
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("customer_interactions")
public class CustomerInteractions implements Serializable {
    /**
     * 互动记录ID，唯一标识每次互动
     */
    @TableId(value = "id")
    private Integer id;

    /**
     * 客户ID，关联到客户表
     */
    @TableField("customer_id")
    private Integer customerId;

    /**
     * 互动类型，如电话、邮件等
     */
    @TableField("interaction_type")
    private String interactionType;

    /**
     * 互动内容，记录互动的具体内容
     */
    @TableField("content")
    private String content;

    /**
     * 创建时间，记录互动发生的时间
     */
    @TableField("created_time")
    private LocalDateTime createdTime;


}
