package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.po.OrderFile;
import cn.edu.zust.se.entity.vo.FileVo;
import cn.edu.zust.se.entity.vo.OrderFileVo;
import cn.edu.zust.se.entity.vo.OrderVo;
import cn.edu.zust.se.exception.ForbiddenException;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.feign.FileFeignServiceI;
import cn.edu.zust.se.mapper.OrderFileMapper;
import cn.edu.zust.se.service.IOrderFileService;
import cn.edu.zust.se.service.IOrderService;
import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * @author anymore131
 * @since 2024-12-21
 */
@Service
public class OrderFileServiceImpl extends ServiceImpl<OrderFileMapper, OrderFile> implements IOrderFileService {
    @Autowired
    private FileFeignServiceI fileFeignService;
    @Autowired
    private IOrderService orderService;

    @Override
    public SaResult addOrderFile(Integer orderId, String remark, MultipartFile multipartFile) {
        if (orderId == null){
            throw new InvalidInputException("订单id为空");
        }
        if (multipartFile == null){
            throw new InvalidInputException("文件为空");
        }

        // 鉴权
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        OrderVo orderVoById = orderService.getOrderVoById(orderId);
        if (orderVoById == null){
            throw new InvalidInputException("订单不存在");
        }
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(orderVoById.getUserId())){
            throw new ForbiddenException("无权上传该订单文件");
        }

        SaResult upload = fileFeignService.upload(multipartFile);
        if (upload.getCode() == SaResult.CODE_ERROR){
            return SaResult.error(upload.getMsg());
        }
        OrderFile orderFile = new OrderFile();
        orderFile.setOrderId(orderId);
        orderFile.setFileId(Integer.parseInt(upload.getData().toString()));
        orderFile.setCreateTime(LocalDateTime.now());
        orderFile.setRemark(remark);
        orderFile.setIsDelete(0);
        save(orderFile);
        return upload;
    }

    @Override
    public SaResult getOrderFile(Integer orderId) {
        if (orderId == null){
            throw new InvalidInputException("订单id为空");
        }

        // 鉴权
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        OrderVo orderVoById = orderService.getOrderVoById(orderId);
        if (orderVoById == null){
            throw new InvalidInputException("订单不存在");
        }
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(orderVoById.getUserId())){
            throw new ForbiddenException("无权查看该订单文件");
        }

        List<OrderFile> list = lambdaQuery().eq(OrderFile::getOrderId, orderId).list();
        List<OrderFileVo> orderFileVos = new ArrayList<>();
        for (OrderFile orderFile : list){
            OrderFileVo orderFileVo = BeanUtil.copyProperties(orderFile, OrderFileVo.class);
            orderFileVo.setFileVo(fileFeignService.getFileById(orderFile.getFileId()));
            orderFileVos.add(orderFileVo);
        }
        if (!orderFileVos.isEmpty()){
            return SaResult.data(orderFileVos);
        }
        return SaResult.ok("未有文件");
    }

    @Override
    public boolean removeOrderFile(Integer id) {
        if (id == null){
            throw new InvalidInputException("文件id为空");
        }

        // 鉴权
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        OrderVo orderVoById = orderService.getOrderVoById(id);
        OrderFile orderFile = getById(id);
        if (orderVoById == null){
            throw new InvalidInputException("订单不存在");
        }
        if (orderFile == null){
            throw new InvalidInputException("文件不存在");
        }
        if (!StpUtil.hasRole("admin")&& !currentUserId.equals(orderVoById.getUserId())){
            throw new ForbiddenException("无权删除该订单文件");
        }

        SaResult remove = fileFeignService.remove(orderFile.getFileId());
        if (remove.getCode() == SaResult.CODE_ERROR){
            throw new InvalidInputException("文件不存在");
        }
        return removeById(id);
    }
}
