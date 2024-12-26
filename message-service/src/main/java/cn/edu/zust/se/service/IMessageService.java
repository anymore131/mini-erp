package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Message;
import cn.edu.zust.se.entity.query.MessageQuery;
import cn.edu.zust.se.entity.vo.MessageVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Collection;
import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author author
 * @since 2024-12-20
 */
public interface IMessageService extends IService<Message> {
    /**
     * 查询消息
     */
    MessageVo selectById(Integer id);

    /**
     * 查询消息列表
     */
    PageDto<MessageVo> pageMessage(MessageQuery messageQuery);

    /**
     * 查询消息列表
     */
    List<MessageVo> queryList(Message message);

    /**
     * 新增消息
     */
    void insertMessage(Message message);

    /**
     * 修改消息
     */
    MessageVo updateMessage(Message message);

    /**
     * 校验并批量删除消息信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 标记消息为已读
     * @param id 消息ID
     * @return 更新后的消息
     */
    MessageVo markAsRead(Integer id);
}
