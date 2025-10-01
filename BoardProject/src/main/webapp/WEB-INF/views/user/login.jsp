<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  

<html>
<head>
<title>로그인</title>
</head>
<body>
	<h2>로그인</h2>
	<c:if test="${not empty error}">
		<div style="color: red">${error}</div>
	</c:if>
	<form method="post" action="/user/login">
		<div>
			아이디: <input type="text" name="username" required>
		</div>
		<div>
			비밀번호: <input type="password" name="password" required>
		</div>
		<button type="submit">로그인</button>
		<a href="/user/register">회원가입</a>
	</form>
</body>
</html>
