package cn.edu.zust.se.entity.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class ClientQuery extends PageQuery{
    private String name;
    private Integer sum;
    private Integer userId;
    private String status;
}
