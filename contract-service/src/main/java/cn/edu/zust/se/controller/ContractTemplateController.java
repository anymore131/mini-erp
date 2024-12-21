package cn.edu.zust.se.controller;

import cn.edu.zust.se.entity.po.ContractTemplate;
import cn.edu.zust.se.entity.po.Message;
import cn.edu.zust.se.entity.po.User;
import cn.edu.zust.se.service.IContractTemplateService;
import com.alibaba.nacos.api.model.v2.Result;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author author
 * @since 2024-12-09
 */
@RestController
@AllArgsConstructor
@RequestMapping("/contract-template")
public class ContractTemplateController {
    private IContractTemplateService contractTemplateService;
    private static final Logger logger = LoggerFactory.getLogger(ContractTemplateController.class);

    // 创建新模板
    @PostMapping
    public ResponseEntity<ContractTemplate> createTemplate(@RequestBody ContractTemplate template,
                                                           @AuthenticationPrincipal User currentUser) {
        contractTemplateService.setCreator(currentUser.getId());
        ContractTemplate createdTemplate = contractTemplateService.createTemplate(template);
        return new ResponseEntity<>(createdTemplate, HttpStatus.CREATED);
    }

    // 编辑模板
    @PutMapping("/{id}")
    public ResponseEntity<ContractTemplate> updateTemplate(@PathVariable Integer id,
                                                           @RequestBody ContractTemplate updatedTemplate,
                                                           @AuthenticationPrincipal User currentUser) {
        try {
            if (currentUser == null) {
                logger.warn("User is not authenticated");
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            ContractTemplate template = contractTemplateService.getTemplateById(id);
            if (template != null && template.getUserId().equals(currentUser.getId())) {
                ContractTemplate updated = contractTemplateService.updateTemplate(id, updatedTemplate);
                return new ResponseEntity<>(updated, HttpStatus.OK);
            } else {
                logger.info("Template with id {} not found or user does not have permission to update", id);
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            logger.error("Error updating template: ", e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 获取模板列表
    /**
     * 分页列表查询
     */
    @GetMapping
    public ResponseEntity<Page<ContractTemplate>> getTemplates(@RequestParam(required = false) String category,
                                                               @RequestParam(required = false) String keyword,
                                                               @RequestParam(defaultValue = "0") int page,
                                                               @RequestParam(defaultValue = "10") int size) {
        Page<ContractTemplate> pageable = new Page<>(page, size);
        Page<ContractTemplate> templates = contractTemplateService.getTemplates(category, keyword, pageable);
        return new ResponseEntity<>(templates, HttpStatus.OK);
    }

    // 获取单个模板详情
    @GetMapping("/{id}")
    public ResponseEntity<ContractTemplate> getTemplateById(@PathVariable Integer id) {
        try {
            ContractTemplate template = contractTemplateService.getTemplateById(id);
            if (template != null) {
                return new ResponseEntity<>(template, HttpStatus.OK);
            } else {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            // 记录异常日志
            logger.error("Error retrieving template with ID: {}", id, e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    // 删除模板
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTemplate(@PathVariable Integer id,
                                               @AuthenticationPrincipal User currentUser) {
        try {
            if (currentUser == null) {
                logger.warn("User is not authenticated");
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            ContractTemplate template = contractTemplateService.getTemplateById(id);
            if (template != null && template.getUserId().equals(currentUser.getId())) {
                contractTemplateService.deleteTemplate(id);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } else {
                logger.info("Template with id {} not found or user does not have permission to delete", id);
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            logger.error("Error deleting template: ", e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    // 启用/禁用模板
    @PatchMapping("/{id}/status")
    public ResponseEntity<ContractTemplate> toggleTemplateStatus(@PathVariable Integer id,
                                                                 @RequestParam boolean enabled,
                                                                 @AuthenticationPrincipal User currentUser) {
        try {
            if (currentUser == null) {
                logger.warn("User is not authenticated");
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            ContractTemplate template = contractTemplateService.getTemplateById(id);
            if (template != null && template.getUserId().equals(currentUser.getId())) {
                contractTemplateService.changeTemplateStatus(id,enabled);
                ContractTemplate updatedTemplate = contractTemplateService.updateTemplate(id, template);
                return new ResponseEntity<>(updatedTemplate, HttpStatus.OK);
            } else {
                logger.info("Template with id {} not found or user does not have permission to update status", id);
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            logger.error("Error toggling template status: ", e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


}
