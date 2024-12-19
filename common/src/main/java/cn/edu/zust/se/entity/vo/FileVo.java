package cn.edu.zust.se.entity.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class FileVo {
    private Integer id;
    private String fileName;
    private String uuidFileName;
    private String contentType;
    private LocalDateTime createTime;
    private String url;
}