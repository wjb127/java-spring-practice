-- MySQL 데이터베이스 및 테이블 생성 스크립트

-- 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS demo_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 사용
USE demo_db;

-- users 테이블 생성
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    age INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_name (name)
);

-- 샘플 데이터 삽입
INSERT INTO users (name, email, age) VALUES 
('홍길동', 'hong@example.com', 30),
('김철수', 'kim@example.com', 25),
('이영희', 'lee@example.com', 28),
('박민수', 'park@example.com', 35),
('정수진', 'jung@example.com', 32);

-- 데이터 확인
SELECT * FROM users; 