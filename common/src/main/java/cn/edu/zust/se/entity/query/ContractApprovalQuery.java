package cn.edu.zust.se.entity.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

@EqualsAndHashCode(callSuper = true)
@Data
public class ContractApprovalQuery extends PageQuery{
    private Integer contractId;
    private Integer userId;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String approvalOpinion;
    private int status;
}
