#Green_Board

그린보드 프로젝트 (JSP + Spring Boot)
AI의 도움을 받아 개발되었습니다. 🙌

<p> <img width="212" height="267" alt="image" src="https://github.com/user-attachments/assets/59b16b5e-c6ae-4342-a9d0-1e8fe818617f" /> <img width="209" height="224" alt="image" src="https://github.com/user-attachments/assets/2dd2ecae-f210-4968-bdc1-e91ee73b9168" /> </p>
🔧 Tech Stack
Java 21, Gradle

Spring Boot 3.5.6
spring-boot-starter-web (JSP)
spring-boot-starter-data-jpa
spring-boot-starter-validation
spring-security-crypto (BCrypt)

JSP/JSTL
org.apache.tomcat.embed:tomcat-embed-jasper,
jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl

DB: Oracle (ojdbc11)
View 엔진: JSP (JSTL/EL)
포트: 8090

✨ 주요 기능
게시판
목록/상세/작성/수정/삭제 (작성·수정·삭제는 로그인 사용자만)
페이지네이션
검색: 제목/작성자/전체

사용자
회원가입 / 로그인 / 로그아웃 (BCrypt 비밀번호 해시)
마이페이지: 내가 작성한 글 목록

UX 보조
로그인 필요 시 알림/이동
작성/수정/삭제/로그인/로그아웃 후 토스트(모달) 알림 표시(쿼리스트링 기반)
