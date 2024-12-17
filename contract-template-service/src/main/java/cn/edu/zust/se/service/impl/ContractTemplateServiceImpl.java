package cn.edu.zust.se.service.impl;

import cn.edu.zust.se.entity.po.ContractTemplate;
import cn.edu.zust.se.mapper.ContractTemplateMapper;
import cn.edu.zust.se.service.IContractTemplateService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author author
 * @since 2024-12-09
 */
@Service
@RequiredArgsConstructor
public class ContractTemplateServiceImpl extends ServiceImpl<ContractTemplateMapper, ContractTemplate> implements IContractTemplateService {
    private final ContractTemplateMapper contractTemplateMapper;
    private Integer creatorId;
    @Override
    public ContractTemplate createTemplate(ContractTemplate template) {
        template.setUserId(creatorId);
        template.setCreateTime(new Timestamp(System.currentTimeMillis()).toLocalDateTime());
        template.setStatus(0);
        contractTemplateMapper.insertContractTemplate(template.getName(), template.getContent(), template.getDescription(), template.getCreateTime(), template.getStatus(), template.getUserId());
        return template;
    }

    @Override
    public ContractTemplate getTemplateById(Integer id) {
        ContractTemplate template = contractTemplateMapper.selectById(id);
        return template;
    }

    @Override
    public List<ContractTemplate> getTemplateByUserId(Integer userId) {
        List<ContractTemplate> templates = contractTemplateMapper.selectContractTemplatesByUserId(userId);
        return templates;
    }

    @Override
    public ContractTemplate updateTemplate(Integer id, ContractTemplate updatedTemplate) {
        updatedTemplate.setId(id);
        updatedTemplate.setUserId(creatorId);
        contractTemplateMapper.updateById(updatedTemplate);
        return updatedTemplate;
    }

    @Override
    public Page<ContractTemplate> getTemplates(String category, String keyword, Page page) {
        QueryWrapper<ContractTemplate> queryWrapper = new QueryWrapper<>();
        if (category != null && !category.isEmpty()) {
            queryWrapper.eq("category", category);
        }
        if (keyword != null && !keyword.isEmpty()) {
            queryWrapper.like("content", keyword);
        }
        return page(page, queryWrapper);
    }

    @Override
    public void setCreator(Integer userId) {
        this.creatorId = userId;
    }
}
















