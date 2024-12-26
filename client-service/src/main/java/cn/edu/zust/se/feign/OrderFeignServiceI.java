package cn.edu.zust.se.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;

@FeignClient(value = "order-service")
public interface OrderFeignServiceI {
    @GetMapping("/order/getLastOrderTime/{clientId}")
    public LocalDateTime getLastOrderTime(@PathVariable("clientId") Integer clientId);

    @GetMapping("/order/getOrderFrequency/{clientId}")
    public long getOrderFrequency(@PathVariable("clientId") Integer clientId);

    @GetMapping("/order/getTotalAmount/{clientId}")
    public Integer getTotalAmount(@PathVariable("clientId") Integer clientId);
}
