package cn.edu.zust.se.config;

import cn.dev33.satoken.SaManager;
import cn.dev33.satoken.config.SaTokenConfig;
import cn.dev33.satoken.context.SaHolder;
import cn.dev33.satoken.filter.SaServletFilter;
import cn.dev33.satoken.same.SaSameUtil;
import cn.dev33.satoken.util.SaResult;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Sa-Token 权限认证 配置类
 */
@Configuration
public class SaTokenConfigure implements WebMvcConfigurer {

    @Bean
    public void rewriteRedis() {
        // 重写 Sa-Token 的 Redis 操作方式
        SaManager.setConfig(new SaTokenConfig());
        
        // 为了让子服务也能正确获取到 Token 信息，需要配置 Cookie 作用域
        SaManager.getConfig().setTokenName("satoken")
            .setIsShare(true)  // 共享token
            .setIsReadCookie(true);  // 读取cookie中的token
    }

    // 注册 Sa-Token 全局过滤器
    @Bean
    public SaServletFilter getSaServletFilter() {
        return new SaServletFilter()
                .addInclude("/**")
                .addExclude("/favicon.ico")
                .setAuth(obj -> {
                    // 校验 Same-Token 身份凭证     —— 以下两句代码可简化为：SaSameUtil.checkCurrentRequestToken();
                    String token = SaHolder.getRequest().getHeader(SaSameUtil.SAME_TOKEN);
                    SaSameUtil.checkToken(token);
                })
                .setError(e -> {
                    return SaResult.error(e.getMessage());
                })
                ;
    }
}
