package cn.edu.zust.se.entity.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ClientVo {
    private Integer id;
    private String name;
    private String mobile;
    private String email;
    private Integer sum;
    private Integer userId;
    private String userName;
    private LocalDateTime createTime;
    private LocalDateTime lastTime;
    private String status;
}
