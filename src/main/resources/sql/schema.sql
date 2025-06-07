-- 통합 데이터베이스 스키마 (MySQL/PostgreSQL 호환)
-- 환경변수 DB_DRIVER에 따라 자동 감지

-- users 테이블 생성 (공통 문법)
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,  -- PostgreSQL: BIGSERIAL, MySQL에서는 BIGINT AUTO_INCREMENT로 해석
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    age INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 인덱스 생성 (공통)
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_name ON users(name); 