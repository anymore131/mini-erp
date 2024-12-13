package cn.edu.zust.se.feign.client;

import cn.edu.zust.se.entity.vo.UserVo;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;


@Component
public class UserServiceFallbackFactory implements FallbackFactory<UserClient> {
    @Override
    public UserClient create(Throwable cause) {
        return new UserServiceFallback();
    }
}

class UserServiceFallback implements UserClient {
    @Override
    public UserVo getUserById(Long id) {
        // 返回默认值或处理异常
        return new UserVo();
    }
}