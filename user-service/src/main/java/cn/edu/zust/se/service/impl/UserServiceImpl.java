package cn.edu.zust.se.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.query.UserQuery;
import cn.edu.zust.se.exception.InvalidInputException;
import cn.edu.zust.se.entity.po.User;
import cn.edu.zust.se.entity.vo.UserVo;
import cn.edu.zust.se.mapper.UserMapper;
import cn.edu.zust.se.service.IUserService;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author anymore131
 * @since 2024-11-16
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public UserVo login(User user) {
        if (user.getUserName() == null || user.getUserName().isEmpty()){
            throw new InvalidInputException("用户名不能为空！");
        }
        if (user.getPassword() == null || user.getPassword().isEmpty()){
            throw new InvalidInputException("密码不能为空！");
        }
        QueryWrapper<User> queryWrapper = new QueryWrapper<User>()
                .eq("user_name", user.getUserName());
        User newUser = userMapper.selectOne(queryWrapper);
        if (newUser == null){
            throw new InvalidInputException("账号不存在！");
        }
        if (!newUser.getPassword().equals(user.getPassword())){
            throw new InvalidInputException("密码错误！");
        }
        if (newUser.getId() == null){
            throw new InvalidInputException("登录失败！");
        }
        StpUtil.login(newUser.getId());


        return BeanUtil.copyProperties(newUser, UserVo.class);
    }

    @Override
    public UserVo addUser(User user) {
        if (user.getUserName() == null || user.getUserName().isEmpty()){
            throw new InvalidInputException("用户名不能为空！");
        }
        if (user.getRealName() == null || user.getRealName().isEmpty()){
            throw new InvalidInputException("真实姓名不能为空！");
        }
        if (user.getPassword() == null || user.getPassword().isEmpty()){
            user.setPassword("666666");
        }
        user.setRole("user");
        user.setCreatedTime(LocalDateTime.now());
        userMapper.insert(user);
        return BeanUtil.copyProperties(user, UserVo.class);
    }

    @Override
    public UserVo updateUser(User user) {
        if (user.getId() == null) {
            throw new InvalidInputException("用户ID不能为空！");
        }
        // 验证用户是否存在
        User existUser = userMapper.selectById(user.getId());
        if (existUser == null) {
            throw new InvalidInputException("用户不存在！");
        }
        
        user.setLastUpdate(LocalDateTime.now());
        userMapper.updateById(user);
        return BeanUtil.copyProperties(user, UserVo.class);
    }

    @Override
    public boolean deleteUser(Integer id) {
        if (id == null) {
            throw new InvalidInputException("用户ID不能为空！");
        }
        return userMapper.deleteById(id) > 0;
    }

    @Override
    public PageDto<UserVo> pageUsers(UserQuery userQuery) {
        Page<User> page = userQuery.toMpPage(userQuery.getSortBy(), userQuery.isAsc());
        lambdaQuery()
                .like(userQuery.getUserName() != null, User::getUserName , userQuery.getUserName())
                .like(userQuery.getRealName() != null, User::getRealName , userQuery.getRealName())
                .eq(userQuery.getRole() != null, User::getRole, userQuery.getRole())
                .page(page);
        return PageDto.of(page, UserVo.class);
    }

    @Override
    public UserVo getUserById(Integer id) {
        if (id == null) {
            throw new InvalidInputException("用户ID不能为空！");
        }
        User user = userMapper.selectById(id);
        if (user == null) {
            throw new InvalidInputException("用户不存在！");
        }
        return BeanUtil.copyProperties(user, UserVo.class);
    }

    @Override
    public UserVo getUserByUserName(String userName) {
        if (userName == null || userName.isEmpty()) {
            throw new InvalidInputException("用户名不能为空！");
        }
        QueryWrapper<User> queryWrapper = new QueryWrapper<User>()
                .eq("user_name", userName);
        User user = userMapper.selectOne(queryWrapper);
        if (user == null) {
            throw new InvalidInputException("用户不存在！");
        }
        return BeanUtil.copyProperties(user, UserVo.class);
    }

    @Override
    public boolean resetPassword(Integer userId, String newPassword) {
        if (userId == null) {
            throw new InvalidInputException("用户ID不能为空！");
        }
        if (newPassword == null || newPassword.isEmpty()) {
            throw new InvalidInputException("新密码不能为空！");
        }
        
        User user = userMapper.selectById(userId);
        if (user == null) {
            throw new InvalidInputException("用户不存在！");
        }
        
        user.setPassword(newPassword);
        user.setLastUpdate(LocalDateTime.now());
        return userMapper.updateById(user) > 0;
    }

    @Override
    public boolean updatePassword(Integer userId, String oldPassword, String newPassword) {
        if (userId == null) {
            throw new InvalidInputException("用户ID不能为空！");
        }
        if (oldPassword == null || oldPassword.isEmpty()) {
            throw new InvalidInputException("原密码不能为空！");
        }
        if (newPassword == null || newPassword.isEmpty()) {
            throw new InvalidInputException("新密码不能为空！");
        }
        
        User user = userMapper.selectById(userId);
        if (user == null) {
            throw new InvalidInputException("用户不存在！");
        }
        if (!user.getPassword().equals(oldPassword)) {
            throw new InvalidInputException("原密码错误！");
        }
        
        user.setPassword(newPassword);
        user.setLastUpdate(LocalDateTime.now());
        return userMapper.updateById(user) > 0;
    }
}