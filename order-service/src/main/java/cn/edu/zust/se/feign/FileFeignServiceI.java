package cn.edu.zust.se.feign;

import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.query.FileQuery;
import cn.edu.zust.se.entity.vo.FileVo;
import cn.edu.zust.se.feign.interceptor.FeignInterceptor;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@FeignClient(
        name = "file-service",
        configuration = FeignInterceptor.class,        // 请求拦截器 （关键代码）
        fallbackFactory = FileFallback.class    // 服务降级处理
)
public interface FileFeignServiceI {
    @PostMapping(value = "/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public SaResult upload(@RequestPart("file") MultipartFile... files);

    @GetMapping("/pageAll")
    public SaResult pageAll(@RequestBody FileQuery fileQuery);

    @GetMapping("/preview/{uuidFileName}")
    public SaResult preview(@PathVariable("uuidFileName") String uuidFileName);

    @PostMapping("/remove/{id}")
    public SaResult remove(@PathVariable("id") Integer id);

    @PostMapping("/get/{id}")
    public FileVo getFileById(@PathVariable("id") Integer id);
}
