// ignore: file_names
import 'package:flutter/material.dart';
import 'package:quiz_app/catogorys/quizScreenScience.dart';
import 'package:shared_preferences/shared_preferences.dart';
//SCIENCE SHARED PREFERANCE

class SaveScoreScience extends ChangeNotifier {
  List<int> userScoresScience = [];
  int scoreScience = 0;
  int currentQuestionIndexScience = 0;
  Answer? selectedAnswerScience;

  Future<void> saveQuizResultScience() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userScoresScienceString = prefs.getString('user_scores_science');

    if (userScoresScienceString != null) {
      userScoresScience = userScoresScienceString
          .split(',')
          .map((s) => int.tryParse(s) ?? 0)
          .toList();
    }
    userScoresScience.add(scoreScience);

    prefs.setString('user_scores_science', userScoresScience.join(','));
    print(userScoresScience);
  }

  Future<void> getUserScoresScience() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userScoresScienceString = prefs.getString('user_scores_science');

    if (userScoresScienceString != null) {
      userScoresScience = userScoresScienceString
          .split(',')
          .map((s) => int.tryParse(s) ?? 0)
          .toList();
    }
  }

  SaveScoreScience() {
    getUserScoresScience();
    notifyListeners();
  }

    Future<void> clearSharedPreferencesScience() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'user_scores_science'); // Replace 'user_scores' with the key you used to store the data
    userScoresScience.clear();
    notifyListeners(); // Clear the userScores list
  }
  clearScoreScience() {
    scoreScience = 0;
    notifyListeners();
  }
    void selectedanswerScience(Answer answer) {
    selectedAnswerScience = answer;
    notifyListeners();
  }

  void scoreIncreseScience() {
    selectedAnswerScience = null;
    currentQuestionIndexScience++;
    notifyListeners();
  }
}
