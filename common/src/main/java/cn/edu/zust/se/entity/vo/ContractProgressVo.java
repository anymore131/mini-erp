package cn.edu.zust.se.entity.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ContractProgressVo {
    private Integer id;
    private Integer contractId;
    private LocalDateTime progressTime;
    private String type;
    private String detail;
    private Integer version;
    private Integer userId;
    private String riskIssues;
}
