package com.yourcompany.model;

import java.util.*;

public class Room {
    public enum Status { WAITING, PLAYING, FINISHED }

    private final String roomId;
    private final List<String> players = new ArrayList<>();           // Danh sách người chơi, tối đa 2
    private final List<String> wordHistory = new ArrayList<>();       // Lịch sử các từ đã chơi
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
            // Đủ 2 người thì bắt đầu chơi
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

    // Thêm từ vào lịch sử (và cập nhật trạng thái)
    public void addWord(String word) {
        wordHistory.add(word);
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
}