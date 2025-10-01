<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>게시글 작성</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<h2>게시글 작성</h2>
	<form method="post" action="/board/write">
		제목: <input type="text" name="title" required><br> 내용:
		<textarea name="content" required></textarea>
		<br>
		<button type="submit">저장</button>
		<a href="/board/list">취소</a>
	</form>
</body>
</html>
