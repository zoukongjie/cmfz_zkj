package com.baizhi.service;

import com.baizhi.entity.Album;

import java.util.Map;

public interface AlbumService {

    //查询所有并分页
    Map<String, Object> selectAll(Integer page, Integer rows);

    //添加方法
    String add(Album album);

    //修改方法
    void edit(Album album);

    // 根据id查一个专辑
    Album selectOne(String id);

}
