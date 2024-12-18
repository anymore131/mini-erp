package cn.edu.zust.se.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient("user-service")
public interface UserFeignServiceI {
    @GetMapping("/user/getUserName")
    public String getUserNameById(@PathVariable Integer id);
}
