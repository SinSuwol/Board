<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>게시글 상세</title>
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
	max-width: 900px;
	margin: 24px auto;
	padding: 0 16px;
}

.card {
	background: var(--card);
	border: 1px solid var(--line);
	border-radius: 14px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, .06);
	overflow: hidden
}

.card-head {
	padding: 18px 20px;
	border-bottom: 1px solid var(--line)
}

.title {
	margin: 0;
	font-size: 22px;
	font-weight: 800
}

.meta {
	display: flex;
	gap: 14px;
	color: var(--muted);
	margin-top: 6px;
	font-size: 13px
}

.card-body {
	padding: 20px
}

.content {
	line-height: 1.8;
	font-size: 15px
}

.card-foot {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 14px 16px;
	border-top: 1px solid var(--line);
	background: #fafafa
}

.btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 6px;
	padding: 9px 14px;
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

.btn-primary {
	background: var(--brand);
	color: #fff;
	border-color: var(--brand)
}

.btn-danger {
	background: #fff;
	color: var(--danger);
	border-color: #f1b3b3
}

.btn-danger:hover {
	border-color: var(--danger)
}

.breadcrumbs {
	margin-bottom: 10px;
	color: var(--muted);
	font-size: 13px
}

.breadcrumbs a {
	color: inherit
}

.spacer {
	flex: 1
}

form.inline {
	display: inline
}

/* 댓글 영역 */
.cmt-wrap {
	margin-top: 18px
}

.cmt-title {
	margin: 0 0 8px;
	font-size: 16px;
	font-weight: 800
}

.cmt-list {
	list-style: none;
	padding: 0;
	margin: 0
}

.cmt-item {
	border: 1px solid var(--line);
	border-radius: 12px;
	padding: 12px;
	margin: 10px 0;
	background: #fff
}

.cmt-meta {
	font-size: 12px;
	color: var(--muted)
}

.cmt-content {
	margin-top: 6px;
}

.cmt-actions {
	margin-top: 8px;
	text-align: right
}

.cmt-form {
	margin-top: 12px;
	border-top: 1px solid var(--line);
	padding-top: 12px
}

.cmt-textarea {
	width: 100%;
	min-height: 100px;
	padding: 10px;
	border: 1px solid var(--line);
	border-radius: 10px
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container">
		<div class="breadcrumbs">
			<a href="/">메인</a> &raquo; <a href="/board/list">게시판</a> &raquo; 상세
		</div>

		<div class="card">
			<div class="card-head">
				<h1 class="title">
					<c:out value="${board.title}" />
				</h1>
				<div class="meta">
					<span>작성자: <strong><c:out value="${board.writer}" /></strong></span>
					<span> 작성일: <c:choose>
							<c:when test="${empty board.createdAtDate}">-</c:when>
							<c:otherwise>
								<fmt:formatDate value="${board.createdAtDate}"
									pattern="yyyy-MM-dd HH:mm" />
							</c:otherwise>
						</c:choose>
					</span>
				</div>
			</div>

			<div class="card-body">
				<div class="content">
					<c:out value="${board.content}" />
				</div>

				<!-- ================= 댓글 영역 ================= -->
				<div class="cmt-wrap">
					<h3 class="cmt-title">댓글</h3>

					<c:choose>
						<c:when test="${empty comments}">
							<div class="cmt-item"
								style="text-align: center; color: var(--muted)">등록된 댓글이
								없습니다.</div>
						</c:when>
						<c:otherwise>
							<ul class="cmt-list">
								<c:forEach var="cmt" items="${comments}">
									<li class="cmt-item">
										<div class="cmt-meta">
											<strong><c:out value="${cmt.writer}" /></strong> ·
											<c:choose>
												<c:when test="${empty cmt.createdAtDate}">-</c:when>
												<c:otherwise>
													<fmt:formatDate value="${cmt.createdAtDate}"
														pattern="yyyy-MM-dd HH:mm" />
												</c:otherwise>
											</c:choose>
										</div>
										<div class="cmt-content">
											<c:out value="${cmt.content}" />
										</div> <c:if test="${sessionScope.loginUsername == cmt.writer}">
											<div class="cmt-actions">
												<form method="post" action="/comment/delete/${cmt.id}"
													class="inline"
													onsubmit="return confirm('이 댓글을 삭제하시겠습니까?');">
													<input type="hidden" name="boardId" value="${board.id}" />
													<button type="submit" class="btn btn-danger">댓글 삭제</button>
												</form>
											</div>
										</c:if>
									</li>
								</c:forEach>
							</ul>
						</c:otherwise>
					</c:choose>

					<!-- 댓글 작성 폼 -->
					<div class="cmt-form">
						<c:choose>
							<c:when test="${empty sessionScope.loginUserId}">
								<a href="#"
									onclick="if(confirm('로그인이 필요한 서비스입니다.\n지금 로그인하시겠어요?')) location.href='/user/login'; return false;">댓글
									작성</a>
							</c:when>
							<c:otherwise>
								<form method="post" action="/comment/add">
									<input type="hidden" name="boardId" value="${board.id}" />
									<textarea name="content" class="cmt-textarea" required
										placeholder="댓글을 입력하세요"></textarea>
									<div style="margin-top: 8px; text-align: right">
										<button type="submit" class="btn btn-primary">댓글 등록</button>
									</div>
								</form>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<!-- =============== /댓글 영역 =============== -->
			</div>

			<div class="card-foot">
				<div>
					<a href="/board/list" class="btn">목록</a>
				</div>

				<div class="spacer"></div>

				<c:if test="${sessionScope.loginUsername == board.writer}">
					<div>
						<a href="/board/edit/${board.id}" class="btn">수정</a>
						<form method="post" action="/board/delete/${board.id}"
							class="inline" onsubmit="return confirm('삭제하시겠습니까?');">
							<button type="submit" class="btn btn-danger">삭제</button>
						</form>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>
