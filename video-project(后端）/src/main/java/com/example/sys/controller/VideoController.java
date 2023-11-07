package com.example.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.example.sys.entity.Video;
import com.example.sys.service.IVideoService;
import com.example.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author qiniuteam
 * @since 2023-10-25
 */
@RestController
@RequestMapping("/video")
public class VideoController {
    @Autowired
    private IVideoService videoService;

    @GetMapping("/category/{categoryId}")
    public Result<List<Video>> getVideosByCategoryId(@PathVariable Integer categoryId) {
        List<Video> videos = videoService.getVideosByCategoryId(categoryId);
        return Result.success(videos);
    }

    @PostMapping("/{videoId}/like")
    public Result<String> likeVideo(@PathVariable("videoId") Integer videoId) {
        boolean isLiked = videoService.likeVideo(videoId);
        if (isLiked) {
            return Result.success("Video liked successfully.");
        } else {
            return Result.fail("已点赞");
        }
    }

    @GetMapping("/user")
    public Result<List<Video>> getVideosByUserId(@RequestHeader("userId") Integer userId) {
        List<Video> videos = videoService.getVideosByUserId(userId);
        if (videos != null && !videos.isEmpty()) {
            return Result.success(videos);
        } else {
            return Result.fail("No videos found for the given user.");
        }
    }
    @GetMapping("/userfavorites")
    public Result<List<Video>> getFavoriteVideosByUserId(@RequestHeader("userId") Integer userId) {
        List<Video> videos = videoService.getFavoriteVideosByUserId(userId);
        return Result.success(videos);
    }
    @GetMapping("/getrecommend")
    public Result<List<Video>> getRecommend() {
        List<Video> videos = videoService.getRecommendVideos();
        if (videos != null && !videos.isEmpty()) {
            return Result.success(videos);
        } else {
            return Result.fail("没有找到推荐视频。");
        }
    }
    @GetMapping("/search")
    public ResponseEntity<Result<List<Video>>> searchVideos(@RequestParam String keyword) {
        List<Video> videos = videoService.searchVideos(keyword);
        if (videos != null && !videos.isEmpty()) {
            return ResponseEntity.ok(Result.success(videos));
        } else {
            return ResponseEntity.ok(Result.fail("未找到相关视频。"));
        }
    }
}
