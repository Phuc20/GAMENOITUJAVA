<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <style>
        body {
            background: #f1f2f6;
            font-family: Arial, sans-serif;
        }
        .container {
            width: 360px;
            margin: 80px auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 12px #ccc;
            padding: 36px 32px 32px 32px;
        }
        h2 {
            text-align: center;
            color: #0984e3;
        }
        form {
            margin-top: 28px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #636e72;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 8px 10px;
            margin-bottom: 18px;
            border: 1px solid #b2bec3;
            border-radius: 4px;
            font-size: 16px;
        }
        button {
            width: 100%;
            padding: 10px 0;
            background: #0984e3;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 17px;
            cursor: pointer;
        }
        button:hover {
            background: #00b894;
        }
        .error {
            color: #d63031;
            text-align: center;
            margin-top: 15px;
        }
        .register-link {
            display: block;
            text-align: center;
            margin-top: 18px;
            color: #0984e3;
            text-decoration: none;
        }
        .register-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Đăng nhập</h2>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <label for="username">Tên đăng nhập:</label>
        <input type="text" id="username" name="username" required autofocus />

        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" required />

        <!-- CSRF Token cho Spring Security -->
        <c:if test="${not empty _csrf}">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </c:if>

        <button type="submit">Đăng nhập</button>
    </form>
    <a class="register-link" href="${pageContext.request.contextPath}/register">Chưa có tài khoản? Đăng ký</a>
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
</div>
</body>
</html>