package cn.edu.zust.se.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient("user-service")
public interface UserFeignServiceI {
    @GetMapping("/getUserName/{id}")
    public String getUserNameById(@PathVariable Integer id);

    @GetMapping("/getRole/{id}")
    public String getRole(@PathVariable Integer id);
}
