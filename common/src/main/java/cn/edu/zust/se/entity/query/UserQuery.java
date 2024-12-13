package cn.edu.zust.se.entity.query;

import lombok.Data;

@Data
public class UserQuery extends PageQuery{
    private String userName;
    private String realName;
    private String role;
}
