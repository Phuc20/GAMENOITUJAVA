package com.yourcompany.controller;

import com.yourcompany.model.Room;
import com.yourcompany.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class GameController {
    @Autowired
    private RoomService roomService;

    // Xử lý đăng nhập username từ Home hoặc Login (nếu dùng login riêng)
    @PostMapping("/login")
    public String doLogin(@RequestParam String username, HttpSession session) {
        session.setAttribute("username", username.trim());
        return "redirect:/home";
    }

    // Tạo phòng, làm chủ phòng
    @PostMapping("/room/create")
    public String createRoom(HttpSession session) {
        String username = (String) session.getAttribute("username");
        String roomId = roomService.createRoom(username);
        return "redirect:/room/" + roomId;
    }

    // Nhập mã để vào phòng
    @PostMapping("/room/join")
    public String joinRoom(@RequestParam String roomId, HttpSession session, RedirectAttributes redirect) {
        String username = (String) session.getAttribute("username");
        Room room = roomService.joinRoom(roomId.trim().toUpperCase(), username);
        if (room == null) {
            redirect.addFlashAttribute("error", "Không tìm thấy phòng!");
            return "redirect:/home";
        }
        return "redirect:/room/" + roomId.trim().toUpperCase();
    }

    // Trang chơi với người (phòng)
    @GetMapping("/room/{roomId}")
    public String playRoom(@PathVariable String roomId, HttpSession session, Model model, RedirectAttributes redirect) {
        String username = (String) session.getAttribute("username");
        Room room = roomService.getRoom(roomId);
        if (room == null) {
            redirect.addFlashAttribute("error", "Phòng không tồn tại!");
            return "redirect:/home";
        }
        if (!room.getPlayers().contains(username)) {
            redirect.addFlashAttribute("error", "Bạn không thuộc phòng này!");
            return "redirect:/home";
        }
        model.addAttribute("room", room);
        model.addAttribute("username", username);
        model.addAttribute("isYourTurn", room.getPlayers().get(room.getTurnIndex()).equals(username));
        return "play-room";
    }

    // Gửi từ nối chữ
    @PostMapping("/room/{roomId}/play")
    public String playWord(@PathVariable String roomId, @RequestParam String word, HttpSession session, RedirectAttributes redirect) {
        String username = (String) session.getAttribute("username");
        Room room = roomService.getRoom(roomId);
        if (room == null) {
            redirect.addFlashAttribute("error", "Phòng không tồn tại!");
            return "redirect:/home";
        }
        if (!room.getPlayers().get(room.getTurnIndex()).equals(username)) {
            redirect.addFlashAttribute("error", "Không phải lượt của bạn!");
            return "redirect:/room/" + roomId;
        }

        word = word.trim();
        if (!room.getWordHistory().isEmpty()) {
            String lastWord = room.getWordHistory().get(room.getWordHistory().size() - 1);
            if (lastWord.charAt(lastWord.length() - 1) != word.charAt(0)) {
                redirect.addFlashAttribute("error", "Từ phải bắt đầu bằng chữ: " + lastWord.charAt(lastWord.length() - 1));
                return "redirect:/room/" + roomId;
            }
            if (room.getWordHistory().contains(word)) {
                redirect.addFlashAttribute("error", "Từ đã được dùng!");
                return "redirect:/room/" + roomId;
            }
        }
        room.getWordHistory().add(word);
        room.setTurnIndex((room.getTurnIndex() + 1) % 2);
        redirect.addFlashAttribute("success", "Thêm từ thành công!");
        return "redirect:/room/" + roomId;
    }

    @PostMapping("/room/{roomId}/reset")
    public String resetRoom(@PathVariable String roomId, HttpSession session, RedirectAttributes redirect) {
        Room room = roomService.getRoom(roomId);
        if (room != null) {
            room.getWordHistory().clear();
            room.setTurnIndex(0);
            redirect.addFlashAttribute("success", "Đã reset phòng!");
        }
        return "redirect:/room/" + roomId;
    }

    // Chế độ solo chơi với bot (tối giản)
    @GetMapping("/solo")
    public String solo(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null || username.isEmpty()) username = "Khách";
        model.addAttribute("username", username);
        // Có thể thêm xử lý trạng thái solo cho user ở đây
        return "play-bot";
    }

    // Xử lý gửi từ ở chế độ solo (tối giản: bot nối chữ ngẫu nhiên)
    @PostMapping("/solo/play")
    public String soloPlay(@RequestParam String word, HttpSession session, RedirectAttributes redirect) {
        // Lưu lịch sử vào session hoặc service (tối giản: session)
        // ... Xử lý giống như với phòng, thêm từ, kiểm tra hợp lệ, bot trả lời v.v.
        // Tối giản, chỉ demo giao diện
        redirect.addFlashAttribute("success", "Đã gửi từ! (Chế độ demo)");
        return "redirect:/solo";
    }
}