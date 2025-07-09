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
    private long clientId;

    @TableField("last_order_time")
    private LocalDateTime lastOrderTime;

    @TableField("Frequency")
    private long frequency;

    @TableField("Monetary")
    private double monetary;

    @TableField("cluster")
    private int cluster;

    @TableField("tier")
    private String tier;

    @TableField("is_anomaly")
    private long isAnomaly;

    @TableField("churn_risk")
    private double churnRisk;
}
