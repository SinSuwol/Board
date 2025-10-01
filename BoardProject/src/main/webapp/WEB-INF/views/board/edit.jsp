<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>게시글 수정</title>
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

    .container{max-width:900px; margin:24px auto; padding:0 16px;}
    .card{background:var(--card); border:1px solid var(--line); border-radius:14px;
          box-shadow:0 8px 24px rgba(0,0,0,.06); overflow:hidden}
    .card-head{padding:18px 20px; border-bottom:1px solid var(--line)}
    .title{margin:0; font-size:20px; font-weight:800}
    .card-body{padding:20px}

    .form-row{margin-bottom:14px}
    .label{display:block; margin:0 0 6px; font-weight:700; font-size:13px}
    .input, .textarea{
      width:100%; padding:11px 12px; border:1px solid var(--line); border-radius:10px;
      background:#fff; outline:none; transition:border-color .15s ease, box-shadow .15s ease;
      font:inherit; color:inherit;
    }
    .input:focus, .textarea:focus{
      border-color:var(--brand); box-shadow:0 0 0 3px rgba(37,99,235,.12);
    }
    .textarea{min-height:280px; resize:vertical; line-height:1.7}

    .card-foot{display:flex; justify-content:space-between; align-items:center;
               padding:14px 16px; border-top:1px solid var(--line); background:#fafafa}
    .btn{
      display:inline-flex; align-items:center; justify-content:center; gap:6px;
      padding:10px 14px; border-radius:10px; border:1px solid var(--line); background:#fff;
      font-weight:700; cursor:pointer; transition:all .15s ease; text-decoration:none; color:var(--text)
    }
    .btn:hover{transform:translateY(-1px); box-shadow:0 6px 18px rgba(0,0,0,.06)}
    .btn-primary{background:var(--brand); color:#fff; border-color:var(--brand)}
    .btn-muted{background:#fff}
  </style>
</head>
<body>
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <div class="container">
    <div class="card">
      <div class="card-head">
        <h1 class="title">게시글 수정</h1>
      </div>

      <form method="post" action="/board/edit/${board.id}">
        <div class="card-body">
          <div class="form-row">
            <label class="label" for="title">제목</label>
            <input class="input" id="title" type="text" name="title" value="${board.title}" required autofocus />
          </div>

          <div class="form-row">
            <label class="label" for="content">내용</label>
            <textarea class="textarea" id="content" name="content" required>${board.content}</textarea>
          </div>
        </div>

        <div class="card-foot">
          <a href="/board/${board.id}" class="btn btn-muted">취소</a>
          <button type="submit" class="btn btn-primary">저장</button>
        </div>
      </form>
    </div>
  </div>
</body>
</html>
