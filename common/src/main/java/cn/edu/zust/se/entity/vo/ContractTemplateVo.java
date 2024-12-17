package cn.edu.zust.se.entity.vo;

import java.time.LocalDateTime;
import lombok.Data;

/**
 * <p>
 *
 * </p>
 *
 * @author author
 * @since 2024-12-17
 */
@Data
public class ContractTemplateVo{
    private Integer id;
    private String name;
    private String content;
    private String description;
    private LocalDateTime createTime;
    private Integer status;
    private Integer userId;
}
