package com.example.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;

@Component
public class DatabaseInitializer implements ApplicationListener<ContextRefreshedEvent> {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    private boolean initialized = false;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        if (!initialized) {
            initializeDatabase();
            initialized = true;
        }
    }
    
    private void initializeDatabase() {
        try {
            // users 테이블이 존재하는지 확인
            Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM information_schema.tables WHERE table_name = 'users'", 
                Integer.class);
            
            if (count == 0) {
                System.out.println("🔧 users 테이블이 없습니다. 스키마를 생성합니다...");
                
                // schema.sql 파일 읽기
                ClassPathResource resource = new ClassPathResource("schema.sql");
                String sql = new BufferedReader(
                    new InputStreamReader(resource.getInputStream(), StandardCharsets.UTF_8))
                    .lines()
                    .collect(Collectors.joining("\n"));
                
                // SQL 실행 (세미콜론으로 분할하여 각각 실행)
                String[] sqlStatements = sql.split(";");
                for (String statement : sqlStatements) {
                    String trimmed = statement.trim();
                    if (!trimmed.isEmpty() && !trimmed.startsWith("--")) {
                        try {
                            jdbcTemplate.execute(trimmed);
                        } catch (Exception e) {
                            System.err.println("SQL 실행 오류: " + trimmed);
                            System.err.println("오류: " + e.getMessage());
                        }
                    }
                }
                
                System.out.println("✅ 데이터베이스 스키마 생성 완료!");
                
                // 사용자 수 확인
                try {
                    Integer userCount = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM users", Integer.class);
                    System.out.println("📊 현재 사용자 수: " + userCount);
                } catch (Exception e) {
                    System.out.println("📊 사용자 수 확인 중 오류: " + e.getMessage());
                }
                
            } else {
                System.out.println("✅ users 테이블이 이미 존재합니다.");
                try {
                    Integer userCount = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM users", Integer.class);
                    System.out.println("📊 현재 사용자 수: " + userCount);
                } catch (Exception e) {
                    System.out.println("📊 사용자 수 확인 중 오류: " + e.getMessage());
                }
            }
            
        } catch (Exception e) {
            System.err.println("❌ 데이터베이스 초기화 오류: " + e.getMessage());
            e.printStackTrace();
        }
    }
} 