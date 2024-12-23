package cn.edu.zust.se.entity.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class OrderItemQuery extends PageQuery{
    private Integer orderId;
    private String orderNo;
    private String productName;
    private Integer unitPriceStart;
    private Integer unitPriceEnd;
    private Integer totalPriceStart;
    private Integer totalPriceEnd;
}
