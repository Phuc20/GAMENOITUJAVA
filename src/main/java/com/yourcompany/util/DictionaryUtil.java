package com.yourcompany.util;

import java.util.HashSet;
import java.util.Set;

/**
 * Utility class để kiểm tra tính hợp lệ của từ (có trong từ điển hay không).
 * Có thể mở rộng để đọc từ file, database, hoặc tích hợp API từ điển.
 */
public class DictionaryUtil {
    private static final Set<String> DICTIONARY = new HashSet<>();

    static {
        // Demo: Thêm một số từ vào "từ điển" tạm thời
        DICTIONARY.add("apple");
        DICTIONARY.add("elephant");
        DICTIONARY.add("tree");
        DICTIONARY.add("egg");
        DICTIONARY.add("goat");
        DICTIONARY.add("tiger");
        // ... thêm nhiều từ khác hoặc load từ file/resources nếu muốn
    }

    /**
     * Kiểm tra từ có trong từ điển không.
     */
    public static boolean isValidWord(String word) {
        if (word == null) return false;
        return DICTIONARY.contains(word.trim().toLowerCase());
    }

    /**
     * Thêm từ mới vào từ điển (nếu cần).
     */
    public static void addWord(String word) {
        if (word != null && !word.trim().isEmpty()) {
            DICTIONARY.add(word.trim().toLowerCase());
        }
    }

    /**
     * Lấy toàn bộ danh sách từ trong từ điển.
     */
    public static Set<String> getAllWords() {
        return new HashSet<>(DICTIONARY);
    }
}