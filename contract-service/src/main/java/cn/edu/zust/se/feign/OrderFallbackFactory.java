package cn.edu.zust.se.feign;

import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

@Component
public class OrderFallbackFactory implements FallbackFactory<OrderFeignServiceI> {
    @Override
    public OrderFeignServiceI create(Throwable cause) {
        return new OrderFallback();
    }
}

class OrderFallback implements OrderFeignServiceI {

}