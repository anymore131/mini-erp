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
@TableName("expense_reimbursements")
public class ExpenseReimbursements implements Serializable {
    /**
     * 报销ID，唯一标识每笔报销
     */
    @TableId(value = "id")
    private Integer id;

    /**
     * 员工ID，报销人的员工ID
     */
    @TableField("employee_id")
    private Integer employeeId;

    /**
     * 报销金额，报销的金额
     */
    @TableField("amount")
    private BigDecimal amount;

    /**
     * 报销描述，报销的详细描述
     */
    @TableField("description")
    private String description;

    /**
     * 报销状态，如待审批、已批准等
     */
    @TableField("status")
    private String status;

    /**
     * 创建时间，记录报销信息创建的时间
     */
    @TableField("created_time")
    private LocalDateTime createdTime;

    /**
     * 更新时间，记录报销信息最后更新的时间
     */
    @TableField("updated_time")
    private LocalDateTime updatedTime;


}
