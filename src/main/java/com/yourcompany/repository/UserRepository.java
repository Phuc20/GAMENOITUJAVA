package com.yourcompany.repository;

import com.yourcompany.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
   // void deleteByUsername(String username); // Thêm dòng này
}