package cn.edu.zust.se.feign;

import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

@Component
public class ClientFallbackFactory implements FallbackFactory<ClientFeignServiceI> {
    @Override
    public ClientFeignServiceI create(Throwable cause) {
        return new ClientFallback();
    }
}

class ClientFallback implements ClientFeignServiceI {
    @Override
    public String getClientNameById(Integer id) {
        return null;
    }
}