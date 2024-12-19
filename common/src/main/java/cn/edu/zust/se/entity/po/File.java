package cn.edu.zust.se.entity.po;

import com.baomidou.mybatisplus.annotation.*;

import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @author anymore131
 * @since 2024-12-19
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("file")
public class File implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.NONE)
    private Integer id;

    @TableField("file_name")
    private String fileName;

    @TableField("uuid_file_name")
    private String uuidFileName;

    @TableField("content_type")
    private String contentType;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableLogic
    private Integer isDelete;
}
