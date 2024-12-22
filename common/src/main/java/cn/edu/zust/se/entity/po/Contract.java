package cn.edu.zust.se.entity.po;

import java.math.BigDecimal;

import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author author
 * @since 2024-12-17
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("contract")
public class Contract implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 客户id，对应客户信息
     */

    private Integer clientId;

    /**
     * 职工id,对应职工信息

     */
    private Integer userId;

    /**
     * 合同名称
     */
    private String name;

    /**
     * 合同编号
     */
    private String number;

    /**
     * 订单id,对应订单信息
     */
    private Integer orderId;

    /**
     * 合同内容
     */
    private String content;

    /**
     * 合同签订日期
     */
    private LocalDateTime signTime;

    /**
     * 合同开始执行日期
     */
    private LocalDateTime startTime;

    /**
     * 合同结束日期
     */
    private LocalDateTime endTime;

    /**
     * 合同总金额
     */
    private BigDecimal totalAmout;

    /**
     * 合同最后一次更新的时间
     */
    private LocalDateTime lastUpdate;

    /**
     * 当前版本号,默认为1
     */
    private Integer version;

    /**
     * 合同当前状态，新建为0，审批通过为1，执行中为2，结束为3，用于跟踪合同流程
     */
    private int status;

    @TableLogic
    private Integer isDelete;
}
