package cn.edu.zust.se.service.impl;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Client;
import cn.edu.zust.se.entity.po.File;
import cn.edu.zust.se.entity.query.FileQuery;
import cn.edu.zust.se.entity.vo.FileVo;
import cn.edu.zust.se.enums.ClientStatusEnum;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.mapper.FileMapper;
import cn.edu.zust.se.service.IFileService;
import cn.edu.zust.se.util.MinioUtil;
import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;

/**
 * @author anymore131
 * @since 2024-12-19
 */
@Service
public class FileServiceImpl extends ServiceImpl<FileMapper, File> implements IFileService {
    @Autowired
    private MinioUtil minioUtil;

    @Override
    public FileVo upload(MultipartFile file) {
        if (file == null){
            throw new InvalidInputException("文件为空");
        }
        String originalFilename = file.getOriginalFilename();
        if (StringUtils.isBlank(originalFilename)) {
            throw new RuntimeException("文件名为空");
        }
        String uuidFileName = minioUtil.upload(file);
        File file1 = new File();
        file1.setFileName(originalFilename);
        file1.setUuidFileName(uuidFileName);
        file1.setContentType(file.getContentType());
        file1.setCreateTime(LocalDateTime.now());
        file1.setIsDelete(0);
        save(file1);
        FileVo fileVo = BeanUtil.copyProperties(file1, FileVo.class);
        fileVo.setUrl(minioUtil.preview(uuidFileName, file1.getFileName()));
        return fileVo;
    }

    @Override
    public PageDto<FileVo> pageAll(FileQuery fileQuery) {
        if (fileQuery == null){
            throw new InvalidInputException("查询参数为空");
        }
        Page<File> page = fileQuery.toMpPage(fileQuery.getSortBy(),fileQuery.isAsc());
        lambdaQuery()
                .like(fileQuery.getFileName() != null, File::getFileName, fileQuery.getFileName())
                .eq(fileQuery.getContentType() != null,File::getContentType, fileQuery.getContentType())
                .page(page);
        PageDto<FileVo> fileVos = PageDto.of(page, FileVo.class);
        for (FileVo fileVo : fileVos.getList()){
            fileVo.setUrl(minioUtil.preview(fileVo.getUuidFileName(), fileVo.getFileName()));
        }
        return fileVos;
    }

    @Override
    public String preview(String uuidFileName) {
        if (StringUtils.isBlank(uuidFileName)) {
            throw new InvalidInputException("文件名为空");
        }
        File file = getByUuidFileName(uuidFileName);
        if (file == null) {
            throw new InvalidInputException("文件不存在");
        }
        return minioUtil.preview(uuidFileName, file.getFileName());
    }

    private File getByUuidFileName(String uuidFileName) {
        return getOne(new QueryWrapper<File>()
            .eq("uuid_file_name", uuidFileName));
    }

    @Override
    public boolean remove(Integer id) {
        if (id == null){
            throw new InvalidInputException("id为空");
        }
        return removeById(id);
    }
}
