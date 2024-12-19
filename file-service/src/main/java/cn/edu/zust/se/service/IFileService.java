package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.File;
import cn.edu.zust.se.entity.query.FileQuery;
import cn.edu.zust.se.entity.vo.FileVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author anymore131
 * @since 2024-12-19
 */
public interface IFileService extends IService<File> {
    public FileVo upload(MultipartFile file);
    public PageDto<FileVo> pageAll(FileQuery fileQuery);
    public String preview(String uuidFileName);
    public boolean remove(Integer id);
}
