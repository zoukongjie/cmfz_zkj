package com.baizhi.service;

import com.baizhi.entity.Article;

import java.util.Map;

public interface ArticleService {

    Map<String, Object> selectAll(Integer page, Integer rows);

    void add(Article article);

    void edit(Article article);

    void del(String id);

}
