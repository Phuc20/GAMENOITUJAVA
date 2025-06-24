package com.yourcompany.model;

import java.util.*;

public class Room {
    public enum Status { WAITING, PLAYING, FINISHED }

    private final String roomId;
    private final List<String> players = new ArrayList<>();           // Danh sách người chơi, tối đa 2
    private final List<String> wordHistory = new ArrayList<>();       // Lịch sử các cụm từ đã chơi
    private int turnIndex = 0;                                        // Chỉ số người đến lượt (0 hoặc 1)
    private final int maxPlayers = 2;
    private Status status = Status.WAITING;
    private long lastActive = System.currentTimeMillis();
    private final Map<String, Integer> playerScores = new HashMap<>();// Điểm số từng người chơi

    // Khởi tạo phòng với chủ phòng (creator) là người đầu tiên
    public Room(String roomId, String creator) {
        this.roomId = roomId;
        this.players.add(creator);
        this.playerScores.put(creator, 0);
        this.status = Status.WAITING;
        updateLastActive();
    }

    public String getRoomId() { return roomId; }
    public List<String> getPlayers() { return players; }
    public List<String> getWordHistory() { return wordHistory; }
    public int getTurnIndex() { return turnIndex; }
    public void setTurnIndex(int turnIndex) { this.turnIndex = turnIndex; }
    public int getMaxPlayers() { return maxPlayers; }
    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }
    public long getLastActive() { return lastActive; }
    public void updateLastActive() { this.lastActive = System.currentTimeMillis(); }
    public Map<String, Integer> getPlayerScores() { return playerScores; }

    // Thêm người chơi, trả về true nếu thành công (phòng chưa full, chưa có user này)
    public boolean addPlayer(String username) {
        if (!isFull() && !players.contains(username)) {
            players.add(username);
            playerScores.put(username, 0);
            updateLastActive();
            // Đủ 2 người thì chuyển sang trạng thái PLAYING
            if (players.size() == maxPlayers) {
                status = Status.PLAYING;
            }
            return true;
        }
        return false;
    }

    // Xóa người chơi khỏi phòng
    public boolean removePlayer(String username) {
        playerScores.remove(username);
        boolean removed = players.remove(username);
        updateLastActive();
        if (players.size() < maxPlayers) status = Status.WAITING;
        return removed;
    }

    // Kiểm tra phòng đã đủ 2 người chưa
    public boolean isFull() { return players.size() >= maxPlayers; }

    // Thêm cụm từ vào lịch sử (và cập nhật trạng thái)
    public void addWord(String phrase) {
        wordHistory.add(phrase.trim());
        updateLastActive();
    }

    // Xóa toàn bộ lịch sử từ, reset lượt, trạng thái về WAITING nếu chưa đủ người
    public void clearHistory() {
        wordHistory.clear();
        setTurnIndex(0);
        updateLastActive();
    }

    // Thêm điểm cho người chơi
    public void addScore(String username, int score) {
        playerScores.put(username, playerScores.getOrDefault(username, 0) + score);
        updateLastActive();
    }

    // Lấy điểm của người chơi
    public int getScore(String username) {
        return playerScores.getOrDefault(username, 0);
    }

    // ----------------- LOGIC NỐI CỤM TỪ -----------------

    // Lấy từ cuối cùng của cụm trước (ví dụ: "ăn cơm" => "cơm")
    public String getLastWordOfLastPhrase() {
        if (wordHistory.isEmpty()) return null;
        String lastPhrase = wordHistory.get(wordHistory.size() - 1).trim();
        if (lastPhrase.isEmpty()) return null;
        String[] words = lastPhrase.split("\\s+");
        return words[words.length - 1].toLowerCase();
    }

    // Kiểm tra hợp lệ nối cụm từ (từ đầu của cụm mới == từ cuối của cụm trước)
    public boolean isValidNextPhrase(String newPhrase) {
        String lastWord = getLastWordOfLastPhrase();
        if (lastWord == null) return true; // Lượt đầu tiên
        if (newPhrase == null || newPhrase.trim().isEmpty()) return false;
        String[] newWords = newPhrase.trim().split("\\s+");
        return newWords[0].equalsIgnoreCase(lastWord);
    }

    // Kiểm tra trùng cụm từ trong lịch sử
    public boolean isDuplicatePhrase(String phrase) {
        return wordHistory.stream().anyMatch(w -> w.equalsIgnoreCase(phrase.trim()));
    }
}