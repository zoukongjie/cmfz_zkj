package com.baizhi.controller;

import com.baizhi.entity.Article;
import com.baizhi.service.ArticleService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("article")
public class ArticleController {
    @Autowired
    private ArticleService articleService;

    @RequestMapping("selectAll")
    public Map<String, Object> selectAll(Integer page, Integer rows) {
        Map<String, Object> map = articleService.selectAll(page, rows);

        return map;
    }

    @RequestMapping("upload")
    public Map<String, Object> upload(MultipartFile articleImg, HttpServletRequest request) {
//        {"error":0,"url":"\/ke4\/attached\/W020091124524510014093.jpg"}
        Map<String, Object> map = new HashMap<>();
        File file = new File(request.getServletContext().getRealPath("article/img"), articleImg.getOriginalFilename());
        try {
            articleImg.transferTo(file);
            map.put("error", 0);
            map.put("url", "http://localhost:9999/cmfz_zkj/article/img/" + articleImg.getOriginalFilename());
        } catch (IOException e) {
            e.printStackTrace();
            map.put("error", 1);
        }
        return map;
    }

    @RequestMapping("browse")
    public Map<String, Object> browse(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        File file = new File(request.getServletContext().getRealPath("article/img"));
        File[] files = file.listFiles();
        List<Object> list = new ArrayList<>();
        for (File img : files) {
            Map<String, Object> imgObject = new HashMap<>();
            imgObject.put("is_dir", false);
            imgObject.put("has_file", false);
            imgObject.put("filesize", img.length());
            imgObject.put("is_photo", true);
            imgObject.put("filetype", FilenameUtils.getExtension(img.getName()));
            imgObject.put("filename", img.getName());
            imgObject.put("datetime", "2018-06-06 00:36:39");
            list.add(imgObject);
        }
        map.put("file_list", list);
        map.put("total_count", list.size());
        map.put("current_url", "http://localhost:9999/cmfz_zkj/article/img/");
        return map;
    }

    @RequestMapping("delete")
    public String delete(@RequestParam String id) {
        try {
            articleService.del(id);
            return "delete ok";
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    @RequestMapping("add")
    public Map<String, Object> add(Article article) {
        Map<String, Object> map = new HashMap<>();
        try {
            articleService.add(article);
            map.put("status", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("message", e.getMessage());
        }
        return map;

    }

    @RequestMapping("edit")
    public Map<String, Object> edit(Article article) {
        Map<String, Object> map = new HashMap<>();
        try {
            articleService.edit(article);
            map.put("status", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("message", e.getMessage());
        }
        return map;

    }
}
