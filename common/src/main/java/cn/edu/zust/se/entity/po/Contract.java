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

    private String clientId;

    /**
     * 职工id,对应职工信息

     */
    private String userId;

    /**
     * 合同名称
     */
    private String name;

    /**
     * 合同编号
     */
    private String number;

    /**
     * 合同类型，如 “销售合同”“采购合同”“服务合同” 等，可用于分类统计和业务逻辑区分
     */
    private String type;

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
     * 合同当前状态，如 0“新建” 1“审批中”2 “执行中”3“修改中” 4“已终止” 5“已违约”等，用于跟踪合同流程
     */
    private String status;

    @TableLogic
    private Integer isDelete;
}
