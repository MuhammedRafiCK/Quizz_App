import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeAndDate extends ChangeNotifier {
  List<String> storedTimes = [];
  Future<void> saveTimeAndDate() async {
    final now = DateTime.now();

    final prefs = await SharedPreferences.getInstance();
    final storedTimes = prefs.getStringList('storedTimes') ?? [];
    storedTimes.add(now.toString());
    await prefs.setStringList('storedTimes', storedTimes);
  }

  Future<void> loadStoredTimes() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTimesList = prefs.getStringList('storedTimes');
    //await prefs.clear();
    storedTimes = storedTimesList ?? [];
  }

  TimeAndDate() {
    loadStoredTimes();
    notifyListeners();
  }
}
