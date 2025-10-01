<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>마이페이지</title>
</head>
<body>
	<h2>마이페이지</h2>
	<div>아이디: ${username}</div>
	<div>이름: ${name}</div>
	<form method="post" action="/user/logout">
		<button type="submit">로그아웃</button>
	</form>
</body>
</html>
