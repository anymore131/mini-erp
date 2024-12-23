package cn.edu.zust.se.controller;

import cn.dev33.satoken.annotation.SaCheckRole;
import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.query.PageQuery;
import cn.edu.zust.se.entity.query.UserQuery;
import cn.edu.zust.se.exception.ForbiddenException;
import cn.edu.zust.se.entity.po.User;
import cn.edu.zust.se.entity.vo.UserVo;
import cn.edu.zust.se.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @author anymore131
 * @since 2024-11-16
 */
@RestController
@RequestMapping("")
public class UserController {
    private static final org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(UserController.class);
    @Autowired
    private IUserService userService;

    @PostMapping("/login")
    public SaResult login(@RequestBody User user){
        UserVo userVo = userService.login(user);
        if (userVo.getId() == null){
            return SaResult.error("登录失败！");
        }
        return SaResult.data(userVo).setMsg("登录成功！");
    }

    @PutMapping("/add")
    @SaCheckRole("admin")
    public SaResult add(@RequestBody User user){
        UserVo userVo = userService.addUser(user);
        return SaResult.data(userVo).setMsg("添加成功！");
    }

    @PutMapping("/update")
    public SaResult update(@RequestBody User user){
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(user.getId())) {
            throw new ForbiddenException("无权修改其他用户信息！");
        }
        UserVo userVo = userService.updateUser(user);
        return SaResult.data(userVo).setMsg("更新成功！");
    }

    @DeleteMapping("/delete")
    @SaCheckRole("admin")
    public SaResult delete(@RequestParam Integer id){
        boolean isDelete = userService.deleteUser(id);
        return SaResult.data(isDelete).setMsg("删除成功！");
    }

    @RequestMapping("/page")
    public SaResult page(@RequestBody UserQuery userQuery){
        if (!StpUtil.hasRole("admin")) {
            throw new ForbiddenException("无权查看用户列表！");
        }
        PageDto<UserVo> userPageDto = userService.pageUsers(userQuery);
        return SaResult.data(userPageDto).setMsg("查询成功！");
    }

    @GetMapping("/get/{id}")
    public SaResult get(@PathVariable Integer id){
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(id)) {
            throw new ForbiddenException("无权查看其他用户信息！");
        }
        UserVo userVo = userService.getUserById(id);
        return SaResult.data(userVo).setMsg("查询成功！");
    }

    @PutMapping("/resetPassword")
    public SaResult resetPassword(@RequestBody Map<String, String> params){
        Integer userId = Integer.parseInt(params.get("userId"));
        String newPassword = params.get("newPassword");
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        if (!StpUtil.hasRole("admin") && !currentUserId.equals(userId)) {
            throw new ForbiddenException("无权重置其他用户密码！");
        }
        boolean isReset = userService.resetPassword(userId, newPassword);
        return SaResult.data(isReset).setMsg("重置密码成功！");
    }

    @PutMapping("/updatePassword")
    public SaResult updatePassword(@RequestBody Map<String, String> params) {
        Integer currentUserId = StpUtil.getLoginIdAsInt();
        String oldPassword = params.get("oldPassword");
        String newPassword = params.get("newPassword");
        
        boolean isUpdate = userService.updatePassword(currentUserId, oldPassword, newPassword);
        return SaResult.data(isUpdate).setMsg("更新密码成功！");
    }

    @GetMapping("/getUserName/{id}")
    public String getUserNameById(@PathVariable Integer id){
        if (id == null){
            return null;
        }
        return userService.getUserNameById(id);
    }

    @GetMapping("/getDeleteUserById/{id}")
    public UserVo getDeleteUserById(@PathVariable Integer id){
        if (id == null){
            return null;
        }
        return userService.getDeleteUserById(id);
    }

    @GetMapping("/getRole/{id}")
    public String getRole(@PathVariable Integer id){
        if (id == null){
            return null;
        }
        return userService.getRole(id);
    }

    @PostMapping("/checkUser")
    public boolean checkUser(@RequestParam Integer id, @RequestParam String password){
        if (id == null || password == null){
            return false;
        }
        return userService.checkUser(id, password);
    }

    @GetMapping("/getUsers")
    public SaResult getUsers(PageQuery pageQuery){
        if (pageQuery == null){
            throw new IllegalArgumentException("pageQuery不能为空！");
        }
        return new SaResult().setData(userService.pageUsersName(pageQuery));
    }

    @GetMapping("/getUserIdByUserName/{userName}")
    public Integer getUserIdByUserName(@PathVariable String userName){
        return userService.getUserByUserName(userName).getId();
    }
}
