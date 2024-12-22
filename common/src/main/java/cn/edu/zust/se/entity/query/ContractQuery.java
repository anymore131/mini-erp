package cn.edu.zust.se.entity.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@EqualsAndHashCode(callSuper = true)
@Data
public class ContractQuery extends PageQuery{
    private Integer clientId;
    private Integer userId;
    private String name;
    private String number;
    private Integer orderId;
    private String content;
    private LocalDateTime signTime;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private BigDecimal totalAmout;
    private LocalDateTime lastUpdate;
    private Integer version;
    private String status;
}