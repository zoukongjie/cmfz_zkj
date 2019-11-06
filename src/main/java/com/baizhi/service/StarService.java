package com.baizhi.service;

import com.baizhi.entity.Star;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface StarService {
    public void delete(String id, HttpServletRequest request);

    public void update(Star star);

    String add(Star star);

    Map<String, Object> selectAll(Integer page, Integer rows);

    List<Star> getAllStarForSelect();


}
