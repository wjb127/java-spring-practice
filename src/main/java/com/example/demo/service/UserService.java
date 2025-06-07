package com.example.demo.service;

import com.example.demo.mapper.UserMapper;
import com.example.demo.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserService {

    private final UserMapper userMapper;

    @Autowired
    public UserService(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    /**
     * 모든 사용자 조회
     */
    @Transactional(readOnly = true)
    public List<User> getAllUsers() {
        return userMapper.findAll();
    }

    /**
     * ID로 사용자 조회
     */
    @Transactional(readOnly = true)
    public User getUserById(Long id) {
        return userMapper.findById(id);
    }

    /**
     * 이메일로 사용자 조회
     */
    @Transactional(readOnly = true)
    public User getUserByEmail(String email) {
        return userMapper.findByEmail(email);
    }

    /**
     * 사용자 생성
     */
    public User createUser(User user) {
        // 이메일 중복 체크
        User existingUser = userMapper.findByEmail(user.getEmail());
        if (existingUser != null) {
            throw new RuntimeException("이미 존재하는 이메일입니다: " + user.getEmail());
        }

        int result = userMapper.insert(user);
        if (result > 0) {
            return user; // ID가 자동으로 설정됨
        } else {
            throw new RuntimeException("사용자 생성에 실패했습니다.");
        }
    }

    /**
     * 사용자 수정
     */
    public User updateUser(User user) {
        User existingUser = userMapper.findById(user.getId());
        if (existingUser == null) {
            throw new RuntimeException("존재하지 않는 사용자입니다: " + user.getId());
        }

        // 이메일 중복 체크 (자신 제외)
        User emailUser = userMapper.findByEmail(user.getEmail());
        if (emailUser != null && !emailUser.getId().equals(user.getId())) {
            throw new RuntimeException("이미 존재하는 이메일입니다: " + user.getEmail());
        }

        int result = userMapper.update(user);
        if (result > 0) {
            return userMapper.findById(user.getId());
        } else {
            throw new RuntimeException("사용자 수정에 실패했습니다.");
        }
    }

    /**
     * 사용자 삭제
     */
    public boolean deleteUser(Long id) {
        User existingUser = userMapper.findById(id);
        if (existingUser == null) {
            throw new RuntimeException("존재하지 않는 사용자입니다: " + id);
        }

        int result = userMapper.deleteById(id);
        return result > 0;
    }

    /**
     * 전체 사용자 수 조회
     */
    @Transactional(readOnly = true)
    public int getUserCount() {
        return userMapper.count();
    }
} 