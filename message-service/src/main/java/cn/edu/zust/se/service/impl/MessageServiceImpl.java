package cn.edu.zust.se.service.impl;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.Contract;
import cn.edu.zust.se.entity.po.Message;
import cn.edu.zust.se.entity.query.MessageQuery;
import cn.edu.zust.se.entity.vo.ContractVo;
import cn.edu.zust.se.entity.vo.MessageVo;
import cn.edu.zust.se.enums.ContractStatusEnum;
import cn.edu.zust.se.mapper.MessageMapper;
import cn.edu.zust.se.service.IMessageService;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author author
 * @since 2024-12-20
 */
@RequiredArgsConstructor
@Service
public class MessageServiceImpl extends ServiceImpl<MessageMapper, Message> implements IMessageService {
    private final MessageMapper messageMapper;

    @Override
    public MessageVo selectById(Integer id) {
        Message message = getById(id);
        MessageVo messageVo = BeanUtil.copyProperties(message,MessageVo.class);
        return messageVo;
    }

    @Override
    public PageDto<MessageVo> pageMessage(MessageQuery messageQuery) {
        Page<Message> page = messageQuery.toMpPage(messageQuery.getSortBy(), messageQuery.isAsc());
        if (messageQuery.getId() != null){
            lambdaQuery()
                    .eq(messageQuery.getUserId() != null,Message::getUserId, messageQuery.getUserId())
                    .like(messageQuery.getContent() != null,Message::getContent, messageQuery.getContent())
                    .ge(messageQuery.getContractId() != null,Message::getContractId, messageQuery.getContractId())
                    .page(page);
        }else{
            lambdaQuery()
                    .eq(messageQuery.getUserId() != null,Message::getUserId, messageQuery.getUserId())
                    .like(messageQuery.getContent() != null,Message::getContent, messageQuery.getContent())
                    .ge(messageQuery.getContractId() != null,Message::getContractId, messageQuery.getContractId())
                    .page(page);
        }
        PageDto<MessageVo> voPageDto = new PageDto<>();
        voPageDto.setTotal(page.getTotal());
        voPageDto.setPages(page.getPages());
        List<Message> records = page.getRecords();
        if (CollUtil.isEmpty(records)){
            voPageDto.setList(Collections.emptyList());
            return voPageDto;
        }
        List<MessageVo> vos = new ArrayList<>();
        for (Message record : records){
            MessageVo messageVo = BeanUtil.copyProperties(record, MessageVo.class);
            vos.add(messageVo);
        }
        voPageDto.setList(vos);
        return voPageDto;
    }

    @Override
    public List<MessageVo> queryList(Message message) {
        List<Message> messages = list(BeanUtil.toBean(message, LambdaQueryWrapper.class));
        List<MessageVo> messageVos = BeanUtil.copyToList(messages, MessageVo.class);
        return messageVos;
    }

    @Override
    public void insertMessage(Message message) {
        save(message);
    }

    @Override
    public MessageVo updateMessage(Message message) {
        if (updateById(message)){
            return selectById(message.getId());
        }
        messageMapper.updateById(message);
        MessageVo messageVo = selectById(message.getId());
        return messageVo;
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        return null;
    }
}
