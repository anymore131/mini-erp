package cn.edu.zust.se.feign;

import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.query.FileQuery;
import cn.edu.zust.se.entity.vo.FileVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@FeignClient("file-service")
public interface FileFeignServiceI {
    @PutMapping("/upload")
    public SaResult upload(@RequestParam("file") MultipartFile... files);

    @GetMapping("/pageAll")
    public SaResult pageAll(@RequestBody FileQuery fileQuery);

    @GetMapping("/preview/{uuidFileName}")
    public SaResult preview(@PathVariable("uuidFileName") String uuidFileName);

    @PostMapping("/remove/{id}")
    public SaResult remove(@PathVariable("id") Integer id);

    @PostMapping("/get/{id}")
    public FileVo getFileById(@PathVariable("id") Integer id);
}
