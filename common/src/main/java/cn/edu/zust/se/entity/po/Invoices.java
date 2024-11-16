package cn.edu.zust.se.entity.po;

import java.math.BigDecimal;

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
@TableName("invoices")
public class Invoices implements Serializable {
    /**
     * 发票ID，唯一标识每张发票
     */
    @TableId(value = "id")
    private Integer id;

    /**
     * 发票号码，唯一的发票编号
     */
    @TableField("invoice_number")
    private String invoiceNumber;

    /**
     * 客户ID，关联到客户表
     */
    @TableField("customer_id")
    private Integer customerId;

    /**
     * 发票金额，发票的总金额
     */
    @TableField("amount")
    private BigDecimal amount;

    /**
     * 开票日期，记录发票开具的日期
     */
    @TableField("issue_date")
    private LocalDate issueDate;

    /**
     * 发票状态，如已开、已收等
     */
    @TableField("status")
    private String status;

    /**
     * 创建时间，记录发票信息创建的时间
     */
    @TableField("created_time")
    private LocalDateTime createdTime;


}
