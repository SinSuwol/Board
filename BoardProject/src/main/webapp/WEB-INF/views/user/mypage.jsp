<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head><title>마이페이지</title></head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h2>${username}님의 마이페이지</h2>

<h3>내가 쓴 글</h3>
<table border="1" cellspacing="0" cellpadding="6">
  <tr><th>ID</th><th>제목</th><th>작성일</th></tr>
  <c:forEach var="b" items="${page.content}">
    <tr>
      <td>${b.id}</td>
      <td><a href="/board/${b.id}">${b.title}</a></td>
      <td>
        <c:choose>
          <c:when test="${empty b.createdAtDate}">-</c:when>
          <c:otherwise><fmt:formatDate value="${b.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
        </c:choose>
      </td>
    </tr>
  </c:forEach>
</table>

<c:if test="${page.totalPages > 0}">
  <div style="margin-top:10px">
    <c:set var="curr" value="${page.number}" />
    <c:set var="last" value="${page.totalPages - 1}" />
    <a href="/user/mypage?page=0&size=${size}">처음</a>
    <c:if test="${!page.first}">
      <a href="/user/mypage?page=${curr-1}&size=${size}">이전</a>
    </c:if>
    <span>페이지 ${curr+1} / ${page.totalPages}</span>
    <c:if test="${!page.last}">
      <a href="/user/mypage?page=${curr+1}&size=${size}">다음</a>
    </c:if>
    <a href="/user/mypage?page=${last}&size=${size}">끝</a>
  </div>
</c:if>

</body>
</html>
