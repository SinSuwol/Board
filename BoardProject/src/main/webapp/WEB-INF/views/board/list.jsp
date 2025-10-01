<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<html>
<head>
<title>게시판</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<h2>게시판 목록</h2>

	<!-- 검색 폼 -->
	<form method="get" action="/board/list" style="margin-bottom: 10px">
		<select name="type">
			<option value="all" ${type == 'all'   ? 'selected' : ''}>전체</option>
			<option value="title" ${type == 'title' ? 'selected' : ''}>제목</option>
			<option value="writer" ${type == 'writer'? 'selected' : ''}>작성자</option>
		</select> <input type="text" name="keyword" value="${keyword}"
			placeholder="검색어"> <input type="hidden" name="size"
			value="${size}" />
		<button type="submit">검색</button>
	</form>

	<c:choose>
		<c:when test="${empty sessionScope.loginUserId}">
			<a href="#" onclick="return needLogin();">글쓰기</a>
		</c:when>
		<c:otherwise>
			<a href="/board/write">글쓰기</a>
		</c:otherwise>
	</c:choose>

	<table border="1" cellspacing="0" cellpadding="6"
		style="margin-top: 10px">
		<tr>
			<th>ID</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<c:forEach var="b" items="${page.content}">
			<tr>
				<td>${b.id}</td>
				<td><a href="/board/${b.id}">${b.title}</a></td>
				<td>${b.writer}</td>
				<td><c:choose>
						<c:when test="${empty b.createdAtDate}">-</c:when>
						<c:otherwise>
							<fmt:formatDate value="${b.createdAtDate}"
								pattern="yyyy-MM-dd HH:mm" />
						</c:otherwise>
					</c:choose></td>
			</tr>
		</c:forEach>
	</table>

	<!-- 페이지네이션 -->
	<c:if test="${page.totalPages > 0}">
		<div style="margin-top: 10px">
			<c:set var="curr" value="${page.number}" />
			<c:set var="last" value="${page.totalPages - 1}" />
			<a
				href="/board/list?page=0&size=${size}&type=${type}&keyword=${keyword}">처음</a>
			<c:if test="${!page.first}">
				<a
					href="/board/list?page=${curr-1}&size=${size}&type=${type}&keyword=${keyword}">이전</a>
			</c:if>
			<span>페이지 ${curr+1} / ${page.totalPages}</span>
			<c:if test="${!page.last}">
				<a
					href="/board/list?page=${curr+1}&size=${size}&type=${type}&keyword=${keyword}">다음</a>
			</c:if>
			<a
				href="/board/list?page=${last}&size=${size}&type=${type}&keyword=${keyword}">끝</a>
		</div>
	</c:if>
	
	<script>
		function needLogin() {
			if (confirm('로그인이 필요한 서비스입니다.\n지금 로그인하시겠어요?')) {
				location.href = '/user/login';
			}
			return false; // 링크 기본동작 막기
		}
	</script>
</body>
</html>

