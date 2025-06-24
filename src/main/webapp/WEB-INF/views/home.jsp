<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Nối Từ Không? - Trò chơi đấu trí từ vựng</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Montserrat:wght@600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary: #6C63FF;
      --primary-light: #A5A2FF;
      --primary-dark: #564FD1;
      --secondary: #FF6584;
      --accent: #00C9A7;
      --text: #2D3748;
      --text-light: #718096;
      --bg: #F8FAFF;
      --card: #FFFFFF;
      --border: #E2E8F0;
      --shadow: 0 10px 30px rgba(108, 99, 255, 0.1);
      --gradient: linear-gradient(135deg, #6C63FF 0%, #A5A2FF 100%);
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      background: var(--bg);
      min-height: 100vh;
      font-family: 'Poppins', sans-serif;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      color: var(--text);
      background-image:
        radial-gradient(circle at 10% 20%, rgba(108, 99, 255, 0.05) 0%, transparent 20%),
        radial-gradient(circle at 90% 80%, rgba(255, 101, 132, 0.05) 0%, transparent 20%);
    }

    .main-container {
      max-width: 480px;
      width: 100%;
      background: var(--card);
      border-radius: 24px;
      box-shadow: var(--shadow);
      padding: 48px 40px;
      position: relative;
      overflow: hidden;
      z-index: 1;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .main-container:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 40px rgba(108, 99, 255, 0.15);
    }

    .main-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 8px;
      background: var(--gradient);
    }

    .game-logo {
      width: 100px;
      height: 100px;
      margin: 0 auto 20px;
      display: flex;
      align-items: center;
      justify-content: center;
      background: var(--gradient);
      border-radius: 24px;
      color: white;
      font-size: 2.5rem;
      box-shadow: 0 8px 20px rgba(108, 99, 255, 0.3);
    }

    .main-title {
      font-family: 'Montserrat', sans-serif;
      font-size: 2.5rem;
      font-weight: 700;
      color: var(--primary);
      text-align: center;
      margin-bottom: 8px;
      background: var(--gradient);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      letter-spacing: 1px;
    }

    .welcome-message {
      text-align: center;
      margin-bottom: 32px;
      font-size: 1.1rem;
      color: var(--text-light);
    }

    .welcome-message strong {
      color: var(--primary);
      font-weight: 600;
    }

    .game-mode {
      margin-bottom: 32px;
    }

    .btn {
      display: block;
      width: 100%;
      padding: 16px;
      border-radius: 16px;
      font-size: 1.1rem;
      font-weight: 600;
      text-align: center;
      cursor: pointer;
      transition: all 0.3s ease;
      margin-bottom: 16px;
      border: none;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      position: relative;
      overflow: hidden;
    }

    .btn::after {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(255, 255, 255, 0.1);
      opacity: 0;
      transition: opacity 0.3s ease;
    }

    .btn:hover::after {
      opacity: 1;
    }

    .btn-primary {
      background: var(--gradient);
      color: white;
      box-shadow: 0 5px 15px rgba(108, 99, 255, 0.3);
    }

    .btn-primary:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 25px rgba(108, 99, 255, 0.4);
    }

    .btn-secondary {
      background: white;
      color: var(--primary);
      border: 2px solid var(--primary);
    }

    .btn-secondary:hover {
      background: rgba(108, 99, 255, 0.05);
      transform: translateY(-3px);
    }

    .btn-accent {
      background: linear-gradient(135deg, var(--secondary) 0%, #FF8E9E 100%);
      color: white;
      box-shadow: 0 5px 15px rgba(255, 101, 132, 0.3);
    }

    .btn-accent:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 25px rgba(255, 101, 132, 0.4);
    }

    .divider {
      display: flex;
      align-items: center;
      margin: 32px 0;
      color: var(--text-light);
      font-size: 0.9rem;
    }

    .divider::before, .divider::after {
      content: '';
      flex: 1;
      height: 1px;
      background: var(--border);
      margin: 0 10px;
    }

    .room-form {
      margin-top: 24px;
    }

    .input-group {
      display: flex;
      gap: 10px;
      margin-bottom: 16px;
    }

    .room-input {
      flex: 1;
      padding: 16px 20px;
      border: 2px solid var(--border);
      border-radius: 16px;
      font-size: 1rem;
      outline: none;
      transition: all 0.3s ease;
      background: rgba(255, 255, 255, 0.7);
    }

    .room-input:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.1);
    }

    .message {
      padding: 14px 16px;
      border-radius: 12px;
      margin-top: 20px;
      font-weight: 500;
      animation: fadeIn 0.5s ease;
      border-left: 4px solid transparent;
    }

    .error {
      background-color: rgba(255, 101, 132, 0.1);
      color: var(--secondary);
      border-left-color: var(--secondary);
    }

    .success {
      background-color: rgba(0, 201, 167, 0.1);
      color: var(--accent);
      border-left-color: var(--accent);
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @media (max-width: 520px) {
      .main-container {
        padding: 36px 24px;
        border-radius: 20px;
      }

      .main-title {
        font-size: 2rem;
      }

      .game-logo {
        width: 80px;
        height: 80px;
        font-size: 2rem;
      }

      .btn {
        padding: 14px;
        font-size: 1rem;
      }

      .room-input {
        padding: 14px 16px;
      }
    }
  </style>
</head>
<body>
<div class="main-container">
  <div class="game-logo">
    <i class="fas fa-gamepad"></i>
  </div>

  <h1 class="main-title">Nối Từ Không?</h1>

  <div class="welcome-message">
    <c:choose>
      <c:when test="${not empty sessionScope.username}">
        Xin chào, <strong>${sessionScope.username}</strong>! 👋
      </c:when>
      <c:otherwise>
        Chào mừng bạn đến với <strong>trò chơi nối từ</strong>!
      </c:otherwise>
    </c:choose>
  </div>

  <div class="game-mode">
    <form action="solo" method="get">
      <button type="submit" class="btn btn-primary">
        <i class="fas fa-robot"></i> Chơi với Bot
      </button>
    </form>
  </div>

  <div class="divider">hoặc</div>

  <div class="multiplayer">
    <form action="/room/create" method="post">
      <c:if test="${not empty _csrf}">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      </c:if>
      <button type="submit" class="btn btn-secondary">
        <i class="fas fa-users"></i> Tạo Phòng
      </button>
    </form>

    <div class="room-form">
      <form action="/room/go" method="post">
        <c:if test="${not empty _csrf}">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </c:if>
        <div class="input-group">
          <input type="text" class="room-input" name="roomId" placeholder="Nhập mã phòng" maxlength="8" required />
        </div>
        <button type="submit" class="btn btn-accent">
          <i class="fas fa-door-open"></i> Vào Phòng
        </button>
      </form>
    </div>
  </div>

  <c:if test="${not empty error}">
    <div class="message error">
      <i class="fas fa-exclamation-circle"></i> ${error}
    </div>
  </c:if>

  <c:if test="${not empty success}">
    <div class="message success">
      <i class="fas fa-check-circle"></i> ${success}
    </div>
  </c:if>
</div>

<script>
  // Thêm hiệu ứng khi load trang
  document.addEventListener('DOMContentLoaded', () => {
    const container = document.querySelector('.main-container');
    container.style.opacity = '0';
    container.style.transform = 'translateY(20px)';

    setTimeout(() => {
      container.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
      container.style.opacity = '1';
      container.style.transform = 'translateY(0)';
    }, 100);
  });
</script>
</body>
</html>