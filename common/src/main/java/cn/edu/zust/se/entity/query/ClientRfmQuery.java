package cn.edu.zust.se.entity.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class ClientRfmQuery extends PageQuery{
    private Integer userId;
    private Integer clientId;
    private String customerLevel;
}
