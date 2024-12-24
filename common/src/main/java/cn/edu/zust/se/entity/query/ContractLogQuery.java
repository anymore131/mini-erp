package cn.edu.zust.se.entity.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class ContractLogQuery extends PageQuery{
    private String contractId;
    private Integer userId;
    private String userName;
    private String action;
}
