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
@TableName("financial_transactions")
public class FinancialTransactions implements Serializable {
    /**
     * 交易ID，唯一标识每笔交易
     */
    @TableId(value = "id")
    private Integer id;

    /**
     * 交易类型，如收入、支出
     */
    @TableField("transaction_type")
    private String transactionType;

    /**
     * 金额，交易的金额
     */
    @TableField("amount")
    private BigDecimal amount;

    /**
     * 交易描述，交易的详细描述
     */
    @TableField("description")
    private String description;

    /**
     * 交易日期，记录交易发生的日期
     */
    @TableField("date")
    private LocalDate date;

    /**
     * 创建时间，记录交易信息创建的时间
     */
    @TableField("created_time")
    private LocalDateTime createdTime;


}
