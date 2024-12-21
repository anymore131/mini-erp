package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.*;

import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 订单明细表
 * </p>
 *
 * @author anymore131
 * @since 2024-12-21
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("order_item")
public class OrderItem implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 订单ID
     */
    @TableField("order_id")
    private Integer orderId;

    /**
     * 产品名称
     */
    @TableField("product_name")
    private String productName;

    /**
     * 数量
     */
    @TableField("quantity")
    private Integer quantity;

    /**
     * 单价(分)
     */
    @TableField("unit_price")
    private Integer unitPrice;

    /**
     * 总价(分)
     */
    @TableField("total_price")
    private Integer totalPrice;

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
     * 是否删除
     */
    @TableLogic
    private Integer isDelete;
}
