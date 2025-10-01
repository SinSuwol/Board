<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>게시판</title>
<style>
:root {
	--bg: #f7f8fa;
	--card: #ffffff;
	--text: #1f2937;
	--muted: #6b7280;
	--line: #e5e7eb;
	--brand: #2563eb;
	--brand-quiet: #eff6ff;
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
	padding: 0 16px;
}

.card {
	background: var(--card);
	border: 1px solid var(--line);
	border-radius: 12px;
	box-shadow: 0 1px 2px rgba(0, 0, 0, .03)
}

.card-head {
	display: flex;
	gap: 12px;
	align-items: center;
	justify-content: space-between;
	padding: 16px 20px;
	border-bottom: 1px solid var(--line)
}

.title {
	margin: 0;
	font-size: 20px;
	font-weight: 700
}

.muted {
	color: var(--muted)
}

.toolbar {
	display: flex;
	flex-wrap: wrap;
	gap: 8px;
	align-items: center
}

.search {
	display: flex;
	gap: 8px;
	align-items: center
}

select, input[type="text"] {
	border: 1px solid var(--line);
	background: #fff;
	color: var(--text);
	border-radius: 10px;
	padding: 10px 12px;
	outline: none;
}

input[type="text"] {
	width: 220px
}

.btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 6px;
	border-radius: 10px;
	padding: 10px 14px;
	border: 1px solid var(--line);
	background: #fff;
	cursor: pointer;
	transition: all .15s ease;
	text-decoration: none;
	font-weight: 600;
}

.btn:hover {
	transform: translateY(-1px);
	box-shadow: 0 2px 10px rgba(0, 0, 0, .05)
}

.btn-primary {
	background: var(--brand);
	color: #fff;
	border-color: var(--brand)
}

.btn-ghost {
	background: transparent
}

.btn:disabled {
	opacity: .6;
	cursor: not-allowed
}

.table-wrap {
	overflow: auto
}

table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0
}

th, td {
	padding: 12px 14px;
	border-bottom: 1px solid var(--line);
	text-align: left;
	white-space: nowrap
}

th {
	font-size: 12px;
	letter-spacing: .02em;
	color: var(--muted);
	text-transform: uppercase
}

tbody tr:hover {
	background: var(--brand-quiet)
}

td.title-cell a {
	font-weight: 600;
	color: var(--text)
}

td.title-cell a:hover {
	color: var(--brand)
}

.table-foot {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px 16px
}

.pagination {
	display: flex;
	gap: 6px;
	align-items: center
}

.page-link {
	padding: 8px 12px;
	border: 1px solid var(--line);
	border-radius: 8px;
	background: #fff;
	color: var(--text);
	text-decoration: none;
}

.page-link.active {
	background: var(--brand);
	color: #fff;
	border-color: var(--brand)
}

.page-link.disabled {
	pointer-events: none;
	opacity: .5
}

@media ( max-width :640px) {
	input[type="text"] {
		width: 140px
	}
	.title {
		font-size: 18px
	}
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container">
		<div class="card">
			<!-- 상단 바 -->
			<div class="card-head">
				<h2 class="title">게시판 목록</h2>

				<!-- 검색/글쓰기 툴바 -->
				<div class="toolbar">
					<form class="search" method="get" action="/board/list">
						<select name="type" aria-label="검색 유형">
							<option value="all" ${type == 'all'   ? 'selected' : ''}>전체</option>
							<option value="title" ${type == 'title' ? 'selected' : ''}>제목</option>
							<option value="writer" ${type == 'writer'? 'selected' : ''}>작성자</option>
						</select> <input type="text" name="keyword" value="${keyword}"
							placeholder="검색어" /> <input type="hidden" name="size"
							value="${size}" />
						<button type="submit" class="btn btn-ghost">검색</button>
					</form>

					<c:choose>
						<c:when test="${empty sessionScope.loginUserId}">
							<a href="#" class="btn btn-primary" onclick="return needLogin();">글쓰기</a>
						</c:when>
						<c:otherwise>
							<a href="/board/write" class="btn btn-primary">글쓰기</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<!-- 테이블 -->
			<div class="table-wrap">
				<table>
					<thead>
						<tr>
							<th style="width: 80px">ID</th>
							<th>제목</th>
							<th style="width: 140px">작성자</th>
							<th style="width: 180px">작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="b" items="${page.content}">
							<tr>
								<td>${b.id}</td>
								<td class="title-cell"><a href="/board/${b.id}">${b.title}</a></td>
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
						<c:if test="${empty page.content}">
							<tr>
								<td colspan="4" class="muted">표시할 게시물이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>

			<!-- 하단 / 페이지네이션 -->
			<div class="table-foot">
				<div class="muted">총 ${page.totalElements}건 · 페이지
					${page.number + 1} / ${page.totalPages}</div>
				<c:if test="${page.totalPages > 0}">
					<div class="pagination">
						<!-- 처음 / 이전 -->
						<a class="page-link ${page.first ? 'disabled' : ''}"
							href="/board/list?page=0&size=${size}&type=${type}&keyword=${keyword}">처음</a>
						<a class="page-link ${page.first ? 'disabled' : ''}"
							href="/board/list?page=${page.number-1}&size=${size}&type=${type}&keyword=${keyword}">이전</a>

						<!-- 현재 근처 페이지만 간단히 노출 -->
						<c:set var="start"
							value="${page.number - 2 < 0 ? 0 : page.number - 2}" />
						<c:set var="end"
							value="${start + 4 > page.totalPages - 1 ? page.totalPages - 1 : start + 4}" />
						<c:forEach var="i" begin="${start}" end="${end}">
							<a class="page-link ${i == page.number ? 'active' : ''}"
								href="/board/list?page=${i}&size=${size}&type=${type}&keyword=${keyword}">
								${i + 1} </a>
						</c:forEach>

						<!-- 다음 / 끝 -->
						<a class="page-link ${page.last ? 'disabled' : ''}"
							href="/board/list?page=${page.number+1}&size=${size}&type=${type}&keyword=${keyword}">다음</a>
						<a class="page-link ${page.last ? 'disabled' : ''}"
							href="/board/list?page=${page.totalPages-1}&size=${size}&type=${type}&keyword=${keyword}">끝</a>
					</div>
				</c:if>
			</div>
		</div>
	</div>

	<script>
		function needLogin() {
			if (confirm('로그인이 필요한 서비스입니다.\n지금 로그인하시겠어요?')) {
				location.href = '/user/login';
			}
			return false;
		}
	</script>
</body>
</html>
