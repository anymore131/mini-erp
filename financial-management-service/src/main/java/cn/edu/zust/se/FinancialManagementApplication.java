package cn.edu.zust.se;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@EnableDiscoveryClient
@SpringBootApplication
@EnableFeignClients
public class FinancialManagementApplication {
    public static void main(String[] args) {
        SpringApplication.run(FinancialManagementApplication.class, args);
        System.out.println("财务管理服务启动成功 ヾ(￣ー￣)X(^▽^)ゞ");
    }
}
