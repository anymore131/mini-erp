package cn.edu.zust.se.entity.vo;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class OrderLogVo {
    private Integer id;
    private Integer orderId;
    private Integer userId;
    private String action;
    private String content;
    private LocalDateTime createTime;
}
