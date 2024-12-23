package cn.edu.zust.se.entity.po;

import java.math.BigDecimal;

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
 * <p>
 * 
 * </p>
 *
 * @author author
 * @since 2024-12-22
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("contract_payment")
public class ContractPayment implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("contract_id")
    private Integer contractId;

    /**
     * 付款时间
     */
    @TableField("payment_time")
    private LocalDateTime paymentTime;

    /**
     * 付款金额
     */
    @TableField("amount")
    private BigDecimal amount;

    /**
     * 付款方式
     */
    @TableField("method")
    private String method;

    /**
     * 付款备注
     */
    @TableField("note")
    private String note;

    /**
     * 负责员工id
     */
    @TableField("user_id")
    private Integer userId;

    @TableField("is_delete")
    private Integer isDelete;


}
