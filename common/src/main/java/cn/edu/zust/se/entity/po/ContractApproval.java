package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serializable;
import java.util.Date;

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
@TableName("ContractApproval")
public class ContractApproval implements Serializable {
    @TableId(value = "id")
    private Integer id;

    @TableField("type")
    private String type;

    @TableField("startTime")
    private Date startTime;

    @TableField("endTime")
    private Date endTime;

    @TableField("approvalOpinion")
    private String approvalOpinion;

    @TableField("status")
    private int status;

    @TableField("deadLine")
    private Date deadLine;

    @TableId(value = "clientId")
    private Integer clientId;

    @TableId(value = "userId")
    private Integer userId;
}
