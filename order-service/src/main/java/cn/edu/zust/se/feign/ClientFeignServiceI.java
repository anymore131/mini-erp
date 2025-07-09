package cn.edu.zust.se.feign;

import cn.edu.zust.se.feign.interceptor.FeignInterceptor;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@FeignClient(
        name = "client-service",
        configuration = FeignInterceptor.class,        // 请求拦截器 （关键代码）
        fallbackFactory = ClientFallback.class    // 服务降级处理
)
public interface ClientFeignServiceI {
    @GetMapping("/getClientName/{id}")
    String getClientNameById(@PathVariable("id") Integer id);

    @PostMapping("/toWaitting/{id}")
    String toWaitting(@PathVariable("id") Integer id);

    @PostMapping("/toCooperation/{id}")
    String toCooperation(@PathVariable("id") Integer id);

    @PostMapping("/updateClientSum/{id}/{amount}")
    String updateClientSum(@PathVariable("id") Integer id
            , @PathVariable("amount") Integer amount);

    @GetMapping("/client-rfm/update")
    void updateManual();
}
