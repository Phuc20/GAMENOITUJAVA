<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chơi Nối Chữ 2 Người</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4285F4;
            --primary-light: #E8F0FE;
            --primary-dark: #3367D6;
            --secondary: #34A853;
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

        .room-info {
            text-align: center;
            margin-bottom: 20px;
        }

        .room-id {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--primary-light);
            color: var(--primary-dark);
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 500;
            margin-bottom: 8px;
            border: 1px solid var(--border);
        }

        .copy-btn {
            background: var(--secondary);
            color: white;
            border: none;
            padding: 2px 8px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.8rem;
            transition: background 0.2s;
        }

        .copy-btn:hover {
            background: #2D8E47;
        }

        .players-list {
            text-align: center;
            margin-bottom: 20px;
            font-size: 0.95rem;
        }

        .player-turn {
            text-align: center;
            margin-bottom: 20px;
            font-weight: 500;
            color: var(--primary-dark);
        }

        .game-history {
            background: #f6f8fa;
            border-radius: 10px;
            border-left: 4px solid #34A853;
            padding: 18px 16px;
            margin-bottom: 24px;
        }

        .history-table {
            width: 100%;
            border-collapse: collapse;
            background: transparent;
        }
        .history-table thead {
            background: #e3ebfd;
        }
        .history-table th, .history-table td {
            padding: 10px 8px;
            text-align: center;
            font-size: 1rem;
        }
        .history-table th {
            color: var(--primary-dark);
            font-weight: 600;
        }
        .history-table tr:not(:last-child) td {
            border-bottom: 1px solid var(--border);
        }
        .history-table .empty-row td {
            color: #888;
            font-style: italic;
            background: transparent;
        }

        .input-area {
            display: flex;
            gap: 10px;
            margin: 20px 0;
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

        button, input[type="submit"] {
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

        button:hover, input[type="submit"]:hover {
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

        .waiting-message {
            text-align: center;
            color: var(--text-light);
            margin: 20px 0;
            font-style: italic;
        }

        .message {
            padding: 12px;
            border-radius: 6px;
            margin: 15px 0;
            text-align: center;
        }

        .error {
            background-color: rgba(234, 67, 53, 0.1);
            color: var(--error);
            border-left: 4px solid var(--error);
        }

        .success {
            background-color: rgba(52, 168, 83, 0.1);
            color: var(--secondary);
            border-left: 4px solid var(--secondary);
        }

        @media (max-width: 480px) {
            .game-container {
                padding: 20px 15px;
            }

            .input-area {
                flex-direction: column;
            }

            button, input[type="submit"] {
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

    <h1>Chơi Nối Chữ 2 Người</h1>

    <div class="room-info">
        <div class="room-id">
            Mã phòng: <span id="roomId">${room.roomId}</span>
            <button class="copy-btn" onclick="copyRoomId()">Copy</button>
        </div>
        <small style="color: var(--text-light);">(Gửi mã phòng này cho bạn để cùng chơi!)</small>
    </div>

    <div class="players-list" id="players-box">
        <b>Người trong phòng:</b>
        <c:forEach var="player" items="${room.players}" varStatus="status">
            <span style="color: ${player == username ? 'var(--secondary)' : 'var(--text)'};">
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

    <!-- Lịch sử từ dạng bảng -->
    <div class="game-history" id="history-box">
        <table class="history-table">
            <thead>
            <tr>
                <th>Lượt</th>
                <th>
                    <c:choose>
                        <c:when test="${not empty room.players[0]}">
                            ${room.players[0]}
                        </c:when>
                        <c:otherwise>Người 1</c:otherwise>
                    </c:choose>
                </th>
                <th>
                    <c:choose>
                        <c:when test="${not empty room.players[1]}">
                            ${room.players[1]}
                        </c:when>
                        <c:otherwise>Người 2</c:otherwise>
                    </c:choose>
                </th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty wordHistory}">
                    <c:forEach var="i" begin="0" end="${fn:length(wordHistory) - 1}" step="2" varStatus="stt">
                        <tr>
                            <td>${stt.index + 1}</td>
                            <td>
                                <c:if test="${i < fn:length(wordHistory)}">${wordHistory[i]}</c:if>
                            </td>
                            <td>
                                <c:if test="${i + 1 < fn:length(wordHistory)}">${wordHistory[i + 1]}</c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr class="empty-row">
                        <td colspan="3">Chưa có từ nào, hãy bắt đầu!</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

    <form class="input-area" id="word-form" action="/room/${room.roomId}/play" method="post" style="<c:if test='${!isYourTurn}'>display:none;</c:if>">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="text" name="word" id="word-input" placeholder="Nhập từ của bạn..." autocomplete="off" required />
        <input type="submit" id="submit-btn" value="Gửi" />
    </form>

    <div class="waiting-message" id="wait-box" style="<c:if test='${isYourTurn}'>display:none;</c:if>">
        Đang chờ người chơi khác...
    </div>

    <form action="/room/${room.roomId}/reset" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <button class="reset-btn" type="submit">Chơi lại</button>
    </form>

    <c:if test="${not empty error}">
        <div class="message error" id="error-box">${error}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="message success" id="success-box">${success}</div>
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
                    (data.players[i] === username ? "var(--secondary)" : "var(--text)") + ";'>" +
                    data.players[i] + (data.players[i] === username ? " (Bạn)" : "") + "</span>";
                if (i < data.players.length - 1) playersHtml += " - ";
            }
            document.getElementById("players-box").innerHTML = playersHtml;

            // Cập nhật lượt chơi
            document.getElementById("current-player-box").innerHTML =
                "Đến lượt: <b>" + data.players[data.turnIndex] + "</b>";

            // Cập nhật lịch sử từ
            let table = '<table class="history-table"><thead><tr>' +
                '<th>Lượt</th>' +
                '<th>' + (data.players[0] || "Người 1") + '</th>' +
                '<th>' + (data.players[1] || "Người 2") + '</th>' +
                '</tr></thead><tbody>';
            if (data.wordHistory.length > 0) {
                for (let i = 0, turn = 1; i < data.wordHistory.length; i += 2, turn++) {
                    table += '<tr><td>' + turn + '</td>';
                    table += '<td>' + (data.wordHistory[i] ? data.wordHistory[i] : '') + '</td>';
                    table += '<td>' + (data.wordHistory[i+1] ? data.wordHistory[i+1] : '') + '</td></tr>';
                }
            } else {
                table += '<tr class="empty-row"><td colspan="3">Chưa có từ nào, hãy bắt đầu!</td></tr>';
            }
            table += '</tbody></table>';
            document.getElementById("history-box").innerHTML = table;

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
setInterval(reloadRoomData, 8000); // Cập nhật mỗi 5 giây
</script>
</body>
</html>