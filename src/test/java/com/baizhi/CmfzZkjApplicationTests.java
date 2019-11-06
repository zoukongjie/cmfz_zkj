package com.baizhi;

import com.baizhi.dao.AdminDao;
import com.baizhi.entity.Admin;
import org.apache.ibatis.session.RowBounds;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class CmfzZkjApplicationTests {
    @Autowired
    private AdminDao adminDao;

    @Test
    void contextLoads() {
        List<Admin> list = adminDao.selectAll();
        for (Admin admin : list) {
            System.out.println(admin);
        }
    }

    @Test
    void test1() {
        Admin admin = new Admin("7", "zhangsan", "1111", "xiaosan");
        adminDao.insert(admin);
        System.out.println("ok");
    }

    @Test
    void test3() {
        //int i = adminDao.deleteByPrimaryKey("7");
        Admin admin = new Admin();
        RowBounds rowBounds = new RowBounds(1, 2);

        List<Admin> admins = adminDao.selectByRowBounds(admin, rowBounds);
        for (Admin admin1 : admins) {
            System.out.println(admin1);
        }

    }


}
