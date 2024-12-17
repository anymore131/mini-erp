package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.po.ContractTemplate;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Optional;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author author
 * @since 2024-12-09
 */
public interface IContractTemplateService extends IService<ContractTemplate> {
    //创建合同模版
    ContractTemplate createTemplate(ContractTemplate template);
    //根据id获取模版信息
    ContractTemplate getTemplateById(Integer id);
    //根据用户id获取用户创建模版信息
    List<ContractTemplate> getTemplateByUserId(Integer userId);
    //更新合同模版
    ContractTemplate updateTemplate(Integer id, ContractTemplate updatedTemplate);
    //获取合同模版列表
    Page<ContractTemplate> getTemplates(String category, String keyword, Page page);
    //设置创建者
    void setCreator(Integer userId);
}
