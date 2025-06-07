package com.example.demo.mapper;

import com.example.demo.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserMapper {
    
    /**
     * 모든 사용자 조회
     */
    List<User> findAll();
    
    /**
     * ID로 사용자 조회
     */
    User findById(@Param("id") Long id);
    
    /**
     * 이메일로 사용자 조회
     */
    User findByEmail(@Param("email") String email);
    
    /**
     * 사용자 생성
     */
    int insert(User user);
    
    /**
     * 사용자 수정
     */
    int update(User user);
    
    /**
     * 사용자 삭제
     */
    int deleteById(@Param("id") Long id);
    
    /**
     * 전체 사용자 수 조회
     */
    int count();
} 