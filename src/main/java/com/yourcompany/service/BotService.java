package com.yourcompany.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.*;

public class BotService {
    private final List<String> allWords;

    public BotService() {
        this.allWords = loadDictionary();
    }

    private List<String> loadDictionary() {
        List<String> words = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(
                getClass().getClassLoader().getResourceAsStream("dictionary.txt"), StandardCharsets.UTF_8))) {
            String line;
            while ((line = br.readLine()) != null) {
                words.add(line.trim().toLowerCase());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return words;
    }

    // Tìm từ hợp lệ cho bot, nối nguyên cụm từ cuối (1 từ cuối)
    public String generateNextWord(String lastWord, List<String> usedWords) {
        if (lastWord == null || lastWord.isEmpty()) return null;
        String[] parts = lastWord.trim().toLowerCase().split("\\s+");
        String lastGroup = parts[parts.length - 1];

        for (String word : allWords) {
            String[] botParts = word.split("\\s+");
            if (
                    botParts.length > 0 &&
                            botParts[0].equals(lastGroup) && // từ đầu của cụm từ bot phải trùng từ cuối của cụm trước
                            !usedWords.contains(word) &&
                            !word.equalsIgnoreCase(lastWord)
            ) {
                return word;
            }
        }
        return null; // Bot chịu thua!
    }
}