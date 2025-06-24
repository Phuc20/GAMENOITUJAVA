package com.yourcompany.service;

import com.yourcompany.model.Room;
import org.springframework.stereotype.Service;
import java.util.*;

@Service
public class RoomService {
    private Map<String, Room> rooms = new HashMap<>();

    public String createRoom(String username) {
        String roomId = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
        Room room = new Room(roomId, username);
        rooms.put(roomId, room);
        return roomId;
    }

    public Room joinRoom(String roomId, String username) {
        Room room = rooms.get(roomId);
        if (room != null && room.getPlayers().size() < 2 && !room.getPlayers().contains(username)) {
            room.getPlayers().add(username);
        }
        return room;
    }

    public Room getRoom(String roomId) {
        return rooms.get(roomId);
    }
}