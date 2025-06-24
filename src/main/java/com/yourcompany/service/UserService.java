package com.yourcompany.service;

import com.yourcompany.model.User;
import com.yourcompany.repository.UserRepository;

import java.util.List;
import java.util.Optional;

/**
 * Service xử lý logic cho User.
 */
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    // Lấy tất cả user
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    // Tìm user theo username
    public User getUserByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    // Thêm user mới
    public void addUser(User user) {
        userRepository.save(user);
    }

    // Xoá user theo username
   // public void deleteUserByUsername(String username) {
    //    userRepository.deleteByUsername(username);
   // }
}