package cn.edu.zust.se.feign;

import cn.edu.zust.se.entity.vo.UserVo;
import cn.edu.zust.se.feign.interceptor.FeignInterceptor;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(
        name = "user-service",
        configuration = FeignInterceptor.class,        // 请求拦截器 （关键代码）
        fallbackFactory = UserFallback.class    // 服务降级处理
)
public interface UserFeignServiceI {
    @GetMapping("/getRole/{id}")
    String getRole(@PathVariable Integer id);

    @GetMapping("/getUserName/{id}")
    String getUserNameById(@PathVariable("id") Integer id);

    @GetMapping("/getDeleteUserById/{id}")
    UserVo getDeleteUserNameById(@PathVariable("id") Integer id);
}
