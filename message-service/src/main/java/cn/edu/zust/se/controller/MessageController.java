package cn.edu.zust.se.controller;

import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Message;
import cn.edu.zust.se.entity.vo.MessageVo;
import cn.edu.zust.se.entity.query.MessageQuery;
import cn.edu.zust.se.service.IMessageService;
import lombok.AllArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

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
    private static final Logger logger = LoggerFactory.getLogger(MessageController.class);
    /**
     * 分页列表查询
     */
    @GetMapping(value = "/list")
    public SaResult queryPageList(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(defaultValue = "send_time") String sortBy,
            @RequestParam(defaultValue = "false") Boolean asc,
            @RequestParam(required = false) Integer userId
    ) {
        logger.info("接收到消息列表查询请求，参数: pageNum={}, pageSize={}, sortBy={}, asc={}, userId={}", 
                pageNum, pageSize, sortBy, asc, userId);
        try {
            MessageQuery messageQuery = new MessageQuery();
            messageQuery.setPageNum(pageNum);
            messageQuery.setPageSize(pageSize);
            messageQuery.setSortBy(sortBy);
            messageQuery.setAsc(asc);
            if (userId != null) messageQuery.setUserId(userId);

            PageDto<MessageVo> result = messageService.pageMessage(messageQuery);
            logger.info("消息列表查询成功，返回数据: result={}, list={}, total={}", 
                result, result.getList(), result.getTotal());
            
            SaResult response = SaResult.ok()
                .setData(result)
                .setMsg("查询成功！");
            logger.info("最终响应数据: {}", response);
            return response;
        } catch (Exception e) {
            logger.error("消息列表查询失败", e);
            return SaResult.error("查询失败：" + e.getMessage());
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

    /**
     * 标记消息为已读
     */
    @PutMapping("/markRead/{id}")
    public SaResult markRead(@PathVariable Integer id) {
        logger.info("接收到标记消息已读请求，消息ID: {}", id);
        try {
            MessageVo messageVo = messageService.markAsRead(id);
            if (messageVo != null) {
                logger.info("消息已读标记成功，消息ID: {}", id);
                return SaResult.data(messageVo).setMsg("标记已读成功！");
            } else {
                logger.warn("消息不存在，消息ID: {}", id);
                return SaResult.error("消息不存在");
            }
        } catch (Exception e) {
            logger.error("标记消息已读失败，消息ID: " + id, e);
            return SaResult.error("标记已读失败：" + e.getMessage());
        }
    }

}
