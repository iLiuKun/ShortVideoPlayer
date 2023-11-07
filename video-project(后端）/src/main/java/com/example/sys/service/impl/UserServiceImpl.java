package com.example.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.sys.entity.User;
import com.example.sys.mapper.UserMapper;
import com.example.sys.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author qiniuteam
 * @since 2023-10-25
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User findByUsername(String username) {

        return userMapper.selectOne(new QueryWrapper<User>().eq("username", username));
    }

    @Override
    public void register(User user) {
        userMapper.insert(user);
    }

    @Override
    public Map<String, Object> login(User user) {

        Map<String,Object> data=new HashMap<>();
        User loginuser = findByUsername(user.getUsername());
        if(this.checkPassword(user.getUsername(),user.getPassword())){
            data.put("username",loginuser.getUsername());
            data.put("userId",loginuser.getId());
            data.put("avatar_url",loginuser.getAvatarUrl());
        }
        else{
            data=null;
        }
        return data;

    }

    @Override
    public boolean checkPassword(String username, String password) {
        User user = findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {

            return true;

        }
        return false;
    }
}
