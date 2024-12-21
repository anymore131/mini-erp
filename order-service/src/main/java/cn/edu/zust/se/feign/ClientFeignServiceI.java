package cn.edu.zust.se.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@FeignClient("client-service")
public interface ClientFeignServiceI {
    @PostMapping("/getClientName/{id}")
    String getClientNameById(@PathVariable("id") Integer id);
}
