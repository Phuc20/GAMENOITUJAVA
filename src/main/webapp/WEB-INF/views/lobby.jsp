<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Lobby</title>
  <style>
    body {
      background: #f8fafc;
      font-family: 'Segoe UI', Arial, sans-serif;
      color: #222;
      padding: 0;
      margin: 0;
    }

    h2 {
      text-align: center;
      margin-top: 40px;
      color: #3e64ff;
    }

    form {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-top: 25px;
    }

    input[type="text"] {
      padding: 9px 12px;
      border: 1px solid #cfd8dc;
      border-radius: 5px;
      font-size: 16px;
      width: 220px;
      margin-bottom: 8px;
      transition: border-color 0.2s;
    }

    input[type="text"]:focus {
      border-color: #3e64ff;
      outline: none;
    }

    button {
      padding: 8px 20px;
      background: #3e64ff;
      color: #fff;
      border: none;
      border-radius: 5px;
      font-size: 15px;
      cursor: pointer;
      transition: background 0.2s;
      margin-bottom: 7px;
    }

    button:hover {
      background: #244ad6;
    }

    div[style*="color:red"] {
      color: #e53935 !important;
      text-align: center;
      margin-top: 20px;
      font-weight: bold;
    }
  </style>
</head>
<body>
<h2>Chào mừng, ${sessionScope.username}!</h2>
<form action="/room/create" method="post">
  <button type="submit">Tạo phòng mới</button>
</form>
<br>
<form action="/room/join" method="post">
  <input type="text" name="roomId" placeholder="Nhập mã phòng" required />
  <button type="submit">Vào phòng</button>
</form>
<c:if test="${not empty error}">
  <div style="color:red">${error}</div>
</c:if>
</body>
</html>
