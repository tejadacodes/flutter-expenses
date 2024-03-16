import 'package:expenses/models/expense.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageManager {
  static const _key = 'expensesListKey';

  // Save the list to local storage
  static Future<void> saveList(List<Expense> myList) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> serializedList = myList.map((obj) => jsonEncode(obj.toMap())).toList();
    await prefs.setStringList(_key, serializedList);
  }

  // Retrieve the list from local storage
  static Future<List<Expense>> getList() async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.remove(_key);
    final List<String>? serializedList = prefs.getStringList(_key);
    if (serializedList != null) {
      return serializedList.map((item) => Expense.fromMap(jsonDecode(item))).toList();
    } else {
      return [];
    }
  }
}

