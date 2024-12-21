package cn.edu.zust.se.entity.vo;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class OrderItemVo {
    private Integer id;
    private Integer orderId;
    private String productName;
    private Integer quantity;
    private Integer unitPrice;
    private Integer totalPrice;
    private String remark;
    private LocalDateTime createTime;
}
