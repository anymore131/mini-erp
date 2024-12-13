package cn.edu.zust.se.config;

import cn.dev33.satoken.stp.StpInterface;
import cn.edu.zust.se.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class StpInterfaceImpl implements StpInterface {
    @Autowired
    private UserMapper userMapper;

    @Override
    public List<String> getPermissionList(Object loginId, String loginType) {
        return null;
    }

    @Override
    public List<String> getRoleList(Object loginId, String loginType) {
        int id = Integer.parseInt((String)loginId);
        String role = userMapper.selectById(id).getRole();
        List<String> list = new ArrayList<String>();
        if (role.equals("admin")){
            list.add("admin");
        }else{
            list.add("user");
        }
        return list;
    }
}