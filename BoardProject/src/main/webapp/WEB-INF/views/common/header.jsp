<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<style>
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
</style>

<div
	style="margin-bottom: 20px; border-bottom: 1px solid gray; padding: 10px;">
	<a href="/">메인</a> |
	<c:choose>
		<c:when test="${empty sessionScope.loginUserId}">
			<a href="/user/login">로그인</a> | <a href="/user/register">회원가입</a>
		</c:when>
		<c:otherwise>
			<a href="/user/mypage">마이페이지</a> | <a href="/user/logout">로그아웃</a>
		</c:otherwise>
	</c:choose>

	<!-- 로그아웃/토스트 모달 -->
	<c:if test="${not empty toast || param.logout == '1'}">
		<div id="toastModal" class="modal-backdrop" style="display: block">
			<div class="modal" role="dialog" aria-modal="true"
				aria-labelledby="toastTitle">
				<h4 id="toastTitle">알림</h4>
				<div>${not empty toast ? toast : '로그아웃 되었습니다.'}</div>
				<div class="actions">
					<button type="button" onclick="closeToast()">확인</button>
				</div>
			</div>
		</div>
		<script>
			function closeToast() {
				document.getElementById('toastModal').style.display = 'none';
			}
			// 2초 후 자동 닫기 원하면 주석 해제
			//setTimeout(closeToast, 2000);
		</script>
	</c:if>
</div>
