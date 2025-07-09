package cn.edu.zust.se.entity.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ClientRfmVo {
    private long clientId;
    private String clientName;
    private long userId;
    private String userName;
    private LocalDateTime lastOrderTime;
    private long frequency;
    private double monetary;
    private int cluster;
    private String tier;
    private long isAnomaly;
    private double churnRisk;
}
