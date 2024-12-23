package cn.edu.zust.se.entity.vo;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class OrderLogVo {
    private Integer id;
    private Integer orderId;
    private String orderNo;
    private Integer userId;
    private String userName;
    private String action;
    private String content;
    private LocalDateTime createTime;
}
