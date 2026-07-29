import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/qr_item.dart';

class HistoryService {
  static const String _key = 'qr_history_items_v1';

  // Add a new item to history
  static Future<void> addItem(QRItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final List<QRItem> history = await getHistory();

    // Insert at the beginning so the newest item appears on top
    history.insert(0, item);

    final String encodedData = jsonEncode(
      history.map((e) => e.toJson()).toList(),
    );
    await prefs.setString(_key, encodedData);
  }

  // Retrieve all saved items
  static Future<List<QRItem>> getHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? encodedData = prefs.getString(_key);
      if (encodedData == null || encodedData.isEmpty) return [];

      final List<dynamic> decodedData = jsonDecode(encodedData);
      return decodedData.map((e) => QRItem.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  // Delete a specific item by index
  static Future<void> removeItemAt(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final List<QRItem> history = await getHistory();
    if (index >= 0 && index < history.length) {
      history.removeAt(index);
      final String encodedData = jsonEncode(
        history.map((e) => e.toJson()).toList(),
      );
      await prefs.setString(_key, encodedData);
    }
  }

  // Clear all history
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  // تم ربطها بـ addItem عشان الحفظ يشتغل صح
  static Future<void> saveHistory(QRItem newItem) async {
    await addItem(newItem);
  }
}