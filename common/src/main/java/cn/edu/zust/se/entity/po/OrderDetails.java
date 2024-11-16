package cn.edu.zust.se.entity.po;

import java.math.BigDecimal;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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
@TableName("order_details")
public class OrderDetails implements Serializable {
    /**
     * 订单详情ID，唯一标识每个订单详情
     */
    @TableId(value = "id")
    private Integer id;

    /**
     * 订单ID，关联到订单表
     */
    @TableField("order_id")
    private Integer orderId;

    /**
     * 产品ID，关联到商品表
     */
    @TableField("product_id")
    private Integer productId;

    /**
     * 数量，订单中产品的数量
     */
    @TableField("quantity")
    private Integer quantity;

    /**
     * 单价，产品的单价
     */
    @TableField("price")
    private BigDecimal price;

    /**
     * 小计，订单中产品的总价
     */
    @TableField("subtotal")
    private BigDecimal subtotal;


}
