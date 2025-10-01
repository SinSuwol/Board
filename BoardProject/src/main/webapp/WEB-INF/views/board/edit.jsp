<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>게시글 수정</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<h2>게시글 수정</h2>
	<form method="post" action="/board/edit/${board.id}">
		제목: <input type="text" name="title" value="${board.title}" required><br>
		내용:
		<textarea name="content" required>${board.content}</textarea>
		<br>
		<button type="submit">저장</button>
		<a href="/board/${board.id}">취소</a>
	</form>
</body>
</html>
