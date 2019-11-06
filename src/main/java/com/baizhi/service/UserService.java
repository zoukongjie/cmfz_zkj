package com.baizhi.service;

import com.baizhi.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    Map<String, Object> selectUsersByStarId(Integer page, Integer rows, String starId);

    List<User> export();

    Map<String, Object> selectAll(Integer page, Integer rows);

}
