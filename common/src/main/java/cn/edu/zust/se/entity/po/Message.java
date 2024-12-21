package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *
 * @author author
 * @since 2024-12-20
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("message")
public class Message implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 通知内容
     */
    private String content;

    /**
     * 通知类型，0'status_change', 1'reminder',2‘other’
     */
    private Integer type;

    /**
     * 通知发送时间
     */
    private LocalDateTime sendTime;

    /**
     * 合同id
     */
    private Integer contractId;

    /**
     * 收到通知单的用户id
     */
    private Integer userId;

    private Integer isDelete;


}
