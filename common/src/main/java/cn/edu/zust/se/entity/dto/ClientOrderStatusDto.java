package cn.edu.zust.se.entity.dto;

import lombok.Data;

@Data
public class ClientOrderStatusDto {
    private Integer clientId;
    private String clientName;
    private Integer totalOrders;
    private Integer activeOrders;
    private Integer completedOrders;
    private Double totalAmount;
    private Boolean hasActiveOrders;
    private String latestOrderTime;
}
