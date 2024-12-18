package cn.edu.zust.se.feign.client;

import cn.edu.zust.se.entity.vo.UserVo;
import cn.edu.zust.se.feign.interceptor.FeignInterceptor;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 服务调用
 */
@FeignClient(
        name = "sp-home",                 // 服务名称
        configuration = FeignInterceptor.class,        // 请求拦截器 （关键代码）
        fallbackFactory = UserServiceFallbackFactory.class    // 服务降级处理
)
public interface UserClient {

    @GetMapping("/users/{id}")
    UserVo getUserById(@PathVariable("id") Long id);


}