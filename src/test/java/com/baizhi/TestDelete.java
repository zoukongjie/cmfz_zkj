package com.baizhi;

import com.baizhi.dao.ArticleDao;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class TestDelete {
    @Autowired
    private ArticleDao articleDao;

    @Test
    void test1() {
        articleDao.deleteByPrimaryKey("8d241911-e7cb-4fa0-beb8-dec07cfeadda");
    }
}
