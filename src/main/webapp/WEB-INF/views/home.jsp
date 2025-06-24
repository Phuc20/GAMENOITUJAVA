<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Nối Từ Không? - Trò chơi đấu trí từ vựng</title>
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&family=Poppins:wght@500;600&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary: #4361ee;
      --secondary: #3f37c9;
      --accent: #4895ef;
      --light: #f8f9fa;
      --dark: #212529;
      --success: #4cc9f0;
      --danger: #f72585;
      --warning: #f8961e;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      min-height: 100vh;
      margin: 0;
      padding: 0;
      background: linear-gradient(135deg, #4361ee 0%, #3a0ca3 100%);
      font-family: 'Nunito', 'Poppins', Arial, sans-serif;
      color: var(--dark);
      display: flex;
      justify-content: center;
      align-items: center;
      background-image:
        radial-gradient(circle at 10% 20%, rgba(255,255,255,0.1) 0%, transparent 20%),
        radial-gradient(circle at 90% 80%, rgba(255,255,255,0.1) 0%, transparent 20%);
      animation: gradientShift 15s ease infinite;
      background-size: 200% 200%;
    }

    @keyframes gradientShift {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }

    .main-container {
      max-width: 500px;
      width: 95%;
      margin: 20px auto;
      background: rgba(255,255,255,0.97);
      border-radius: 20px;
      box-shadow: 0 15px 40px rgba(0,0,0,0.2);
      padding: 40px 35px;
      text-align: center;
      position: relative;
      overflow: hidden;
      transition: transform 0.3s ease;
    }

    .main-container:hover {
      transform: translateY(-5px);
    }

    .main-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 8px;
      background: linear-gradient(90deg, #4361ee, #4895ef, #4cc9f0);
    }

    .main-title {
      font-family: 'Poppins', sans-serif;
      font-size: 2.5rem;
      color: var(--primary);
      margin-bottom: 20px;
      font-weight: 700;
      position: relative;
      display: inline-block;
    }

    .main-title::after {
      content: '';
      position: absolute;
      bottom: -8px;
      left: 50%;
      transform: translateX(-50%);
      width: 60px;
      height: 4px;
      background: var(--accent);
      border-radius: 2px;
    }

    .img-banner {
      width: 100%;
      max-width: 300px;
      height: auto;
      border-radius: 15px;
      margin: 15px auto 25px;
      box-shadow: 0 10px 20px rgba(67, 97, 238, 0.2);
      transition: transform 0.3s ease;
    }

    .img-banner:hover {
      transform: scale(1.03);
    }

    .score {
      color: var(--secondary);
      font-size: 1.2rem;
      margin: 20px 0;
      font-weight: 600;
      padding: 10px 15px;
      background: rgba(67, 97, 238, 0.1);
      border-radius: 50px;
      display: inline-block;
    }

    .btn {
      display: block;
      width: 100%;
      max-width: 280px;
      margin: 15px auto;
      padding: 15px 25px;
      font-size: 1.1rem;
      font-weight: 600;
      border: none;
      border-radius: 50px;
      cursor: pointer;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .btn-primary {
      background: linear-gradient(135deg, var(--primary), var(--secondary));
      color: white;
    }

    .btn-secondary {
      background: white;
      color: var(--primary);
      border: 2px solid var(--primary);
    }

    .btn:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    }

    .btn-primary:hover {
      background: linear-gradient(135deg, var(--secondary), var(--primary));
    }

    .btn-secondary:hover {
      background: var(--primary);
      color: white;
    }

    .room-form {
      margin: 25px 0;
      display: flex;
      justify-content: center;
      gap: 10px;
      flex-wrap: wrap;
    }

    .room-input {
      padding: 12px 15px;
      font-size: 1rem;
      border: 2px solid #e9ecef;
      border-radius: 50px;
      outline: none;
      width: 180px;
      transition: all 0.3s ease;
      box-shadow: inset 0 2px 5px rgba(0,0,0,0.05);
    }

    .room-input:focus {
      border-color: var(--accent);
      box-shadow: 0 0 0 3px rgba(72, 149, 239, 0.2);
    }

    .sub-label {
      color: #6c757d;
      font-size: 1rem;
      margin: 10px 0;
      position: relative;
      display: inline-block;
    }

    .sub-label::before, .sub-label::after {
      content: '';
      position: absolute;
      top: 50%;
      width: 30px;
      height: 1px;
      background: #dee2e6;
    }

    .sub-label::before {
      left: -40px;
    }

    .sub-label::after {
      right: -40px;
    }

    .divider {
      border: none;
      height: 1px;
      background: linear-gradient(90deg, transparent, #dee2e6, transparent);
      margin: 30px 0;
    }

    .message {
      padding: 12px 15px;
      border-radius: 8px;
      margin: 20px 0;
      font-weight: 500;
      animation: fadeIn 0.5s ease;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .error {
      background-color: rgba(247, 37, 133, 0.1);
      color: var(--danger);
      border-left: 4px solid var(--danger);
    }

    .success {
      background-color: rgba(76, 201, 240, 0.1);
      color: var(--success);
      border-left: 4px solid var(--success);
    }

    @media (max-width: 576px) {
      .main-container {
        padding: 30px 20px;
        border-radius: 15px;
      }

      .main-title {
        font-size: 2rem;
      }

      .room-form {
        flex-direction: column;
        align-items: center;
      }

      .room-input {
        width: 100%;
        max-width: 250px;
      }

      .btn {
        max-width: 250px;
        padding: 12px 20px;
      }
    }
  </style>
</head>
<body>
<div class="main-container">
  <h1 class="main-title">Nối Từ Không?</h1>

  <div class="score">
    <c:if test="${not empty sessionScope.username}">
      Xin chào, <span style="color: var(--secondary);">${sessionScope.username}</span> 👋
    </c:if>
    <c:if test="${empty sessionScope.username}">
      Chào mừng bạn đến với trò chơi! 🎉
    </c:if>
  </div>

  <form action="solo" method="get">
    <button type="submit" class="btn btn-primary">
      <span style="display: inline-block; transform: translateY(2px);">🤖</span> Chơi với Bot
    </button>
  </form>

  <div class="divider"></div>

  <div class="sub-label">Chơi với người khác</div>

  <form action="room/create" method="post">
    <button type="submit" class="btn btn-secondary">
      <span style="display: inline-block; transform: translateY(2px);">🎮</span> Tạo Phòng
    </button>
  </form>

  <form action="room/join" method="post" class="room-form">
    <input type="text" class="room-input" name="roomId" placeholder="Nhập mã phòng" maxlength="8" required />
    <button type="submit" class="btn btn-secondary" style="max-width: 150px;">
      <span style="display: inline-block; transform: translateY(2px);">🚪</span> Vào Phòng
    </button>
  </form>

  <c:if test="${not empty error}">
    <div class="message error">${error}</div>
  </c:if>

  <c:if test="${not empty success}">
    <div class="message success">${success}</div>
  </c:if>
</div>
</body>
</html>
