<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>마이페이지</title>
<style>
:root {
	--bg: #f7f8fa;
	--card: #fff;
	--text: #1f2937;
	--muted: #6b7280;
	--line: #e5e7eb;
	--brand: #2563eb;
	--danger: #dc2626;
}

* {
	box-sizing: border-box
}

body {
	margin: 0;
	background: var(--bg);
	color: var(--text);
	font: 14px/1.6 system-ui, -apple-system, Segoe UI, Roboto,
		'Noto Sans KR', sans-serif;
}

a {
	color: var(--brand);
	text-decoration: none
}

a:hover {
	text-decoration: underline
}

.container {
	max-width: 1000px;
	margin: 24px auto;
	padding: 0 16px
}

.page-title {
	margin: 0 0 12px;
	font-size: 22px;
	font-weight: 800
}

.sub {
	color: var(--muted);
	margin: 0 0 16px
}

.card {
	background: var(--card);
	border: 1px solid var(--line);
	border-radius: 14px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, .06);
	overflow: hidden
}

.card-head {
	padding: 16px 18px;
	border-bottom: 1px solid var(--line)
}

.card-title {
	margin: 0;
	font-size: 18px;
	font-weight: 800
}

.card-body {
	padding: 18px
}

.table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0;
	overflow: hidden;
	border: 1px solid var(--line);
	border-radius: 12px;
}

.table th, .table td {
	padding: 10px 12px;
	text-align: left;
	border-bottom: 1px solid var(--line)
}

.table th {
	background: #fafafa;
	font-weight: 800
}

.table tr:last-child td {
	border-bottom: none
}

.empty {
	padding: 22px;
	text-align: center;
	color: var(--muted)
}

.pager {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-top: 14px
}

.btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 6px;
	padding: 8px 12px;
	border-radius: 10px;
	border: 1px solid var(--line);
	background: #fff;
	font-weight: 700;
	cursor: pointer;
	transition: all .15s ease;
	text-decoration: none;
	color: var(--text)
}

.btn:hover {
	transform: translateY(-1px);
	box-shadow: 0 6px 18px rgba(0, 0, 0, .06)
}

.btn[aria-disabled="true"] {
	opacity: .45;
	pointer-events: none
}

.page-info {
	color: var(--muted)
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container">
		<h1 class="page-title">${username}님의마이페이지</h1>
		<p class="sub">내가 작성한 게시글 목록입니다.</p>

		<div class="card">
			<div class="card-head">
				<h2 class="card-title">내가 쓴 글</h2>
			</div>
			<div class="card-body">
				<c:choose>
					<c:when test="${empty page || page.totalElements == 0}">
						<div class="empty">작성한 글이 없습니다.</div>
					</c:when>
					<c:otherwise>
						<table class="table">
							<thead>
								<tr>
									<th style="width: 80px">ID</th>
									<th>제목</th>
									<th style="width: 180px">작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="b" items="${page.content}">
									<tr>
										<td>${b.id}</td>
										<td><a href="/board/${b.id}">${b.title}</a></td>
										<td><c:choose>
												<c:when test="${empty b.createdAtDate}">-</c:when>
												<c:otherwise>
													<fmt:formatDate value="${b.createdAtDate}"
														pattern="yyyy-MM-dd HH:mm" />
												</c:otherwise>
											</c:choose></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<!-- 페이지네이션 -->
						<div class="pager">
							<c:set var="curr" value="${page.number}" />
							<c:set var="last" value="${page.totalPages - 1}" />

							<a class="btn" href="/user/mypage?page=0&size=${size}">처음</a> <a
								class="btn" href="/user/mypage?page=${curr-1}&size=${size}"
								aria-disabled="${page.first}">이전</a> <span class="page-info">페이지
								${curr+1} / ${page.totalPages}</span> <a class="btn"
								href="/user/mypage?page=${curr+1}&size=${size}"
								aria-disabled="${page.last}">다음</a> <a class="btn"
								href="/user/mypage?page=${last}&size=${size}">끝</a>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</body>
</html>
