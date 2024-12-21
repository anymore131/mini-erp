package cn.edu.zust.se.entity.vo;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class OrderApprovalVo {
    private Integer id;
    private Integer orderId;
    private Integer approverId;

    private String approverName;

    private String status;
    private String comment;
    private LocalDateTime approveTime;
    private LocalDateTime createTime;
}
