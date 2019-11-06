package com.baizhi.controller;

import com.baizhi.entity.Star;
import com.baizhi.service.StarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("star")
public class StarController {

    @Autowired
    private StarService starService;

    @RequestMapping("selectAll")
    public Map<String, Object> selectAll(Integer page, Integer rows) {
        Map<String, Object> map = starService.selectAll(page, rows);
        return map;
    }

    @RequestMapping("edit")
    public Map<String, Object> edit(String oper, Star star, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        try {
            if ("add".equals(oper)) {
                String id = starService.add(star);
                map.put("message", id);
            }
            if ("edit".equals(oper)) {
                starService.update(star);
            }
            if ("del".equals(oper)) {
                starService.delete(star.getId(), request);
                System.out.println(222222);
            }

            map.put("status", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("status", false);
            map.put("message", e.getMessage());
        }
        return map;
    }

    @RequestMapping("upload")
    public Map<String, Object> upload(MultipartFile photo, String id, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        try {
//            文件上传
            photo.transferTo(new File(request.getServletContext().getRealPath("/star/img"), photo.getOriginalFilename()));
//            修改banner对象中cover属性
            Star star = new Star();
            star.setId(id);
            star.setPhoto(photo.getOriginalFilename());
            starService.update(star);
            map.put("status", true);
        } catch (IOException e) {
            e.printStackTrace();
            map.put("status", false);
        }
        return map;
    }

    @RequestMapping("getAllStarForSelect")
    public void getAllStarForSelect(HttpServletResponse response) throws IOException {
        List<Star> list = starService.getAllStarForSelect();
        String str = "<select>";
        for (Star star : list) {
            str += "<option value=" + star.getId() + ">" + star.getNickname() + "</option>";
        }
        str += "</select>";
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().print(str);

    }
}
