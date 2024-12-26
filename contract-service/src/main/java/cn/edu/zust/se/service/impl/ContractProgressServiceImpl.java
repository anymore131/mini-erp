package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.ContractProgress;
import cn.edu.zust.se.entity.query.ContractProgressQuery;
import cn.edu.zust.se.entity.vo.ContractProgressVo;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.UserFeignServiceI;
import cn.edu.zust.se.mapper.ContractProgressMapper;
import cn.edu.zust.se.service.IContractProgressService;
import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class ContractProgressServiceImpl extends ServiceImpl<ContractProgressMapper, ContractProgress> implements IContractProgressService {
    
    private final UserFeignServiceI userFeignService;

    @Override
    public PageDto<ContractProgressVo> pageContractProgresses(ContractProgressQuery query) {
        if (query == null) {
            throw new InvalidInputException("查询条件不能为空");
        }

        // 权限检查
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(query.getUserId())) {
            throw new InvalidInputException("无权查询合同进度");
        }

        // 构建分页查询，使用 ContractProgressVo 类型
        IPage<ContractProgressVo> page = new Page<>(query.getPageNum(), query.getPageSize());
        
        // 执行查询
        page = baseMapper.selectPageVo(page, query);

        // 构建返回结果
        PageDto<ContractProgressVo> result = new PageDto<>();
        result.setTotal(page.getTotal());
        result.setPages(page.getPages());
        result.setList(page.getRecords());
        
        return result;
    }

    @Override
    public ContractProgressVo getContractProgressVoById(Integer id) {
        if (id == null) {
            throw new InvalidInputException("进度ID不能为空");
        }

        ContractProgress progress = getById(id);
        if (progress == null || progress.getIsDelete() == 1) {
            throw new InvalidInputException("合同进度不存在");
        }

        ContractProgressVo vo = BeanUtil.copyProperties(progress, ContractProgressVo.class);
        vo.setUserName(userFeignService.getUserNameById(progress.getUserId()));
        return vo;
    }

    @Override
    public Integer addContractProgress(ContractProgress contractProgress) {
        // 参数校验
        if (contractProgress == null) {
            throw new InvalidInputException("合同进度不能为空");
        }
        if (contractProgress.getContractId() == null) {
            throw new InvalidInputException("合同ID不能为空");
        }
        if (contractProgress.getType() == null) {
            throw new InvalidInputException("进度类型不能为空");
        }
        if (contractProgress.getDetail() == null) {
            throw new InvalidInputException("进度详情不能为空");
        }

        // 设置用户ID
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        contractProgress.setUserId(currentUserId);

        // 获取当前版本号
        Integer currentVersion = 1;
        ContractProgress latestProgress = baseMapper.selectLatestByContractId(contractProgress.getContractId());
        if (latestProgress != null) {
            currentVersion = latestProgress.getVersion() + 1;
        }

        // 设置其他字段
        contractProgress.setVersion(currentVersion);
        contractProgress.setProgressTime(LocalDateTime.now());
        contractProgress.setIsDelete(0);

        // 保存
        save(contractProgress);
        return contractProgress.getId();
    }

    @Override
    public boolean updateContractProgress(ContractProgress contractProgress) {
        // 参数校验
        if (contractProgress == null || contractProgress.getId() == null) {
            throw new InvalidInputException("合同进度ID不能为空");
        }

        // 检查记录是否存在
        ContractProgress existing = getById(contractProgress.getId());
        if (existing == null || existing.getIsDelete() == 1) {
            throw new InvalidInputException("合同进度不存在");
        }

        // 权限检查
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(existing.getUserId())) {
            throw new InvalidInputException("无权更新合同进度");
        }

        // 更新版本和时间
        contractProgress.setVersion(existing.getVersion() + 1);
        contractProgress.setProgressTime(LocalDateTime.now());

        return updateById(contractProgress);
    }

    @Override
    public boolean deleteContractProgress(Integer id) {
        if (id == null) {
            throw new InvalidInputException("进度ID不能为空");
        }

        // 检查记录是否存在
        ContractProgress existing = getById(id);
        if (existing == null || existing.getIsDelete() == 1) {
            throw new InvalidInputException("合同进度不存在");
        }

        // 权限检查
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(existing.getUserId())) {
            throw new InvalidInputException("无权删除合同进度");
        }

        // 软删除
        existing.setIsDelete(1);
        return updateById(existing);
    }

    @Override
    public ContractProgressVo getLatestProgressByContractId(Integer contractId) {
        if (contractId == null) {
            throw new InvalidInputException("合同ID不能为空");
        }

        ContractProgress progress = baseMapper.selectLatestByContractId(contractId);
        if (progress == null) {
            return null;
        }

        ContractProgressVo vo = BeanUtil.copyProperties(progress, ContractProgressVo.class);
        vo.setUserName(userFeignService.getUserNameById(progress.getUserId()));
        return vo;
    }
}
