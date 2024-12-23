package cn.edu.zust.se.entity.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

@EqualsAndHashCode(callSuper = true)
@Data
public class MessageQuery extends PageQuery{
    private Integer id;
    private String content;
    private Integer type;
    private LocalDateTime sendTime;
    private Integer contractId;
    private Integer userId;
}
