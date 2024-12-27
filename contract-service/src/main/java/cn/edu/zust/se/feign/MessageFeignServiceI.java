package cn.edu.zust.se.feign;

import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.Message;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(value = "message-service")
public interface MessageFeignServiceI {
    
    @PostMapping("/message/add")
    SaResult add(@RequestBody Message message);
} 