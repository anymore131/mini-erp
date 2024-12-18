package cn.edu.zust.se.entity.query;

import cn.edu.zust.se.entity.po.User;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.Data;

@Data
public class PageQuery {
    private Integer pageNum = 1;
    private Integer pageSize = 10;
    private String sortBy = "create_time";
    // 是否升序
    private boolean asc = true;

    public <T> Page<T> toMpPage(OrderItem ... items){
        Page<T> page = new Page<>(pageNum, pageSize);
        if (items != null){
            page.addOrder(items);
        }
        return page;
    }

    public <T> Page<T> toMpPage(String sortBy, boolean isAsc){
        Page<T> page = new Page<>(pageNum, pageSize);
        if (StrUtil.isNotBlank(sortBy)) {
            page.addOrder(new OrderItem().setAsc(asc).setColumn(sortBy));
        }
        return page;
    }

    public <T> Page<T> toMpPageSortByCreateTime(boolean isAsc){
        return toMpPage(new OrderItem().setAsc(asc).setColumn("create_time"));
    }

    public <T> Page<T> toMpPageSortByUpdateTime(boolean isAsc){
        return toMpPage(new OrderItem().setAsc(asc).setColumn("update_time"));
    }
}