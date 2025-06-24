package com.yourcompany.service;

import com.yourcompany.model.Room;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class RoomService {
    // Dùng ConcurrentHashMap để thread-safe cho môi trường nhiều user
    private final Map<String, Room> rooms = new ConcurrentHashMap<>();

    /**
     * Tạo phòng mới với username là người tạo phòng đầu tiên (chủ phòng).
     * Sinh mã phòng 6 ký tự, đảm bảo không trùng.
     * @param username tên người tạo phòng
     * @return roomId
     */
    public String createRoom(String username) {
        String roomId;
        do {
            roomId = UUID.randomUUID().toString().replace("-", "").substring(0, 6).toUpperCase();
        } while (rooms.containsKey(roomId));
        Room room = new Room(roomId, username);
        rooms.put(roomId, room);
        return roomId;
    }

    /**
     * Người chơi tham gia vào phòng với roomId và username.
     * Chỉ cho phép vào nếu phòng còn slot và chưa có username này.
     * @param roomId mã phòng
     * @param username tên người chơi
     * @return Room nếu vào được, null nếu không tồn tại hoặc đã đủ người
     */
    public Room joinRoom(String roomId, String username) {
        Room room = rooms.get(roomId);
        if (room != null && !room.isFull() && !room.getPlayers().contains(username)) {
            room.addPlayer(username);
            return room;
        }
        // Nếu phòng tồn tại và đã có username rồi, vẫn trả về room để hiển thị cho người đã join vào lại (reload trang)
        if (room != null && room.getPlayers().contains(username)) {
            return room;
        }
        // Nếu phòng không tồn tại hoặc đã đủ người thì trả về null
        return null;
    }

    /**
     * Lấy thông tin phòng theo roomId
     */
    public Room getRoom(String roomId) {
        return rooms.get(roomId);
    }

    /**
     * Trả về danh sách tất cả phòng (nếu muốn hiển thị danh sách phòng đang mở)
     */
    public List<Room> getAllRooms() {
        return new ArrayList<>(rooms.values());
    }

    /**
     * Xóa phòng khi không còn ai chơi hoặc phòng kết thúc
     */
    public void removeRoom(String roomId) {
        rooms.remove(roomId);
    }
}