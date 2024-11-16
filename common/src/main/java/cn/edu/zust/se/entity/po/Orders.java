package cn.edu.zust.se.entity.po;

import java.math.BigDecimal;

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
@TableName("orders")
public class Orders implements Serializable {
    /**
     * 订单ID，唯一标识每个订单
     */
    @TableId(value = "id")
    private Integer id;

    /**
     * 客户ID，关联到客户表
     */
    @TableField("customer_id")
    private Integer customerId;

    /**
     * 订单号，唯一的订单编号
     */
    @TableField("order_number")
    private String orderNumber;

    /**
     * 订单总金额，订单的总金额
     */
    @TableField("total_amount")
    private BigDecimal totalAmount;

    /**
     * 订单状态，如待支付、已发货、已完成等
     */
    @TableField("status")
    private String status;

    /**
     * 创建时间，记录订单创建的时间
     */
    @TableField("created_time")
    private LocalDateTime createdTime;

    /**
     * 更新时间，记录订单最后更新的时间
     */
    @TableField("updated_time")
    private LocalDateTime updatedTime;


}
