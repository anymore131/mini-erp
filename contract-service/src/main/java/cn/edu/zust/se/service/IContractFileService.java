package cn.edu.zust.se.service;

import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.ContractFile;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author author
 * @since 2024-12-25
 */
public interface IContractFileService extends IService<ContractFile> {
    SaResult addContractFile(Integer contractId, String remark, MultipartFile multipartFile);
    SaResult getContractFile(Integer contractId);
    boolean removeContractFile(Integer id);
}
