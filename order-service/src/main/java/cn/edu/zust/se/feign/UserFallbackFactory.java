package cn.edu.zust.se.feign;

import cn.edu.zust.se.entity.vo.UserVo;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

@Component
public class UserFallbackFactory implements FallbackFactory<UserFeignServiceI> {
    @Override
    public UserFeignServiceI create(Throwable cause) {
        return new UserFallback();
    }
}

class UserFallback implements UserFeignServiceI {

    @Override
    public String getRole(Integer id) {
        return null;
    }

    @Override
    public String getUserNameById(Integer id) {
        return null;
    }

    @Override
    public UserVo getDeleteUserNameById(Integer id) {
        return null;
    }
}