package com.baizhi.service;

import com.baizhi.annotation.ClearRedisCache;
import com.baizhi.annotation.RedisCache;
import com.baizhi.dao.StarDao;
import com.baizhi.entity.Star;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@Transactional
public class StarServiceImpl implements StarService {

    @Autowired
    private StarDao starDao;

    @Override
    @ClearRedisCache
    public String add(Star star) {
        star.setId(UUID.randomUUID().toString());
        int i = starDao.insertSelective(star);
        if (i == 0) {
            throw new RuntimeException("添加失败");
        }
        return star.getId();
    }

    @Override
    @ClearRedisCache
    public void delete(String id, HttpServletRequest request) {
        Star star = starDao.selectByPrimaryKey(id);
        int i = starDao.deleteByPrimaryKey(id);
        if (i == 0) {
            throw new RuntimeException("删除失败");
        } else {
            String photo = star.getPhoto();
            if (photo != null && !"".equals(photo)) {
                File file = new File(request.getServletContext().getRealPath("/star/img/"), photo);
                boolean b = file.delete();
                if (b == false) {
                    throw new RuntimeException("删除头像失败");
                }

            }
        }
    }

    @Override
    @ClearRedisCache
    public void update(Star star) {
        if ("".equals(star.getPhoto())) {
            star.setPhoto(null);
        }
        try {
            starDao.updateByPrimaryKeySelective(star);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("修改失败");
        }
    }

    @Override
    @RedisCache
    public Map<String, Object> selectAll(Integer page, Integer rows) {
        Star star = new Star();
        RowBounds rowBounds = new RowBounds((page - 1) * rows, rows);
        List<Star> list = starDao.selectByRowBounds(star, rowBounds);
        int count = starDao.selectCount(star);
        Map<String, Object> map = new HashMap<>();
        map.put("page", page);
        map.put("rows", list);
        map.put("total", count % rows == 0 ? count / rows : count / rows + 1);
        map.put("records", count);
        return map;
    }

    @Override
    public List<Star> getAllStarForSelect() {
        List<Star> list = starDao.selectAll();
        return list;
    }
}
