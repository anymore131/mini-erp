package cn.edu.zust.se.entity.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class MessageVo {
    private Integer id;
    private String content;
    private Integer type;
    private LocalDateTime sendTime;
    private Integer contractId;
    private Integer userId;
}
