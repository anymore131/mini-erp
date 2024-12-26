package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @author anymore131
 * @since 2024-12-26
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("client_rfm")
public class ClientRfm implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "client_id", type = IdType.NONE)
    private Integer clientId;

    /**
     * 最近一次消费时间
     */
    @TableField("last_order_time")
    private LocalDateTime lastOrderTime;

    /**
     * 消费频率(订单数)
     */
    @TableField("order_frequency")
    private long orderFrequency;

    /**
     * 消费总额(分)
     */
    @TableField("total_amount")
    private Integer totalAmount;

    /**
     * RFM得分
     */
    @TableField("rfm_score")
    private Integer rfmScore;

    /**
     * 客户等级 (ABCD)
     */
    @TableField("customer_level")
    private String customerLevel;

    @TableField("user_id")
    private Integer userId;
}
