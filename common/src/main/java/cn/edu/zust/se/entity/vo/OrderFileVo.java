package cn.edu.zust.se.entity.vo;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class OrderFileVo {
    private Integer id;
    private Integer orderId;
    private Integer fileId;
    private FileVo fileVo;
    private String remark;
    private LocalDateTime createTime;
}
