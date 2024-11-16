package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @author anymore131
 * @since 2024-11-16
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("customers")
public class Customers implements Serializable {
    /**
     * 客户ID，唯一标识每个客户
     */
    @TableId(value = "id")
    private Integer id;

    /**
     * 客户名称，客户的公司或个人名称
     */
    @TableField("name")
    private String name;

    /**
     * 联系人，客户的联系人姓名
     */
    @TableField("contact_person")
    private String contactPerson;

    /**
     * 联系电话，客户的联系电话
     */
    @TableField("phone")
    private String phone;

    /**
     * 邮箱，客户的电子邮箱
     */
    @TableField("email")
    private String email;

    /**
     * 地址，客户的详细地址
     */
    @TableField("address")
    private String address;

    /**
     * 客户分类，客户的分类标签，如VIP、普通等
     */
    @TableField("category")
    private String category;

    /**
     * 创建时间，记录客户信息创建的时间
     */
    @TableField("created_time")
    private LocalDateTime createdTime;

    /**
     * 更新时间，记录客户信息最后更新的时间
     */
    @TableField("updated_time")
    private LocalDateTime updatedTime;
}
