package cn.edu.zust.se.entity.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class OrderQuery extends PageQuery {
    private String orderNo;
    private Integer clientId;
    private Integer userId;
    private String status;
    private Integer minAmount;
    private Integer maxAmount;
    private String createTime;
    private String updateTime;
}
