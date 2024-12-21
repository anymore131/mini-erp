package cn.edu.zust.se.entity.vo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class OrderVo {
    private Integer id;
    private String orderNo;
    private Integer clientId;
    private String clientName;
    private Integer userId;
    private String userName;
    private Integer totalAmount;
    private String status;
    private String remark;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
