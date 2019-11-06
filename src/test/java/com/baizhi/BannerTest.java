package com.baizhi;

import com.baizhi.dao.BannerDao;
import com.baizhi.entity.Banner;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class BannerTest {
    @Autowired
    private BannerDao bannerDao;

    @Test
    void test1() {
        List<Banner> banners = bannerDao.selectAll();
        for (Banner banner : banners) {
            System.out.println(banner);
        }
    }
}
