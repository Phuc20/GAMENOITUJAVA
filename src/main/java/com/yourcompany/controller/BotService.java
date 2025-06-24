/*
package com.yourcompany.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class BotService {
    private final com.yourcompany.service.BotService botService = new com.yourcompany.service.BotService();

    @GetMapping("/play-bot")
    public String showBotGame(HttpSession session, Model model) {
        List<String> wordHistory = (List<String>) session.getAttribute("botWordHistory");
        if (wordHistory == null) wordHistory = new ArrayList<>();
        model.addAttribute("wordHistory", wordHistory);

        String botWord = (String) session.getAttribute("botWord");
        if (botWord != null) {
            model.addAttribute("botWord", botWord);
            session.removeAttribute("botWord");
        }
        return "play-bot";
    }

    @PostMapping("/play-bot")
    public String playBot(@RequestParam String word, HttpSession session, RedirectAttributes redirect) {
        List<String> wordHistory = (List<String>) session.getAttribute("botWordHistory");
        if (wordHistory == null) wordHistory = new ArrayList<>();

        word = word.trim().toLowerCase();

        // Kiểm tra hợp lệ
        if (!wordHistory.isEmpty()) {
            String lastWord = wordHistory.get(wordHistory.size() - 1);
            if (lastWord.charAt(lastWord.length() - 1) != word.charAt(0)) {
                redirect.addFlashAttribute("error", "Từ bạn nhập phải bắt đầu bằng: " + lastWord.charAt(lastWord.length() - 1));
                return "redirect:/play-bot";
            }
            if (wordHistory.contains(word)) {
                redirect.addFlashAttribute("error", "Từ này đã được dùng!");
                return "redirect:/play-bot";
            }
        }
        wordHistory.add(word);

        // Gọi AI lấy từ cho Bot
        String botWord = botService.generateNextWord(word);

        // Kiểm tra bot trả lời hợp lệ và không trùng
        if (botWord != null && !botWord.isBlank() && !wordHistory.contains(botWord) && !botWord.equalsIgnoreCase(word)) {
            wordHistory.add(botWord);
            session.setAttribute("botWord", botWord);
            redirect.addFlashAttribute("success", "Bot đã trả lời!");
        } else {
            session.setAttribute("botWord", "Bot chịu thua! Bạn thắng rồi!");
            redirect.addFlashAttribute("success", "Bạn thắng rồi! Bot không còn từ phù hợp.");
        }

        session.setAttribute("botWordHistory", wordHistory);
        return "redirect:/play-bot";
    }

    @PostMapping("/reset-bot")
    public String resetBot(HttpSession session) {
        session.removeAttribute("botWordHistory");
        session.removeAttribute("botWord");
        return "redirect:/play-bot";
    }
}

 */