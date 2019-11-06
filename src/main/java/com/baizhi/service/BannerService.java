package com.baizhi.service;

import com.baizhi.entity.Banner;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public interface BannerService {
    public void delete(String id, HttpServletRequest request);

    public String add(Banner banner);

    public void update(Banner banner);

    Map<String, Object> findByPage(Integer page, Integer rows);

}
