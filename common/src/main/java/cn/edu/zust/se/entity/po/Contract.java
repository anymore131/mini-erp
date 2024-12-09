package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
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
@TableName("Contract")
public class Contract implements Serializable {
    @TableId(value = "id")
    private Integer id;

    @TableField("name")
    private String name;

    @TableField("number")
    private String number;

    @TableField("type")
    private String type;

    @TableField("signTime")
    private Date signTime;

    @TableField("startTime")
    private Date startTime;

    @TableField("endTime")
    private Date endTime;

    @TableField("lastUpdate")
    private Date lastUpdate;

    @TableField("totalAmount")
    private float totalAmount;

    @TableField("is_delete")
    private Integer isDelete;

    @TableId(value = "clientId")
    private Integer clientId;

    @TableId(value = "userId")
    private Integer userId;
}
