<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
<title>게시글 상세</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<h2>${board.title}</h2>
	<div>작성자: ${board.writer}</div>
	<div>작성일: ${board.createdAt}</div>
	<hr>
	<div style="white-space: pre-wrap">${board.content}</div>
	<hr>
	<a href="/board/list">목록</a>

	<c:if test="${sessionScope.loginUsername == board.writer}">
  | <a href="/board/edit/${board.id}">수정</a>
  | <form method="post" action="/board/delete/${board.id}"
			style="display: inline">
			<button type="submit" onclick="return confirm('삭제하시겠습니까?')">삭제</button>
		</form>
	</c:if>
</body>
</html>
