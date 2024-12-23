package cn.edu.zust.se.controller;


import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.Message;
import cn.edu.zust.se.service.IMessageService;
import com.alibaba.nacos.api.model.v2.Result;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Arrays;

import static com.mysql.cj.conf.PropertyKey.logger;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author author
 * @since 2024-12-20
 */
@RestController
@RequestMapping("/message")
@AllArgsConstructor
public class MessageController {
    private final IMessageService messageService;
    private static final org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(MessageController.class);
    /**
     * 分页列表查询
     */
    @GetMapping(value = "/list")
    public Result<?> queryPageList(@Validated Message message,
                                   @RequestParam(name = "pageNo", defaultValue = "1") Integer pageNo,
                                   @RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize,
                                   HttpServletRequest req) {
        // 参数验证
        if (pageNo <= 0 || pageSize <= 0 || pageSize > 100) {
            return Result.failure("Invalid page parameters");
        }

        try {
            // 初始化查询条件
            QueryWrapper<Message> queryWrapper =new QueryWrapper<>(message);

            // 分页查询
            Page<Message> page = new Page<>(pageNo, pageSize);
            IPage<Message> pageList = messageService.page(page, queryWrapper);

            return Result.success(pageList);
        } catch (Exception e) {
            // 异常处理
            logger.error("Error occurred while querying page list", e);
            return Result.failure("Internal server error");
        }
    }


    /**
     * 添加
     */
    @PostMapping(value = "/add")
    public SaResult add(@RequestBody Message message) {
        messageService.save(message);
        return SaResult.data(message);
    }

    /**
     * 编辑
     */
    @PutMapping(value = "/edit")
    public SaResult edit(@RequestBody Message sysMessage) {
        messageService.updateById(sysMessage);
        return SaResult.data(sysMessage).ok("修改成功!");

    }

    /**
     * 通过id删除
     */
    @DeleteMapping(value = "/delete")
    public SaResult delete(@RequestParam(name = "id", required = false) String id) {
        messageService.removeById(id);
        return SaResult.ok("删除成功!");
    }

    /**
     * 批量删除
     */
    @DeleteMapping(value = "/deleteBatch")
    public SaResult deleteBatch(@RequestParam(name = "ids", required = false) String ids) {
        this.messageService.removeByIds(Arrays.asList(ids.split(",")));
        return SaResult.ok("批量删除成功！");
    }

    /**
     * 通过id查询
     */
    @GetMapping(value = "/queryById")
    public SaResult queryById(@RequestParam(name = "id", required = true) String id) {
        Message message = messageService.getById(id);
        return SaResult.data(message);
    }

}
