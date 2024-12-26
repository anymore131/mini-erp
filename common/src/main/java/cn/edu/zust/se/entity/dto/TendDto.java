package cn.edu.zust.se.entity.dto;

import lombok.Data;

import java.sql.Date;
import java.time.LocalDateTime;

@Data
public class TendDto {
    private LocalDateTime date;
    private Long newCount;
    private Long completedCount;
}