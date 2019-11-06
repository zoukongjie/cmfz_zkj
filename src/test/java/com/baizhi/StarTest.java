package com.baizhi;

import com.baizhi.dao.StarDao;
import com.baizhi.entity.Star;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class StarTest {
    @Autowired
    private StarDao starDao;

    @Test
    void test1() {
        List<Star> stars = starDao.selectAll();
        for (Star star : stars) {
            System.out.println(star);
        }

    }
}
