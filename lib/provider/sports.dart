import 'package:flutter/material.dart';
import 'package:quiz_app/catogorys/quizScreenSports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class saveScoreSports extends ChangeNotifier {
  List<int> userScoresSports = [];
    int currentQuestionNumber = 0;
  Answer? selectedAnswers;
  int mark = 0;

  Future<void> saveQuizResultSports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userScoresSportsString = prefs.getString('user_scores_sports');

    if (userScoresSportsString != null) {
      userScoresSports = userScoresSportsString
          .split(',')
          .map((s) => int.tryParse(s) ?? 0)
          .toList();
    }
    userScoresSports.add(mark);

    prefs.setString('user_scores_sports', userScoresSports.join(','));
    print(userScoresSports);
  }

  Future<void> getUserScoresSports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userScoresSportsString = prefs.getString('user_scores_sports');

    // await prefs.clear();
    if (userScoresSportsString != null) {
      userScoresSports = userScoresSportsString
          .split(',')
          .map((s) => int.tryParse(s) ?? 0)
          .toList();
    }
  }

  saveScoreSports() {
    getUserScoresSports();
    notifyListeners();
  }

  Future<void> clearSharedPreferencesSports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'user_scores_sports'); // Replace 'user_scores' with the key you used to store the data
    userScoresSports.clear();
    notifyListeners(); // Clear the userScores list
  }

  void clearScoreSports() {
    mark = 0;
    notifyListeners();
  }

  
  void selectedanswerSports(Answer answer) {
    selectedAnswers = answer;
    notifyListeners();
  }

  void scoreIncreseSports() {
    selectedAnswers = null;
    currentQuestionNumber++;
    notifyListeners();
  }
}
