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

    // Đăng nhập xong về home
    @PostMapping("/login")
    public String doLogin(@RequestParam String username, HttpSession session) {
        session.setAttribute("username", username.trim());
        return "redirect:/home";
    }

    // Trang home (sau đăng nhập)
    @GetMapping("/home")
    public String home(HttpSession session, Model model, @ModelAttribute("error") String error) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (error != null && !error.isEmpty()) model.addAttribute("error", error);
        return "home";
    }

    @PostMapping("/room/create")
    public String createRoom(HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null || username.trim().isEmpty()) {
            return "redirect:/home";
        }
        String roomId = roomService.createRoom(username);
        return "redirect:/room/" + roomId;
    }

    // Nhập mã phòng, chuyển thẳng vào phòng chơi nếu thành công
    @PostMapping("/room/go")
    public String goRoom(@RequestParam String roomId, HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null || username.trim().isEmpty()) {
            return "redirect:/home";
        }
        String code = roomId.trim().toUpperCase();
        Room room = roomService.joinRoom(code, username);
        if (room == null) {
            return "redirect:/home"; // Không báo lỗi, chỉ về lại home nếu mã sai hoặc phòng full
        }
        return "redirect:/room/" + code;
    }

    // Trang chơi nối từ (cả 2 người sẽ cùng vào trang này)
    @GetMapping("/room/{roomId}")
    public String playRoom(@PathVariable String roomId, HttpSession session, Model model,
                           @ModelAttribute("error") String error,
                           @ModelAttribute("success") String success) {
        String username = (String) session.getAttribute("username");
        Room room = roomService.getRoom(roomId);
        if (room == null || !room.getPlayers().contains(username)) {
            return "redirect:/home";
        }
        model.addAttribute("room", room);
        model.addAttribute("username", username);
        model.addAttribute("isYourTurn", room.getPlayers().get(room.getTurnIndex()).equals(username));
        model.addAttribute("currentPlayer", room.getPlayers().get(room.getTurnIndex()));
        model.addAttribute("wordHistory", room.getWordHistory());
        if (error != null && !error.isEmpty()) model.addAttribute("error", error);
        if (success != null && !success.isEmpty()) model.addAttribute("success", success);
        return "play-room";
    }

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
        if (word.isEmpty()) {
            redirect.addFlashAttribute("error", "Bạn chưa nhập từ!");
            return "redirect:/room/" + roomId;
        }
        // Dùng hàm kiểm tra của Room
        if (!room.isValidNextPhrase(word)) {
            String lastWord = room.getLastWordOfLastPhrase();
            redirect.addFlashAttribute("error", "Cụm từ phải bắt đầu bằng từ: " + (lastWord != null ? lastWord : "?"));
            return "redirect:/room/" + roomId;
        }
        if (room.isDuplicatePhrase(word)) {
            redirect.addFlashAttribute("error", "Cụm từ này đã được dùng!");
            return "redirect:/room/" + roomId;
        }
        room.addWord(word);
        room.setTurnIndex((room.getTurnIndex() + 1) % room.getMaxPlayers());
        redirect.addFlashAttribute("success", "Thêm từ thành công!");
        return "redirect:/room/" + roomId;
    }

    // Reset lại phòng (xóa lịch sử từ)
    @PostMapping("/room/{roomId}/reset")
    public String resetRoom(@PathVariable String roomId, HttpSession session, RedirectAttributes redirect) {
        Room room = roomService.getRoom(roomId);
        if (room != null) {
            room.clearHistory();
            room.setTurnIndex(0);
            redirect.addFlashAttribute("success", "Đã reset phòng!");
        }
        return "redirect:/room/" + roomId;
    }

    // Chế độ solo (demo)
    @GetMapping("/solo")
    public String solo(HttpSession session, Model model, @ModelAttribute("success") String success) {
        String username = (String) session.getAttribute("username");
        if (username == null || username.isEmpty()) username = "Khách";
        model.addAttribute("username", username);
        if (success != null && !success.isEmpty()) model.addAttribute("success", success);
        return "play-bot";
    }

    @PostMapping("/solo/play")
    public String soloPlay(@RequestParam String word, HttpSession session, RedirectAttributes redirect) {
        redirect.addFlashAttribute("success", "Đã gửi từ! (Chế độ demo)");
        return "redirect:/solo";
    }
}