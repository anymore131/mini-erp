package cn.edu.zust.se.entity.po;

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
@TableName("contract_risk")
public class ContractRisk implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 合同id
     */
    @TableField("contract_id")
    private Integer contractId;

    /**
     * 风险描述
     */
    @TableField("risk_description")
    private String riskDescription;

    /**
     * 风险等级
     */
    @TableField("risk_level")
    private String riskLevel;

    /**
     * 应对措施
     */
    @TableField("deal")
    private String deal;

    /**
     * 发现风险时间
     */
    @TableField("find_time")
    private LocalDateTime findTime;

    /**
     * 风险当前状态如 “未处理”“处理中”“已解决”等
     */
    @TableField("status")
    private Integer status;

    @TableField("is_delete")
    private Integer isDelete;


}
