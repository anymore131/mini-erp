package cn.edu.zust.se.entity.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
public class ClientRfmVo {
    private Integer clientId;
    private String clientName;
    private LocalDateTime lastOrderTime;
    private Integer orderFrequency;
    private Integer totalAmount;
    private Integer rfmScore;
    private String customerLevel;
    private Integer userId;
    private String userName;
}
