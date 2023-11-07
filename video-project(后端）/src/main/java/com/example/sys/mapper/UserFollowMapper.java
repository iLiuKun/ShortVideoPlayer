package com.example.sys.mapper;

import com.example.sys.entity.User;
import com.example.sys.entity.UserFollow;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author qiniuteam
 * @since 2023-10-25
 */
public interface UserFollowMapper extends BaseMapper<UserFollow> {


    List<User> getFollowersByUserId(Integer userId);

    int checkFollowing(Integer followerId, Integer followedId);

    List<User> getFollowedsByUserId(Integer userId);
}
