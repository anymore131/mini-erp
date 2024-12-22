package cn.edu.zust.se.feign;

import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.query.FileQuery;
import cn.edu.zust.se.entity.vo.FileVo;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileFallbackFactory implements FallbackFactory<FileFeignServiceI> {
    @Override
    public FileFeignServiceI create(Throwable cause) {
        return new FileFallback();
    }
}

class FileFallback implements FileFeignServiceI {
    @Override
    public SaResult upload(MultipartFile... files) {
        return null;
    }

    @Override
    public SaResult pageAll(FileQuery fileQuery) {
        return null;
    }

    @Override
    public SaResult preview(String uuidFileName) {
        return null;
    }

    @Override
    public SaResult remove(Integer id) {
        return null;
    }

    @Override
    public FileVo getFileById(Integer id) {
        return null;
    }
}