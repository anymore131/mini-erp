package cn.edu.zust.se.entity.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class OrderLogQuery extends PageQuery{
    private String orderNo;
    private String userName;
    private String action;
}
