package com.baizhi.service;

import com.baizhi.annotation.ClearRedisCache;
import com.baizhi.dao.BannerDao;
import com.baizhi.entity.Banner;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

@Service
@Transactional
public class BannerServiceImpl implements BannerService {
    @Autowired
    private BannerDao bannerDao;

    @Override
    @ClearRedisCache
    public String add(Banner banner) {
        banner.setId(UUID.randomUUID().toString());
        banner.setCreateDate(new Date());
        int i = bannerDao.insertSelective(banner);
        if (i == 0) {
            throw new RuntimeException("添加失败");
        }
        return banner.getId();
    }

    @Override
    @ClearRedisCache
    public void update(Banner banner) {
        if ("".equals(banner.getCover())) {
            banner.setCover(null);
        }
        try {
            bannerDao.updateByPrimaryKeySelective(banner);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("修改失败");
        }
    }

    @Override
    public Map<String, Object> findByPage(Integer page, Integer rows) {
        Banner banner = new Banner();
        Integer start = (page - 1) * rows;
        RowBounds rowBounds = new RowBounds(start, rows);
        List<Banner> banners = bannerDao.selectByRowBounds(banner, rowBounds);
        int count = bannerDao.selectCount(banner);
        Map<String, Object> map = new HashMap<>();
        map.put("page", page);
        map.put("rows", banners);
        map.put("total", count % rows == 0 ? count / rows : count / rows + 1);//总共有几页
        map.put("records", count);//总共有多少条数据
        return map;
    }

    @Override
    @ClearRedisCache
    public void delete(String id, HttpServletRequest request) {
        Banner banner = bannerDao.selectByPrimaryKey(id);
        System.out.println(banner);
        int i = bannerDao.deleteByPrimaryKey(id);
        if (i == 0) {
            throw new RuntimeException("删除失败");
        } else {
            String cover = banner.getCover();
            if (cover != null && !"".equals(cover)) {
              /* String realPath = request.getServletContext().getRealPath("/bootStrap/img/");
               File file=new File(realPath,cover);*/
                File file = new File(request.getServletContext().getRealPath("/bootstrap/img/"), cover);
                boolean b = file.delete();
                if (b == false) {
                    throw new RuntimeException("删除轮播图片失败");
                }

            }
        }

    }
}
