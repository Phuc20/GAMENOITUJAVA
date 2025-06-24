package com.yourcompany.model;

import java.util.ArrayList;
import java.util.List;

public class Room {
    private String roomId;
    private List<String> players = new ArrayList<>(); // username
    private List<String> wordHistory = new ArrayList<>();
    private int turnIndex = 0; // 0 hoặc 1

    public Room(String roomId, String creator) {
        this.roomId = roomId;
        this.players.add(creator);
    }

    public String getRoomId() { return roomId; }
    public List<String> getPlayers() { return players; }
    public List<String> getWordHistory() { return wordHistory; }
    public int getTurnIndex() { return turnIndex; }
    public void setTurnIndex(int turnIndex) { this.turnIndex = turnIndex; }
}