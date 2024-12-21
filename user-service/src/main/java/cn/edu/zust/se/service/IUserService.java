package cn.edu.zust.se.service;

import cn.edu.zust.se.entity.dto.PageDto;
import cn.edu.zust.se.entity.po.User;
import cn.edu.zust.se.entity.query.PageQuery;
import cn.edu.zust.se.entity.query.UserQuery;
import cn.edu.zust.se.entity.vo.UserVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * @author anymore131
 * @since 2024-11-16
 */
public interface IUserService extends IService<User> {
    public UserVo login(User user);
    public UserVo addUser(User user);
    public UserVo updateUser(User user);
    public boolean deleteUser(Integer id);
    public PageDto<UserVo> pageUsers(UserQuery userQuery);
    public UserVo getUserById(Integer id);
    public UserVo getDeleteUserById(Integer id);
    public UserVo getUserByUserName(String userName);
    public boolean resetPassword(Integer userId, String newPassword);
    public boolean updatePassword(Integer userId, String oldPassword, String newPassword);
    public String getUserNameById(Integer id);
    public String getRole(Integer id);
    boolean checkUser(Integer id, String password);
    public PageDto<UserVo> pageUsersName(PageQuery pageQuery);
}
