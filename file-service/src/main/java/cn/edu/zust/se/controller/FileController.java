package cn.edu.zust.se.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.File;
import cn.edu.zust.se.entity.query.FileQuery;
import cn.edu.zust.se.entity.vo.FileVo;
import cn.edu.zust.se.exception.ForbiddenException;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.service.IFileService;
import cn.edu.zust.se.util.MinioUtil;
import cn.hutool.core.bean.BeanUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@RequestMapping
@RestController
public class FileController {
    private final IFileService fileService;

    public FileController(IFileService fileService) {
        this.fileService = fileService;
    }

    @PostMapping(value = "/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public SaResult upload(@RequestPart("file") MultipartFile... files) {
        if (files == null){
            throw new InvalidInputException("文件为空");
        }
        List<Integer> fileIds = new ArrayList<>();
        int sum = 0;
        for (MultipartFile file : files){
            if (file.isEmpty()) {
                sum++;
                continue;
            }
            FileVo fileVo = fileService.upload(file);
            if (fileVo == null){
                sum++;
                continue;
            }
            fileIds.add(fileVo.getId());
        }
        return SaResult
                .data(fileIds)
                .setMsg("一共上传文件" + files.length + "个,成功上传文件" + (files.length - sum) + "个");
    }

    @RequestMapping("/pageAll")
    public SaResult pageAll(@RequestBody FileQuery fileQuery) {
        if (fileQuery == null){
            throw new InvalidInputException("查询参数为空");
        }
        if (!StpUtil.hasRole("admin")) {
            throw new ForbiddenException("无权查看所有文件！");
        }
        return SaResult.data(fileService.pageAll(fileQuery));
    }

    @RequestMapping("/preview/{uuidFileName}")
    public SaResult preview(@PathVariable String uuidFileName) {
        if (StringUtils.isBlank(uuidFileName)){
            throw new InvalidInputException("文件名为空");
        }
        return SaResult.data(fileService.preview(uuidFileName));
    }

    @RequestMapping("/remove/{id}")
    public SaResult remove(@PathVariable Integer id) {
        if (id == null){
            throw new InvalidInputException("id为空");
        }
        return fileService.remove(id)? SaResult.ok("删除成功") : SaResult.error("删除失败");
    }

    @RequestMapping("/get/{id}")
    public FileVo getFileById(@PathVariable Integer id) {
        if (id == null){
            throw new InvalidInputException("id为空");
        }
        File file = fileService.getById(id);
        if (file == null){
            throw new InvalidInputException("文件不存在");
        }
        FileVo fileVo = BeanUtil.copyProperties(file, FileVo.class);
        fileVo.setUrl(fileService.preview(file.getUuidFileName()));
        return fileVo;
    }
}
