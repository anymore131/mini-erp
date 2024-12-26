package cn.edu.zust.se.entity.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class ContractApprovalQuery extends PageQuery{
    private Integer contractId;
    private Integer userId;
    private Integer orderId;
    private String startTime;
    private String endTime;
    private String approvalOpinion;
    private String status;
}
