<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chơi với Bot - Game Nối Chữ</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;500;600&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary: blue;
      --primary-light: #E7F4E7;
      --text: #333333;
      --text-light: #666666;
      --bg: #F5F5F5;
      --card: #FFFFFF;
      --border: #DDDDDD;
      --highlight: #F0F7F0;
    }

    body {
      font-family: 'Noto Sans', sans-serif;
      background-color: var(--bg);
      color: var(--text);
      padding: 20px;
      max-width: 500px;
      margin: 0 auto;
    }

    .game-container {
      background: var(--card);
      border-radius: 10px;
      padding: 25px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }

    h1 {
      color: var(--primary);
      text-align: center;
      margin-bottom: 25px;
      font-size: 1.5rem;
      font-weight: 600;
    }

    .score-display {
      background: var(--primary-light);
      color: var(--primary);
      padding: 8px 15px;
      border-radius: 20px;
      display: inline-block;
      margin-bottom: 20px;
      font-weight: 500;
      float: right;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin: 20px 0;
    }

    th, td {
      padding: 12px 10px;
      text-align: center;
      border-bottom: 1px solid var(--border);
    }

    th {
      background: var(--primary-light);
      color: var(--primary);
      font-weight: 500;
    }

    tr:nth-child(even) {
      background-color: var(--highlight);
    }

    .input-area {
      display: flex;
      gap: 10px;
      margin: 25px 0 15px 0;
    }

    input[type="text"] {
      flex: 1;
      padding: 10px 15px;
      border: 1px solid var(--border);
      border-radius: 6px;
      font-size: 1rem;
    }

    button {
      background: var(--primary);
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 500;
      transition: background 0.2s;
    }

    button:hover {
      background: red;
    }

    .reset-btn {
      width: 100%;
      margin-top: 10px;
      background: white;
      color: var(--primary);
      border: 1px solid var(--primary);
    }

    .reset-btn:hover {
      background: var(--primary-light);
    }

    .bot-response {
      margin: 15px 0;
      padding: 12px;
      background: #F8F8F8;
      border-radius: 6px;
      color: var(--text);
      text-align: center;
      font-style: italic;
    }

    .bot-response b {
      color: var(--primary);
      font-style: normal;
    }

    @media (max-width: 480px) {
      .input-area {
        flex-direction: column;
      }

      button {
        width: 100%;
      }
    }
  </style>
</head>
<body>
<div class="game-container">
  <h1>Chơi Nối Chữ với Bot</h1>

  <div class="score-display">
    Điểm: <b>${score}</b>
  </div>

  <table>
    <thead>
    <tr>
      <th>Lượt</th>
      <th>Bạn</th>
      <th>Bot</th>
    </tr>
    </thead>
    <tbody>
    <c:choose>
      <c:when test="${not empty wordHistory}">
        <c:set var="turn" value="1" />
        <c:forEach var="i" begin="0" end="${fn:length(wordHistory) - 1}" step="2">
          <tr>
            <td>${turn}</td>
            <td>${wordHistory[i]}</td>
            <td>
              <c:if test="${i + 1 < fn:length(wordHistory)}">
                ${wordHistory[i + 1]}
              </c:if>
            </td>
          </tr>
          <c:set var="turn" value="${turn + 1}"/>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <tr>
          <td colspan="3" style="color: var(--text-light);">Chưa có từ nào, hãy bắt đầu!</td>
        </tr>
      </c:otherwise>
    </c:choose>
    </tbody>
  </table>

  <form class="input-area" action="play-bot" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <input type="text" name="word" placeholder="Nhập từ của bạn..." required />
    <button type="submit">Gửi</button>
  </form>

  <form action="reset-bot" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <button class="reset-btn" type="submit">Chơi lại</button>
  </form>

  <c:if test="${not empty botWord}">
    <div class="bot-response">
      Bot đã trả lời: <b>${botWord}</b>
    </div>
  </c:if>
</div>
</body>
</html>
