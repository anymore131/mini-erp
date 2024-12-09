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
@TableName("Client")
public class Client implements Serializable {
    @TableId(value = "id")
    private Integer id;

    @TableField("name")
    private String name;

    @TableField("mobile")
    private String mobile;

    @TableField("email")
    private String email;

    @TableField("sum")
    private String sum;

    @TableField("createTime")
    private Date createTime;

    @TableField("lastTime")
    private Date lastTime;

    @TableField("status")
    private int status;

    @TableField("is_delete")
    private Integer isDelete;

}
