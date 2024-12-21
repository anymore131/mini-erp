package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
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
@TableName("user")
public class User implements Serializable {
    @TableId(value = "id")
    private Integer id;

    @TableField("user_name")
    private String userName;

    @TableField("password")
    private String password;

    @TableField("email")
    private String email;

    @TableField("real_name")
    private String realName;

    @TableField("phone")
    private String phone;

    @TableField("role")
    private String role;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("last_update")
    private LocalDateTime lastUpdate;

    @TableLogic
    private Integer isDelete;
}
