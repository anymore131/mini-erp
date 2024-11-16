package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author anymore131
 * @since 2024-11-16
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("logistics_info")
public class LogisticsInfo implements Serializable {
    /**
     * 物流信息ID，唯一标识每次物流信息
     */
    @TableId(value = "id")
    private Integer id;

    /**
     * 订单ID，关联到订单表
     */
    @TableField("order_id")
    private Integer orderId;

    /**
     * 物流单号，物流公司的单号
     */
    @TableField("tracking_number")
    private String trackingNumber;

    /**
     * 物流公司，物流服务提供商的名称
     */
    @TableField("carrier")
    private String carrier;

    /**
     * 物流状态，如已发货、配送中、已签收等
     */
    @TableField("status")
    private String status;

    /**
     * 创建时间，记录物流信息创建的时间
     */
    @TableField("created_time")
    private LocalDateTime createdTime;

    /**
     * 更新时间，记录物流信息最后更新的时间
     */
    @TableField("updated_time")
    private LocalDateTime updatedTime;


}
