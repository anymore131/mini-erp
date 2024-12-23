package cn.edu.zust.se.service.impl;

import cn.edu.zust.se.entity.po.ContractProgress;
import cn.edu.zust.se.mapper.ContractProgressMapper;
import cn.edu.zust.se.service.IContractProgressService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author author
 * @since 2024-12-21
 */
@Service
@RequiredArgsConstructor
public class ContractProgressServiceImpl extends ServiceImpl<ContractProgressMapper, ContractProgress> implements IContractProgressService {
    private final ContractProgressMapper contractProgressMapper;

    @Override
    public List<ContractProgress> getAllContractProgresses() {
        return contractProgressMapper.selectAll();
    }

    @Override
    public ContractProgress getContractProgressById(Integer id) {
        return contractProgressMapper.selectById(id);
    }

    @Override
    public ContractProgress createContractProgress(ContractProgress contractProgress) {
        contractProgressMapper.insert(contractProgress);
        return contractProgress;
    }

    @Override
    public ContractProgress updateContractProgress(ContractProgress contractProgress) {
        contractProgressMapper.updateById(contractProgress);
        return contractProgress;
    }

    @Override
    public void deleteContractProgress(Integer id) {
        contractProgressMapper.deleteById(id);
    }
}
