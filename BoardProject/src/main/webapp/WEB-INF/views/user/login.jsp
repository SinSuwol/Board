<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>로그인</title>
  <style>
    :root{
      --bg:#f7f8fa; --card:#fff; --text:#1f2937; --muted:#6b7280;
      --line:#e5e7eb; --brand:#2563eb; --danger:#dc2626;
    }
    *{box-sizing:border-box}
    body{margin:0; background:var(--bg); color:var(--text);
         font:14px/1.6 system-ui,-apple-system,Segoe UI,Roboto,'Noto Sans KR',sans-serif;}
    a{color:var(--brand); text-decoration:none}
    a:hover{text-decoration:underline}

    .wrap{min-height:100vh; display:flex; align-items:center; justify-content:center; padding:24px}
    .card{width:100%; max-width:420px; background:var(--card); border:1px solid var(--line);
          border-radius:14px; box-shadow:0 8px 24px rgba(0,0,0,.06)}
    .card-head{padding:20px 22px; border-bottom:1px solid var(--line)}
    .title{margin:0; font-size:20px; font-weight:800}
    .card-body{padding:22px}

    .form-row{margin-bottom:14px}
    .label{display:block; margin:0 0 6px; font-weight:700; font-size:13px}
    .input{
      width:100%; padding:11px 12px; border:1px solid var(--line); border-radius:10px;
      background:#fff; outline:none; transition:border-color .15s ease;
    }
    .input:focus{border-color:var(--brand)}

    .actions{display:flex; align-items:center; justify-content:space-between; gap:10px; margin-top:6px}
    .btn{
      display:inline-flex; align-items:center; justify-content:center; gap:6px;
      padding:10px 14px; border-radius:10px; border:1px solid var(--line); background:#fff;
      font-weight:700; cursor:pointer; transition:all .15s ease;
    }
    .btn:hover{transform:translateY(-1px); box-shadow:0 6px 18px rgba(0,0,0,.06)}
    .btn-primary{background:var(--brand); color:#fff; border-color:var(--brand)}
    .subtle{color:var(--muted); font-size:12px}

    .error{margin:-4px 0 12px; color:var(--danger); font-weight:700}
    .helper{margin-top:10px}
  </style>
</head>
<body>
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <div class="wrap">
    <div class="card">
      <div class="card-head">
        <h1 class="title">로그인</h1>
      </div>

      <div class="card-body">
        <c:if test="${not empty error}">
          <div class="error">${error}</div>
        </c:if>

        <form method="post" action="/user/login" autocomplete="on">
          <div class="form-row">
            <label class="label" for="username">아이디</label>
            <input class="input" id="username" type="text" name="username" required autofocus />
          </div>

          <div class="form-row">
            <label class="label" for="password">비밀번호</label>
            <input class="input" id="password" type="password" name="password" required />
          </div>

          <div class="actions">
            <button type="submit" class="btn btn-primary">로그인</button>
            <a href="/user/register" class="btn">회원가입</a>
          </div>

          <div class="helper subtle">
            · 비밀번호는 대소문자를 구분합니다.
          </div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>
