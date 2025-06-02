package service;

import dao.UserDAO;
import model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final UserDAO userDao;

    @Autowired
    public UserService(UserDAO userDao) {
        this.userDao = userDao;
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
