package cn.edu.zust.se.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient("user-service")
public interface UserFeignServiceI {
    @GetMapping("/getUserName/{id}")
    public String getUserNameById(@PathVariable Integer id);

    @GetMapping("/getRole/{id}")
    public String getRole(@PathVariable Integer id);

    @PostMapping("/checkUser")
    public boolean checkUser(@RequestParam Integer id, @RequestParam String password);
}
