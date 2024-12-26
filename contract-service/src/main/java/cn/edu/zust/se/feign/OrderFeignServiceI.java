package cn.edu.zust.se.feign;

import cn.edu.zust.se.entity.vo.UserVo;
import cn.edu.zust.se.feign.interceptor.FeignInterceptor;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(
        name = "order-service",
        configuration = FeignInterceptor.class,        // 请求拦截器 （关键代码）
        fallbackFactory = OrderFallback.class    // 服务降级处理
)
public interface OrderFeignServiceI {


}
