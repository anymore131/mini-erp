package cn.edu.zust.se.feign.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@FeignClient("client-service")
public interface ClientFeignServiceI {
    @PostMapping("/signOut/{id}")
    public String signOut(@PathVariable Integer id);
}
