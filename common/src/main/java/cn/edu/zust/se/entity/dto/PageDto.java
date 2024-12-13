package cn.edu.zust.se.entity.dto;

import cn.edu.zust.se.entity.po.User;
import cn.edu.zust.se.entity.vo.UserVo;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.Data;

import java.util.Collections;
import java.util.List;

@Data
public class PageDto<T> {
    // 总条数
    private Long total;
    // 总页数
    private Long pages;
    // 数据集合
    private List<T> list;

    public static <PO, VO> PageDto<VO> of(Page<PO> page, Class<VO> voClass){
        PageDto<VO> voPageDto = new PageDto<>();
        voPageDto.setTotal(page.getTotal());
        voPageDto.setPages(page.getPages());
        List<PO> records = page.getRecords();
        if (CollUtil.isEmpty(records)){
            voPageDto.setList(Collections.emptyList());
            return voPageDto;
        }
        List<VO> vos = BeanUtil.copyToList(records, voClass);
        voPageDto.setList(vos);
        return voPageDto;
    }
}