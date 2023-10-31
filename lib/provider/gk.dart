import 'package:flutter/material.dart';
import 'package:quiz_app/catogorys/quizScreenGk.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class saveScore extends ChangeNotifier {
  int score = 0;
  int currentQuestionIndex = 0;
  Answer? selectedAnswer;
  List<int> userScores = [];


  //SHARED PREFERANCE

  Future<void> saveQuizResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userScoresString = prefs.getString('user_scores');

    if (userScoresString != null) {
      userScores =
          userScoresString.split(',').map((s) => int.tryParse(s) ?? 0).toList();
    }  
    userScores.add(score);
    

    prefs.setString('user_scores', userScores.join(','));
    // ignore: avoid_print
    print(userScores);
  }

  Future<void> getUserScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userScoresString = prefs.getString('user_scores');
    //prefs.clear();
    if (userScoresString != null) {
      userScores =
          userScoresString.split(',').map((s) => int.tryParse(s) ?? 0).toList();
    }
  }

  saveScore() {
    getUserScores();
    notifyListeners();
  }
 
 //CLEAR SHARED PREFERANCE


  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_scores'); // Replace 'user_scores' with the key you used to store the data
    userScores.clear();
    notifyListeners(); // Clear the userScores list
  }

  void selectedanswer(Answer answer) {
    selectedAnswer = answer;
    notifyListeners();
  }

  void scoreIncrese() {
    selectedAnswer = null;
    currentQuestionIndex++;
    notifyListeners();
  }

//CLEAR SCORE AFTER PLAYING

  void clearScore() {
    score = 0;
    notifyListeners();
  }
}
