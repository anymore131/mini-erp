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
    UserVo login(User user);
    UserVo addUser(User user);
    UserVo updateUser(User user);
    boolean deleteUser(Integer id);
    PageDto<UserVo> pageUsers(UserQuery userQuery);
    UserVo getUserById(Integer id);
    UserVo getDeleteUserById(Integer id);
    UserVo getUserByUserName(String userName);
    boolean resetPassword(Integer userId, String newPassword);
    boolean updatePassword(Integer userId, String oldPassword, String newPassword);
    String getUserNameById(Integer id);
    String getRole(Integer id);
    boolean checkUser(Integer id, String password);
    PageDto<UserVo> pageUsersName(PageQuery pageQuery);
    List<UserVo> getUsersByUserName(String userName);
}
