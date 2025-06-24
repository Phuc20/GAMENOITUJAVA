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
        .room-id {
            text-align: center;
            font-size: 15px;
            color: #636e72;
            margin-bottom: 15px;
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
        .players-list {
            text-align: center;
            font-size: 15px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Chơi Nối Chữ 2 Người</h1>
    <div class="room-id">
        Mã phòng: <b id="roomId">${room.roomId}</b>
        <button onclick="copyRoomId()" style="margin-left:8px;padding:2px 8px;border:none;background:#00b894;color:#fff;border-radius:3px;cursor:pointer;">Copy</button>
        <br/>
        <small>(Gửi mã phòng này cho bạn để cùng chơi!)</small>
    </div>

    <div class="players-list" id="players-box">
        <b>Người trong phòng:</b>
        <c:forEach var="player" items="${room.players}" varStatus="status">
            <span style="color: ${player == username ? '#00b894' : '#636e72'};">
                <c:choose>
                    <c:when test="${player == username}">
                        ${player} (Bạn)
                    </c:when>
                    <c:otherwise>
                        ${player}
                    </c:otherwise>
                </c:choose>
            </span>
            <c:if test="${!status.last}"> - </c:if>
        </c:forEach>
    </div>

    <div class="player-turn" id="current-player-box">
        <c:choose>
            <c:when test="${not empty currentPlayer}">
                Đến lượt: <b>${currentPlayer}</b>
            </c:when>
            <c:otherwise>
                Hãy bắt đầu trò chơi!
            </c:otherwise>
        </c:choose>
    </div>
    <div class="game-history" id="history-box">
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

    <form class="input-form" id="word-form" action="/room/${room.roomId}/play" method="post" style="<c:if test='${!isYourTurn}'>display:none;</c:if>">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="text" name="word" id="word-input" placeholder="Nhập từ của bạn..." autocomplete="off" required />
        <input type="submit" id="submit-btn" value="Gửi" />
    </form>
    <div id="wait-box" style="text-align:center;color:#636e72;margin:16px 0;<c:if test='${isYourTurn}'>display:none;</c:if>">
        Đang chờ người chơi khác...
    </div>

    <form action="/room/${room.roomId}/reset" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <button class="reset-btn" type="submit">Chơi lại</button>
    </form>

    <c:if test="${not empty error}">
        <div class="error" id="error-box">${error}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="success" id="success-box">${success}</div>
    </c:if>
</div>
<script>
function copyRoomId() {
    const roomId = document.getElementById("roomId").innerText;
    navigator.clipboard.writeText(roomId);
    alert("Đã copy mã phòng: " + roomId);
}

let username = "${username}";
function reloadRoomData() {
    fetch("/room/${room.roomId}/status")
        .then(response => response.json())
        .then(data => {
            // Cập nhật danh sách người chơi
            let playersHtml = "<b>Người trong phòng:</b> ";
            for (let i = 0; i < data.players.length; i++) {
                playersHtml += "<span style='color:" +
                    (data.players[i] === username ? "#00b894" : "#636e72") + ";'>" +
                    data.players[i] + (data.players[i] === username ? " (Bạn)" : "") + "</span>";
                if (i < data.players.length - 1) playersHtml += " - ";
            }
            document.getElementById("players-box").innerHTML = playersHtml;

            // Cập nhật lượt chơi
            document.getElementById("current-player-box").innerHTML = "Đến lượt: <b>" + data.players[data.turnIndex] + "</b>";

            // Cập nhật lịch sử từ
            let historyHtml = "<b>Lịch sử từ:</b> ";
            if (data.wordHistory.length > 0) {
                for (let i = 0; i < data.wordHistory.length; i++) {
                    historyHtml += "<span>";
                    if (data.players) {
                        historyHtml += "<b>" + data.players[i % 2] + ":</b> ";
                    } else {
                        historyHtml += "<b>Người chơi " + (i % 2 + 1) + ":</b> ";
                    }
                    historyHtml += data.wordHistory[i] + "</span>";
                    if (i < data.wordHistory.length - 1) historyHtml += " &rarr; ";
                }
            } else {
                historyHtml += "<em>Chưa có từ nào, hãy bắt đầu!</em>";
            }
            document.getElementById("history-box").innerHTML = historyHtml;

            // Hiển thị/ẩn form nhập từ và box chờ
            let isYourTurn = data.players[data.turnIndex] === username;
            document.getElementById("word-form").style.display = isYourTurn ? "flex" : "none";
            document.getElementById("wait-box").style.display = isYourTurn ? "none" : "block";
            // Reset input khi tới lượt mình
            if (isYourTurn) {
                document.getElementById("word-input").value = "";
                document.getElementById("word-input").focus();
            }
        });
}
setInterval(reloadRoomData, 10000);
</script>
</body>
</html>