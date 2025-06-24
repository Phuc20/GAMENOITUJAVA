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
      --primary: #4285F4; /* Màu xanh Google */
      --primary-light: #E8F0FE;
      --primary-dark: #3367D6;
      --secondary: #34A853; /* Màu xanh lá */
      --text: #202124;
      --text-light: #5F6368;
      --bg: #F8F9FA;
      --card: #FFFFFF;
      --border: #DADCE0;
      --highlight: #F1F3F4;
      --error: #EA4335;
    }

    body {
      font-family: 'Noto Sans', sans-serif;
      background-color: var(--bg);
      color: var(--text);
      padding: 20px;
      max-width: 500px;
      margin: 0 auto;
      line-height: 1.5;
    }

    .game-container {
      background: var(--card);
      border-radius: 12px;
      padding: 25px;
      box-shadow: 0 1px 2px rgba(60,64,67,0.1), 0 2px 6px rgba(60,64,67,0.15);
      position: relative;
    }

    .back-btn {
      position: absolute;
      top: 20px;
      left: 20px;
      background: none;
      border: none;
      color: var(--primary);
      font-size: 0.95rem;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 6px;
      padding: 6px 10px;
      border-radius: 4px;
      transition: background 0.2s;
    }

    .back-btn:hover {
      background: var(--primary-light);
    }

    .back-btn svg {
      width: 18px;
      height: 18px;
    }

    h1 {
      color: var(--text);
      text-align: center;
      margin: 10px 0 25px;
      font-size: 1.5rem;
      font-weight: 600;
    }

    .score-display {
      background: var(--primary-light);
      color: var(--primary-dark);
      padding: 8px 16px;
      border-radius: 20px;
      display: inline-block;
      margin-bottom: 20px;
      font-weight: 500;
      float: right;
      font-size: 0.95rem;
      border: 1px solid var(--border);
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin: 20px 0;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    }

    th, td {
      padding: 12px 10px;
      text-align: center;
      border: 1px solid var(--border);
    }

    th {
      background: var(--primary-light);
      color: var(--primary-dark);
      font-weight: 500;
      font-size: 0.9rem;
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
      padding: 12px 16px;
      border: 1px solid var(--border);
      border-radius: 8px;
      font-size: 1rem;
      transition: border 0.2s, box-shadow 0.2s;
    }

    input[type="text"]:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 2px rgba(66,133,244,0.2);
      outline: none;
    }

    button {
      background: var(--primary);
      color: white;
      border: none;
      padding: 12px 20px;
      border-radius: 8px;
      cursor: pointer;
      font-weight: 500;
      transition: background 0.2s, transform 0.1s;
      font-size: 0.95rem;
    }

    button:hover {
      background: var(--primary-dark);
      transform: translateY(-1px);
    }

    button:active {
      transform: translateY(0);
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
      padding: 14px;
      background: var(--highlight);
      border-radius: 8px;
      color: var(--text);
      text-align: center;
      font-style: italic;
      border-left: 4px solid var(--secondary);
    }

    .bot-response b {
      color: var(--secondary);
      font-style: normal;
    }

    .empty-state {
      color: var(--text-light);
      text-align: center;
      padding: 20px;
    }

    @media (max-width: 480px) {
      .game-container {
        padding: 20px 15px;
      }

      .input-area {
        flex-direction: column;
      }

      button {
        width: 100%;
      }

      .back-btn {
        top: 15px;
        left: 15px;
      }
    }
  </style>
</head>
<body>
<div class="game-container">
  <!-- Nút quay lại trang chủ -->
  <button class="back-btn" onclick="window.location.href='home'">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
      <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/>
    </svg>
    Trang chủ
  </button>

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
          <td colspan="3" class="empty-state">Chưa có từ nào, hãy bắt đầu!</td>
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