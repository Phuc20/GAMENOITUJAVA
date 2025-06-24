package com.yourcompany.model;

import java.util.ArrayList;
import java.util.List;

public class WordChainGame {
    private List<String> words;      // Danh sách các từ đã chơi
    private boolean isGameOver;

    public WordChainGame() {
        this.words = new ArrayList<>();
        this.isGameOver = false;
    }

    public List<String> getWords() {
        return words;
    }

    public boolean isGameOver() {
        return isGameOver;
    }

    // Thêm từ mới vào chuỗi
    public boolean addWord(String word) {
        if (word == null || word.trim().isEmpty()) return false;

        word = word.trim().toLowerCase();

        if (words.isEmpty()) {
            words.add(word);
            return true;
        }

        String lastWord = words.get(words.size() - 1);
        if (word.charAt(0) == lastWord.charAt(lastWord.length() - 1) && !words.contains(word)) {
            words.add(word);
            return true;
        } else {
            isGameOver = true;
            return false;
        }
    }

    // Lấy từ cuối cùng
    public String getLastWord() {
        if (words.isEmpty()) return null;
        return words.get(words.size() - 1);
    }

    // Reset lại game
    public void reset() {
        words.clear();
        isGameOver = false;
    }
}