package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;

import java.time.LocalDate;
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
@TableName("inventory_out_records")
public class InventoryOutRecords implements Serializable {
    /**
     * 出库记录ID，唯一标识每次出库记录
     */
    @TableId(value = "id")
    private Integer id;

    /**
     * 商品ID，关联到商品表
     */
    @TableField("product_id")
    private Integer productId;

    /**
     * 出库数量，出库的商品数量
     */
    @TableField("quantity")
    private Integer quantity;

    /**
     * 出库日期，记录出库的日期
     */
    @TableField("date")
    private LocalDate date;

    /**
     * 出库去向，出库商品的目的地
     */
    @TableField("destination")
    private String destination;

    /**
     * 创建时间，记录出库记录创建的时间
     */
    @TableField("created_time")
    private LocalDateTime createdTime;


}
