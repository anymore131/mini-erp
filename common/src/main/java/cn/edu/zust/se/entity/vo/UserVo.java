package cn.edu.zust.se.entity.vo;

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
public class UserVo {
    private Integer id;
    private String userName;
    private String email;
    private String realName;
    private String phone;
    private String role;
    private LocalDateTime createTime;
    private LocalDateTime lastUpdate;
}
