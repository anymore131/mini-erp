package cn.edu.zust.se.task;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
@Slf4j
@RequiredArgsConstructor
public class ClientRfmTask {
    private final RestTemplate restTemplate;

    @Scheduled(cron = "0 0 0 * * ?")//每天0点执行
    public void resetsNumber(){
        restTemplate.getForObject("http://localhost:8000/client-analysis/all", String.class);
    }
}
