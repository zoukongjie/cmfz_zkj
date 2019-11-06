package com.baizhi.controller;


import com.baizhi.entity.Admin;
import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("admin")
@Controller
public class AdminController {

    @Autowired
    private AdminService adminService;

    @RequestMapping("login")
    @ResponseBody
    public Map<String, Object> login(Admin admin, String inputCode, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        try {
            adminService.login(admin, inputCode, request);
            map.put("status", true);
        } catch (Exception e) {
            map.put("status", false);
            map.put("message", e.getMessage());
        }
        return map;
    }

    @RequestMapping("logout")
    public String logout(HttpServletRequest request) {
        request.getSession().removeAttribute("loginAdmin");
        System.out.println("2222");
        return "redirect:/login/login.jsp";

    }


}
