#Green_Board

그린보드 프로젝트 (JSP + Spring Boot) <br>
약간의 AI의 도움을 받아 개발되었습니다. 🙌 <br>

<p> <img width="212" height="267" alt="image" src="https://github.com/user-attachments/assets/59b16b5e-c6ae-4342-a9d0-1e8fe818617f" />
  <img width="209" height="224" alt="image" src="https://github.com/user-attachments/assets/2dd2ecae-f210-4968-bdc1-e91ee73b9168" /> </p>
  <hr>
🔧 Tech Stack <br>
Java 21, Gradle <br>
Spring Boot 3.5.6 <br>
spring-boot-starter-web (JSP) <br>
spring-boot-starter-data-jpa <br>
spring-boot-starter-validation <br>
spring-security-crypto (BCrypt) <br>
<hr>
JSP/JSTL  <br>
org.apache.tomcat.embed:tomcat-embed-jasper,  <br>
jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl   <br> <br>

DB: Oracle (ojdbc11)  <br>
View 엔진: JSP (JSTL/EL)  <br>
포트: 8090  <br>
<hr>
✨ 주요 기능   <br>
게시판  <br>
목록/상세/작성/수정/삭제 (작성·수정·삭제는 로그인 사용자만)    <br>  <br> 
페이지네이션  <br>
검색: 제목/작성자/전체  <br> <br>

사용자  <br>
회원가입 / 로그인 / 로그아웃 (BCrypt 비밀번호 해시)  <br>
마이페이지: 내가 작성한 글 목록  <br> <br>

UX 보조  <br>
로그인 필요 시 알림/이동  <br>
작성/수정/삭제/로그인/로그아웃 후 토스트(모달) 알림 표시(쿼리스트링 기반)  <br> 
