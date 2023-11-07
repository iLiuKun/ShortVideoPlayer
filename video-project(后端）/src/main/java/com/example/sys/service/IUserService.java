package com.example.sys.service;

import com.example.sys.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author qiniuteam
 * @since 2023-10-25
 */
public interface IUserService extends IService<User> {
    User findByUsername(String username);
    void register(User user);

    Map<String, Object> login(User user);
    boolean checkPassword(String username, String password);
}
