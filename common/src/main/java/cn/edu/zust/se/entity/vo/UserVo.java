package cn.edu.zust.se.entity.vo;

import lombok.Data;

import java.time.LocalDateTime;

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
