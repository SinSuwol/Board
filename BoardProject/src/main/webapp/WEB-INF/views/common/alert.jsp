<%@ page contentType="text/html; charset=UTF-8" %>
<%
  String msg = (String) request.getAttribute("msg");
  String url = (String) request.getAttribute("redirectUrl");
%>
<script>
  alert("<%= msg == null ? "" : msg %>");
  location.href = "<%= url == null ? "/" : url %>";
</script>
