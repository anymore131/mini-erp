package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.ContractFile;
import cn.edu.zust.se.entity.vo.ContractFileVo;
import cn.edu.zust.se.entity.vo.ContractVo;
import cn.edu.zust.se.exception.ForbiddenException;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.FileFeignServiceI;
import cn.edu.zust.se.mapper.ContractFileMapper;
import cn.edu.zust.se.service.IContractFileService;
import cn.edu.zust.se.service.IContractLogService;
import cn.edu.zust.se.service.IContractService;
import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author author
 * @since 2024-12-25
 */
@Service
@RequiredArgsConstructor
@Transactional
public class ContractFileServiceImpl extends ServiceImpl<ContractFileMapper, ContractFile> implements IContractFileService {
    private final FileFeignServiceI fileFeignService;
    private final IContractService contractService;
    private final IContractLogService contractLogService;

    @Override
    public SaResult addContractFile(Integer contractId, String remark, MultipartFile multipartFile) {
        if (contractId == null){
            throw new InvalidInputException("合同id为空");
        }
        if (multipartFile == null){
            throw new InvalidInputException("文件为空");
        }

        // 鉴权
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        ContractVo contractVo = contractService.getTContractById(contractId);
        if (contractVo == null){
            throw new InvalidInputException("订单不存在");
        }
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(contractVo.getUserId())){
            throw new ForbiddenException("无权上传该订单文件");
        }

        SaResult upload = fileFeignService.upload(multipartFile);
        if (upload.getCode() == SaResult.CODE_ERROR){
            return SaResult.error(upload.getMsg());
        }
        ContractFile contractFile = new ContractFile();
        contractFile.setContractId(contractId);
        String data = upload.getData().toString();
        data = data.replaceAll("[\\[\\]]", ""); // 去除方括号
        contractFile.setContractId(Integer.parseInt(data));
        contractFile.setCreateTime(LocalDateTime.now());
        contractFile.setRemark(remark);
        contractFile.setIsDelete(0);
        save(contractFile);
        contractLogService.addLog(contractId, StpUtil.getLoginIdAsInt(), "ADD_FILE",
                String.format("上传文件：%s", multipartFile.getOriginalFilename()));
        return upload;
    }

    @Override
    public SaResult getContractFile(Integer contractId) {
        if (contractId == null){
            throw new InvalidInputException("订单id为空");
        }

        // 鉴权
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        ContractVo contractVo = contractService.getTContractById(contractId);
        if (contractVo == null){
            throw new InvalidInputException("订单不存在");
        }
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(contractVo.getUserId())){
            throw new ForbiddenException("无权查看该订单文件");
        }

        List<ContractFile> list = lambdaQuery().eq(ContractFile::getContractId, contractId).list();
        List<ContractFileVo> contractFileVos = new ArrayList<>();
        for (ContractFile contractFile : list){
            ContractFileVo contractFileVo = BeanUtil.copyProperties(contractFile, ContractFileVo.class);
            contractFileVo.setFileVo(fileFeignService.getFileById(contractFile.getFileId()));
            contractFileVos.add(contractFileVo);
        }
        if (!contractFileVos.isEmpty()){
            return SaResult.data(contractFileVos);
        }
        return SaResult.ok("未有文件");
    }

    @Override
    public boolean removeContractFile(Integer id) {
        if (id == null){
            throw new InvalidInputException("文件id为空");
        }

        // 鉴权
        Integer currentUserId = StpUtil.getLoginIdAsInt();

        ContractFile contractFile = getById(id);
        if (contractFile == null){
            throw new InvalidInputException("文件不存在");
        }
        ContractVo contractVo = contractService.getTContractById(contractFile.getContractId());
        if (contractVo == null){
            throw new InvalidInputException("订单不存在");
        }
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(contractVo.getUserId())){
            throw new ForbiddenException("无权删除该订单文件");
        }

        SaResult remove = fileFeignService.remove(contractFile.getFileId());
        if (remove.getCode() == SaResult.CODE_ERROR){
            throw new InvalidInputException("文件不存在");
        }
        return removeById(id);
    }
}
