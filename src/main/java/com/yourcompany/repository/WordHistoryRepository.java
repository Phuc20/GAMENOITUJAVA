package com.yourcompany.repository;

import java.util.ArrayList;
import java.util.List;

/**
 * Repository lưu lịch sử các từ đã chơi trong game nối chữ.
 * Có thể mở rộng lưu trữ vào database nếu cần.
 */
public class WordHistoryRepository {
    private List<String> wordHistory = new ArrayList<>();

    public void addWord(String word) {
        wordHistory.add(word);
    }

    public List<String> getAllWords() {
        return new ArrayList<>(wordHistory);
    }

    public void clearHistory() {
        wordHistory.clear();
    }
}