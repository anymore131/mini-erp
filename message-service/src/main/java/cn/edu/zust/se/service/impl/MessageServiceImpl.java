package cn.edu.zust.se.service.impl;

import cn.edu.zust.se.entity.po.Message;
import cn.edu.zust.se.mapper.MessageMapper;
import cn.edu.zust.se.service.IMessageService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author author
 * @since 2024-12-20
 */
@Service
public class MessageServiceImpl extends ServiceImpl<MessageMapper, Message> implements IMessageService {

}
