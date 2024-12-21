package cn.edu.zust.se.service;

import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.OrderFile;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 * 订单文件表 服务类
 * </p>
 *
 * @author anymore131
 * @since 2024-12-21
 */
public interface IOrderFileService extends IService<OrderFile> {
    public SaResult addOrderFile(Integer orderId, String remark, MultipartFile multipartFile);
    public SaResult getOrderFile(Integer orderId);
    public boolean removeOrderFile(Integer id);
}
