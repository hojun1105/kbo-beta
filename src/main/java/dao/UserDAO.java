package dao;

import model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserDAO extends JpaRepository<User, String> {

    // 로그인 시 사용
    User findByUserIdAndPassword(String userId, String password);

}