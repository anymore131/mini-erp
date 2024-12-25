package cn.edu.zust.se.entity.vo;

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
 * @since 2024-12-21
 */
@Data
public class ContractApprovalVo{
    private Integer id;
    private Integer contractId;
    private Integer userId;
    private String userName;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String approvalOpinion;
    private String status;
}
