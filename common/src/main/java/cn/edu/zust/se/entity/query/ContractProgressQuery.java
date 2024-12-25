package cn.edu.zust.se.entity.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

@EqualsAndHashCode(callSuper = true)
@Data
public class ContractProgressQuery extends PageQuery{
    private Integer contractId;
    private LocalDateTime progressTime;
    private String type;
    private String detail;
    private Integer version;
    private Integer userId;
    private String riskIssues;
}
