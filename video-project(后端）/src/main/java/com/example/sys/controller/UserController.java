package com.example.sys.controller;

import com.example.sys.entity.User;
import com.example.sys.entity.Video;
import com.example.sys.service.IUserFavoriteService;
import com.example.sys.service.IUserFollowService;
import com.example.sys.service.IUserService;
import com.example.sys.service.IVideoService;
import com.example.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author qiniuteam
 * @since 2023-10-25
 */
@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private IUserService userService;
    @Autowired
    private IUserFavoriteService userFavoriteService;
    @Autowired
    private IVideoService videoService;
    @Autowired
    private IUserFollowService userFollowService;
    @GetMapping("/all")
    public List<User> getAllUser(){
        List<User> list=userService.list();
        return list;
    }
    @PostMapping("/login")
    public Result<Map<String,Object>> login(@RequestBody User user) {
        Map<String,Object> data=userService.login(user);
        if(data!=null){
            return Result.success(data);
        }
        return Result.fail(20002,"用户名或密码错误");
    }

    @PostMapping("/register")
    public Result<String> register(@RequestBody User user) {
        User existingUser = userService.findByUsername(user.getUsername());
        if (existingUser != null) {
            return Result.fail("用户名已存在");
        }
        userService.register(user);
        return Result.success("注册成功");
    }

    @PostMapping("/favorite/{videoId}")
    public Result<String> addUserFavorite(@RequestHeader("userId") Integer userId, @PathVariable("videoId") Integer videoId) {
        if(userFavoriteService.isVideoAlreadyFavorited(userId, videoId)) {
            return Result.fail("Video is already favorited.");
        }
        boolean isAdded = userFavoriteService.addFavorite(userId, videoId);
        return isAdded ? Result.success("Video added to favorites successfully.") : Result.fail("Failed to add video to favorites.");
    }

    @PostMapping("/unfavorite/{videoId}")
    public Result<String> unfavoriteVideo(@RequestHeader("userId") Integer userId, @PathVariable("videoId") Integer videoId) {
        boolean isUnfavorited = userFavoriteService.unfavoriteVideo(userId, videoId);
        return isUnfavorited ? Result.success("Video unfavorited successfully.") : Result.fail("Failed to unfavorite video.");
    }

    @GetMapping("/favorite/video/urls")
    public Result<List<String>> getFavoriteVideoUrls(@RequestHeader("userId") int userId) {
        List<String> videoUrls = userFavoriteService.getFavoriteVideoUrlsByUserId(userId);
        return Result.success(videoUrls);
    }

    @PostMapping("/follow/video/{videoId}")
    public Result<String> followUserFromVideo(@RequestHeader("userId") Integer followerId, @PathVariable("videoId") Integer videoId) {
        if(followerId == videoService.getUserIdByVideoId(videoId)) {
            return Result.fail("You cannot follow yourself.");
        }
        if(userFollowService.isAlreadyFollowing(followerId, videoService.getUserIdByVideoId(videoId))) {
            return Result.fail("You are already following this user.");
        }
        Integer followedId = videoService.getUserIdByVideoId(videoId);
        if (followedId == null) {
            return Result.fail("Video or User not found.");
        }
        boolean isFollowed = userFollowService.followUser(followerId, followedId);
        return isFollowed ? Result.success("Followed successfully.") : Result.fail("Failed to follow user.");
    }

    @PostMapping("/unfollow/video/{videoId}")
    public Result<String> unfollowUserFromVideo(@RequestHeader("userId") Integer followerId, @PathVariable("videoId") Integer videoId) {
        Integer followedId = videoService.getUserIdByVideoId(videoId);
        if (followedId == null) {
            return Result.fail("Video or User not found.");
        }
        boolean isUnfollowed = userFollowService.unfollowUser(followerId, followedId);
        return isUnfollowed ? Result.success("Unfollowed successfully.") : Result.fail("Failed to unfollow user.");
    }
    //粉丝
    @GetMapping("/followers")
    public Result<List<User>> getFollowers(@RequestHeader("userId") Integer userId) {
        List<User> followers = userFollowService.getFollowersByUserId(userId);
        return Result.success(followers);
    }
    //关注
    @GetMapping("/followeds")
    public Result<List<User>> getFolloweds(@RequestHeader("userId") Integer userId) {
        List<User> followeds = userFollowService.getFollowedsByUserId(userId);
        return Result.success(followeds);
    }
    @PostMapping("/uploadvideo")
    public ResponseEntity<Result<String>> addVideo( @RequestBody Video video) {
        video.setCreatedAt(LocalDateTime.now()); // 设置创建时间
        video.setUpdatedAt(LocalDateTime.now()); // 设置更新时间
        // 检查视频是否保存成功
        boolean saved = videoService.saveVideo(video);
        if(saved) {
            return ResponseEntity.ok(Result.success("视频上传成功"));
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Result.fail("视频上传失败"));
        }
    }

}
