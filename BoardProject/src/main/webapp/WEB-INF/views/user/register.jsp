<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 

<html>
<head>
<title>회원가입</title>
</head>
<body>
	<h2>회원가입</h2>
	<c:if test="${not empty error}">
		<div style="color: red">${error}</div>
	</c:if>
	<form method="post" action="/user/register">
		<div>
			아이디: <input type="text" name="username" required>
		</div>
		<div>
			비밀번호: <input type="password" name="password" required>
		</div>
		<div>
			이름: <input type="text" name="name" required>
		</div>
		<div>
			전화번호: <input type="text" name="phone">
		</div>
		<button type="submit">가입</button>
		<a href="/user/login">로그인</a>
	</form>
</body>
</html>
