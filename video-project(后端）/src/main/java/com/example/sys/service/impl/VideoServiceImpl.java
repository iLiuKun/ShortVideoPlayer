package com.example.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.example.sys.entity.Video;
import com.example.sys.mapper.VideoMapper;
import com.example.sys.service.IVideoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author qiniuteam
 * @since 2023-10-25
 */
@Service
public class VideoServiceImpl extends ServiceImpl<VideoMapper, Video> implements IVideoService {

    @Autowired
    private VideoMapper videoMapper;
    @Override
    public List<Video> getVideosByCategoryId(Integer categoryId) {
        List<Video> videos=this.baseMapper.selectVideosByCategoryId(categoryId);
        return videos;
    }

    @Override
    public Integer getUserIdByVideoId(Integer videoId) {
        return videoMapper.getUserIdByVideoId(videoId);
    }

    @Override
    public boolean likeVideo(Integer videoId) {
        Video video = videoMapper.selectById(videoId);
        if (video != null) {
            video.setLikes(video.getLikes() + 1);
            int result = videoMapper.updateById(video);
            return result > 0;
        }
        return false;
    }

    @Override
    public List<Video> getVideosByUserId(Integer userId) {
        return videoMapper.findVideosByUserId(userId);
    }

    @Override
    public List<Video> getFavoriteVideosByUserId(Integer userId) {
        return videoMapper.findFavoriteVideosByUserId(userId);
    }

    @Override
    public boolean saveVideo(Video video) {
        video.setCreatedAt(LocalDateTime.now());
        video.setUpdatedAt(LocalDateTime.now());
        return this.save(video);
    }

    @Override
    public List<Video> getRecommendVideos() {
        List<Video> allVideos = videoMapper.selectList(null);
        if(allVideos.isEmpty()) {
            return new ArrayList<>();
        }

        // 在这里实现随机逻辑
        Collections.shuffle(allVideos);
        return allVideos.subList(0, Math.min(allVideos.size(), 30));

    }

    @Override
    public List<Video> searchVideos(String keyword) {
        QueryWrapper<Video> queryWrapper = new QueryWrapper<>();
        if (StringUtils.isNotBlank(keyword)) {
            // 模糊搜索，假设在Video实体中有title字段
            queryWrapper.like("title", keyword);
        }
        return list(queryWrapper);
    }


}
