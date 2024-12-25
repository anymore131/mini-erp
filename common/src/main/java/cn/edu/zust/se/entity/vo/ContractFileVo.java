package cn.edu.zust.se.entity.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ContractFileVo {
    private Integer id;
    private Integer contractId;
    private Integer fileId;
    private String remark;
    private FileVo fileVo;
    private LocalDateTime createTime;
    private Integer isDelete;
}
