package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.*;

import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @author anymore131
 * @since 2024-12-18
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("client")
public class Client implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.NONE)
    private Integer id;

    @TableField("name")
    private String name;

    @TableField("mobile")
    private String mobile;

    @TableField("email")
    private String email;

    @TableField("sum")
    private Integer sum;

    @TableField("user_id")
    private Integer userId;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("last_time")
    private LocalDateTime lastTime;

    @TableField("status")
    private Integer status;

    @TableLogic
    private Integer isDelete;
}
