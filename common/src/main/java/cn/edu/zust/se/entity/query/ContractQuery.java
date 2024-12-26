package cn.edu.zust.se.entity.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;

@EqualsAndHashCode(callSuper = true)
@Data
public class ContractQuery extends PageQuery{
    private Integer clientId;
    private Integer userId;
    private String name;
    private String number;
    private Integer orderId;
    private String content;
    private String signTime;
    private String startTime;
    private String endTime;
    private BigDecimal totalAmout;
    private String lastUpdate;
    private Integer version;
    private String status;
}