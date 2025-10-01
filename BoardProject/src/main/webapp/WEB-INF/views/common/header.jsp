<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<style>
/* === 모달 스타일 (그대로) === */
.modal-backdrop {
	position: fixed;
	inset: 0;
	background: rgba(0, 0, 0, .45);
	display: none;
	z-index: 9998;
}

.modal {
	background: #fff;
	width: 320px;
	max-width: 90vw;
	margin: 15% auto;
	padding: 16px;
	border-radius: 10px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .2);
	z-index: 9999;
}

.modal h4 {
	margin: 0 0 8px;
	font-size: 16px;
}

.modal .actions {
	text-align: right;
	margin-top: 12px;
}

.modal .actions button {
	padding: 6px 12px;
	cursor: pointer;
}

.header-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 16px;
	border-bottom: 1px solid gray;
	margin-bottom: 20px;
}

.header-right {
	display: flex;
	align-items: center;
	gap: 12px;
}

.header-sep {
	color: #999;
}

.header-bar a {
	text-decoration: none;
}

</style>


<div class="header-bar">
	<div class="header-left">
		<a href="/">메인</a>
	</div>
	<div class="header-right">
		<c:choose>
			<c:when test="${empty sessionScope.loginUserId}">
				<a href="/user/login">로그인</a>
				<span class="header-sep">|</span>
				<a href="/user/register">회원가입</a>
			</c:when>
			<c:otherwise>
				<a href="/user/mypage">마이페이지</a>
				<span class="header-sep">|</span>
				<a href="/user/logout">로그아웃</a>
			</c:otherwise>
		</c:choose>
	</div>
</div>


<!-- ✅ 공통 토스트 모달: ?toast=메시지 -->
<c:if test="${not empty param.toast}">
  <div id="toastModal" class="modal-backdrop" style="display:block">
    <div class="modal" role="dialog" aria-modal="true" aria-labelledby="toastTitle">
      <h4 id="toastTitle">알림</h4>
      <div>${fn:escapeXml(param.toast)}</div>
      <div class="actions"><button type="button" onclick="document.getElementById('toastModal').style.display='none'">확인</button></div>
    </div>
  </div>
</c:if>