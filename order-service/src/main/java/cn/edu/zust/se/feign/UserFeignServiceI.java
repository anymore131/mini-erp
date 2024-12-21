package cn.edu.zust.se.feign;

import cn.edu.zust.se.entity.vo.UserVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@FeignClient("user-service")
public interface UserFeignServiceI {
    @GetMapping("/getRole/{id}")
    String getRole(@PathVariable Integer id);

    @PostMapping("/getUserName/{id}")
    String getUserNameById(@PathVariable("id") Integer id);

    @PostMapping("/getDeleteUserById/{id}")
    UserVo getDeleteUserNameById(@PathVariable("id") Integer id);
}
