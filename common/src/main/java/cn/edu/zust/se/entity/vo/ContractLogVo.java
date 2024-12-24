package cn.edu.zust.se.entity.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ContractLogVo {
    private Integer id;
    private Integer contractId;
    private Integer userId;
    private String userName;
    private String action;
    private String content;
    private LocalDateTime createTime;
}
