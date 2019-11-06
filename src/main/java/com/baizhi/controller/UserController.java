package com.baizhi.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RequestMapping("user")
@RestController
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("selectUsersByStarId")
    public Map<String, Object> selectUsersByStarId(Integer page, Integer rows, String starId) {
        return userService.selectUsersByStarId(page, rows, starId);
    }

    @RequestMapping("export")
    public void export(HttpServletResponse response) {
        List<User> users = userService.export();
        Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams("注册用户导出表", "用户表"), User.class, users);
        //通过拼接给表名加上时间戳
        String fileName = "注册用户表(" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()) + ").xls";
        //处理中文下载乱码
        try {
            fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
            //指定下载类型为Excel
            response.setContentType("application/vnd.ms-excel");
            //设置下载头 下载类型
            response.setHeader("content-disposition", "attachment;filename=" + fileName);
            workbook.write(response.getOutputStream());
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("selectAll")
    public Map<String, Object> selectAll(Integer page, Integer rows) {
        return userService.selectAll(page, rows);
    }
}
