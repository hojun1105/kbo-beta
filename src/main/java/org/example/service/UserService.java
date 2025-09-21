package org.example.service;

import org.example.dao.UserDAO;
import org.example.model.User;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final UserDAO userDao;

    public UserService(UserDAO userDao) {
        this.userDao = userDao;
    }

    public User getUserById(String user_id) {
        if(userDao.findById(user_id).isPresent()) {
            return userDao.findById(user_id).get();
        }
        return null;
    }

    public void updateUserInfo(String userId, User form) {
        User user = userDao.findById(userId).orElse(null);
        if(user != null) {
            user.setNickname(form.getNickname());
            user.setEmail(form.getEmail());
            user.setInstagramId(form.getInstagramId());
            userDao.save(user);
        }
    }

    public void deleteUserById(String userId) {
        userDao.deleteById(userId);
    }

    public boolean register(User user) {
        if (userDao.findById(user.getUserId()).isPresent()) {
            return false; // 중복 아이디
        }
        userDao.save(user);
        return true;
    }

    public User login(String userId, String password) {
        return userDao.findByUserIdAndPassword(userId, password);
    }
}
