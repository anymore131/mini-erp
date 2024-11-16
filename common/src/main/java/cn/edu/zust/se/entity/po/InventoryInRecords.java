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
@TableName("inventory_in_records")
public class InventoryInRecords implements Serializable {
    /**
     * 入库记录ID，唯一标识每次入库记录
     */
    @TableId(value = "id")
    private Integer id;

    /**
     * 商品ID，关联到商品表
     */
    @TableField("product_id")
    private Integer productId;

    /**
     * 入库数量，入库的商品数量
     */
    @TableField("quantity")
    private Integer quantity;

    /**
     * 入库日期，记录入库的日期
     */
    @TableField("date")
    private LocalDate date;

    /**
     * 创建时间，记录入库记录创建的时间
     */
    @TableField("created_time")
    private LocalDateTime createdTime;


}
