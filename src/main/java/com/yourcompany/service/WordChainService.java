package com.yourcompany.service;

import com.yourcompany.model.WordChainGame;
import com.yourcompany.repository.WordHistoryRepository;

import java.util.List;

/**
 * Service xử lý logic cho game nối chữ (Word Chain).
 */
public class WordChainService {
    private final WordChainGame game;
    private final WordHistoryRepository wordHistoryRepository;

    public WordChainService(WordChainGame game, WordHistoryRepository wordHistoryRepository) {
        this.game = game;
        this.wordHistoryRepository = wordHistoryRepository;
    }

    // Thêm từ mới vào game và lưu lịch sử
    public boolean addWord(String word) {
        boolean result = game.addWord(word);
        if (result) {
            wordHistoryRepository.addWord(word);
        }
        return result;
    }

    // Lấy danh sách các từ đã chơi
    public List<String> getWordHistory() {
        return wordHistoryRepository.getAllWords();
    }

    // Lấy từ cuối cùng trong chuỗi
    public String getLastWord() {
        return game.getLastWord();
    }

    // Kiểm tra game đã kết thúc chưa
    public boolean isGameOver() {
        return game.isGameOver();
    }

    // Bắt đầu lại game
    public void resetGame() {
        game.reset();
        wordHistoryRepository.clearHistory();
    }
}