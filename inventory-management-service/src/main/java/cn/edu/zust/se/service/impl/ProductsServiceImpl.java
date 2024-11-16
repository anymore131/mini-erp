package cn.edu.zust.se.service.impl;

import cn.edu.zust.se.entity.po.Products;
import cn.edu.zust.se.mapper.ProductsMapper;
import cn.edu.zust.se.service.IProductsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author anymore131
 * @since 2024-11-16
 */
@Service
public class ProductsServiceImpl extends ServiceImpl<ProductsMapper, Products> implements IProductsService {

}
