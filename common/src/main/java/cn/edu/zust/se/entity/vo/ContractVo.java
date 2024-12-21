package cn.edu.zust.se.entity.vo;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import lombok.Data;

/**
 * <p>
 *
 * </p>
 *
 * @author author
 * @since 2024-12-17
 */
@Data
public class ContractVo{
    private Integer id;
    private String clientId;
    private String userId;
    private String name;
    private String number;
    private String type;
    private String content;
    private LocalDateTime signTime;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private BigDecimal totalAmout;
    private LocalDateTime lastUpdate;
    private Integer version;
    private String status;


}
