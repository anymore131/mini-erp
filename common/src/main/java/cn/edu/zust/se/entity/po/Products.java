package cn.edu.zust.se.entity.po;

import java.math.BigDecimal;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
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
@TableName("products")
public class Products implements Serializable {
    /**
     * 商品ID，唯一标识每个商品
     */
    @TableId(value = "id")
    private Integer id;

    /**
     * 商品名称，商品的名称
     */
    @TableField("name")
    private String name;

    /**
     * 商品描述，商品的详细描述
     */
    @TableField("description")
    private String description;

    /**
     * 商品分类，商品的分类标签
     */
    @TableField("category")
    private String category;

    /**
     * 供应商
     */
    @TableField("supplier_id")
    private Integer supplierId;

    /**
     * 成本价，商品的成本价格
     */
    @TableField("cost_price")
    private BigDecimal costPrice;

    /**
     * 销售价，商品的销售价格
     */
    @TableField("sale_price")
    private BigDecimal salePrice;

    /**
     * 库存数量，商品的库存数量
     */
    @TableField("stock_quantity")
    private Integer stockQuantity;

    /**
     * 创建时间，记录商品信息创建的时间
     */
    @TableField("created_time")
    private LocalDateTime createdTime;

    /**
     * 更新时间，记录商品信息最后更新的时间
     */
    @TableField("updated_time")
    private LocalDateTime updatedTime;


}
