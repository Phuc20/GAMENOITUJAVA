<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chơi Nối Chữ 2 Người</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f6fa;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 440px;
            margin: 50px auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 12px #ccc;
            padding: 32px 40px 40px 40px;
        }
        h1 {
            color: #2d3436;
            text-align: center;
        }
        .game-history {
            margin: 18px 0 28px 0;
            background: #f1f2f6;
            border-radius: 5px;
            padding: 12px;
            min-height: 44px;
            font-size: 16px;
        }
        .input-form {
            display: flex;
            gap: 8px;
        }
        input[type="text"] {
            flex: 1;
            padding: 8px;
            font-size: 18px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button, input[type="submit"] {
            background: #0984e3;
            color: #fff;
            border: none;
            padding: 9px 18px;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover, input[type="submit"]:hover {
            background: #00b894;
        }
        .error {
            color: #d63031;
            margin-top: 10px;
            text-align: center;
        }
        .success {
            color: #00b894;
            margin-top: 10px;
            text-align: center;
        }
        .reset-btn {
            margin-top: 18px;
            width: 100%;
        }
        .player-turn {
            text-align: center;
            color: #636e72;
            font-style: italic;
            margin-bottom: 14px;
            font-size: 16px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Chơi Nối Chữ 2 Người</h1>
    <div class="player-turn">
        <c:choose>
            <c:when test="${not empty currentPlayer}">
                Đến lượt: <b>${currentPlayer}</b>
            </c:when>
            <c:otherwise>
                Hãy bắt đầu trò chơi!
            </c:otherwise>
        </c:choose>
    </div>
    <div class="game-history">
        <b>Lịch sử từ:</b>
        <c:choose>
            <c:when test="${not empty wordHistory}">
                <c:forEach var="word" items="${wordHistory}" varStatus="status">
                    <span>
                        <c:choose>
                            <c:when test="${not empty playerHistory}">
                                <b>${playerHistory[status.index]}:</b>
                            </c:when>
                            <c:otherwise>
                                <b>Người chơi ${status.index % 2 + 1}:</b>
                            </c:otherwise>
                        </c:choose>
                        ${word}
                    </span>
                    <c:if test="${!status.last}"> &rarr; </c:if>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <em>Chưa có từ nào, hãy bắt đầu!</em>
            </c:otherwise>
        </c:choose>
    </div>

    <form class="input-form" action="play-user" method="post">
        <input type="text" name="word" placeholder="Nhập từ của bạn..." autocomplete="off" required />
        <input type="submit" value="Gửi" />
    </form>

    <form action="reset-user" method="post">
        <button class="reset-btn" type="submit">Chơi lại</button>
    </form>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="success">${success}</div>
    </c:if>
</div>
</body>
</html>