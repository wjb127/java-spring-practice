-- PostgreSQL Schema for Spring MyBatis Demo
-- Render PostgreSQL 환경을 위한 스키마

-- 기존 테이블이 있다면 삭제
DROP TABLE IF EXISTS users CASCADE;

-- PostgreSQL 시퀀스 생성 (AUTO_INCREMENT 대신)
DROP SEQUENCE IF EXISTS users_id_seq CASCADE;
CREATE SEQUENCE users_id_seq START WITH 1 INCREMENT BY 1;

-- 사용자 테이블 생성
CREATE TABLE users (
    id BIGINT PRIMARY KEY DEFAULT nextval('users_id_seq'),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    age INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- updated_at 자동 업데이트 함수 생성
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- updated_at 트리거 생성
DROP TRIGGER IF EXISTS update_users_updated_at ON users;
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- 샘플 데이터 삽입
INSERT INTO users (name, email, age) VALUES 
('홍길동', 'hong@example.com', 30),
('김철수', 'kim@example.com', 25),
('이영희', 'lee@example.com', 28),
('박민수', 'park@example.com', 35),
('정수진', 'jung@example.com', 32);

-- 인덱스 생성
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_created_at ON users(created_at DESC);

-- 권한 설정 (Render 환경에서 필요할 수 있음)
-- 시퀀스 사용 권한
GRANT USAGE, SELECT ON SEQUENCE users_id_seq TO PUBLIC;
GRANT ALL PRIVILEGES ON TABLE users TO PUBLIC; 