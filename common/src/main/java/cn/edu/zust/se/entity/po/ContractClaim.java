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
@TableName("contract_claim")
public class ContractClaim implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 合同id
     */
    @TableField("contract_id")
    private Integer contractId;

    /**
     * 索赔提出时间
     */
    @TableField(" claim_time")
    private LocalDateTime  claimTime;

    /**
     * 索赔内容如索赔原因、金额等详细信息
     */
    @TableField("claim_description")
    private String claimDescription;

    /**
     * 索赔提出者
     */
    @TableField("user_id")
    private Integer userId;

    /**
     * 索赔状态0“待审查”1“协商中”2“已解决”等
     */
    @TableField("status")
    private Integer status;

    /**
     * 索赔解决时间
     */
    @TableField("resolved_time")
    private LocalDateTime resolvedTime;

    /**
     * 索赔金额
     */
    @TableField("resolved_amount")
    private BigDecimal resolvedAmount;

    @TableField("is_delete")
    private Integer isDelete;


}
