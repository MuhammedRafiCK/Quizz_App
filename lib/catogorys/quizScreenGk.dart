// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/gk.dart';
import '../homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Question {
  String questionText;
  List<Answer> answersList;
  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestion() {
  List<Question> list = [];
  //add questions here
  list.add(Question(
      'Which gas do plants absorb from the atmosphere during photosynthesis?', [
    Answer(" Hydrogen (H2)", false),
    Answer("Carbon dioxide (CO2)", true),
    Answer("Nitrogen (N2)", false),
    Answer("Oxygen (O2)", false),
  ]));
  list.add(Question(' What is the capital of France?', [
    Answer("Paris", true),
    Answer("Berlin", false),
    Answer("London", false),
    Answer("Rome", false),
  ]));
  list.add(Question(' Which planet is known asthe Red Planet?', [
    Answer("Earth", false),
    Answer("Mars", true),
    Answer("Venus", false),
    Answer("Jupiter", false),
  ]));
  list.add(Question('What is the largest mammal in the world?', [
    Answer("Elephant", false),
    Answer("Giraffe", false),
    Answer("Blue Whale", true),
    Answer("Hippopotamus", false),
  ]));
  list.add(Question('Who wrote the famous play Romeo and Juliet?', [
    Answer("Charles Dickens", false),
    Answer("William Shakespeare", true),
    Answer("Jane Austen", false),
    Answer("Leo Tolstoy", false),
  ]));
  return list;
}

class QuizScreenGk extends StatefulWidget {
  const QuizScreenGk({Key? key}) : super(key: key);

  @override
  State<QuizScreenGk> createState() => _QuizScreenGkState();
}

// Define the data

class _QuizScreenGkState extends State<QuizScreenGk> {
  List<Question> questionList = getQuestion();
  // Answer? selectedAnswer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 7, 88, 134),
            Color.fromARGB(255, 5, 25, 27),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_questionWidget(), _answerList(), _nextButton()],
        ),
      ),
    );
  }

  Widget _questionWidget() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<saveScore>(builder: (context, value, child) {
              return Container(
                margin: const EdgeInsets.only(top: 100, left: 25),
                child: Text(
                  " ${value.currentQuestionIndex + 1}.",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              );
            }),
            Consumer<saveScore>(builder: (context, value, child) {
              return Container(
                width: 330,
                margin: const EdgeInsets.only(top: 100),
                decoration: const BoxDecoration(),
                child: Text(
                  questionList[value.currentQuestionIndex].questionText,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _answerList() {
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        child: Consumer<saveScore>(builder: (context, value, child) {
          return Column(
            children: questionList[value.currentQuestionIndex]
                .answersList
                .map(
                  (b) => _answerButton(b),
                )
                .toList(),
          );
        }),
      ),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer ==
        Provider.of<saveScore>(
          context,
        ).selectedAnswer;

    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10),
      child: SizedBox(
        width: 300,
        child: Consumer<saveScore>(builder: (context, data, child) {
          return TextButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(
                  color: Color.fromARGB(255, 141, 145, 148),
                  width: 2.0,
                ),
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed) || isSelected) {
                    // Change the background color to green when the button is pressed
                    return const Color.fromARGB(
                        255, 56, 53, 53); // Replace with your desired color
                  }
                  // Return transparent background color for other states
                  return Colors.transparent;
                },
              ),
            ),
            onPressed: () {
              // Check if an answer is already selected
              if (data.selectedAnswer == null) {
                // Check if the selected answer is correct
                if (answer.isCorrect) {
                  data.score++;
                }
              }
              Provider.of<saveScore>(context, listen: false)
                  .selectedanswer(answer);
            },
            child: Text(
              answer.answerText,
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 25,
              ),
            ),
          );
        }),
      ),
    );
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (Provider.of<saveScore>(context).currentQuestionIndex ==
        questionList.length - 1) {
      isLastQuestion = true;
    }

    return Container(
      margin: const EdgeInsets.only(left: 10, top: 30),
      child: SizedBox(
        width: 300,
        child: Consumer<saveScore>(
          builder: (context, data, child) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 173, 53, 53),
              ),
              onPressed: () {
                if (isLastQuestion) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultScreen(
                              score: data.score,
                              currentQuestionIndex: data.currentQuestionIndex,
                              questionList: [])));
                } else {
                  Provider.of<saveScore>(context, listen: false).scoreIncrese();
                }
              },
              // Check if an answer is already selected

              child: Text(isLastQuestion ? "submit" : "next"),
            );
          },
        ),
      ),
    );
  }
}

// List<int> scoreList = [];

// ignore: must_be_immutable
class ResultScreen extends StatefulWidget {
  int score;
  int currentQuestionIndex;
  List<Question> questionList = getQuestion();

  ResultScreen(
      {super.key,
      required this.score,
      required this.currentQuestionIndex,
      required this.questionList});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    double passingPercentage = 0.6;
    bool isPassed = false;

    if (widget.score >= widget.questionList.length * passingPercentage) {
      isPassed = true;
    }
    saveTimeAndDate();
    Provider.of<saveScore>(context).saveQuizResult();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 130, top: 50),
                  child: Text(
                    "Quiz Result",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 250,
              child: Image.asset(isPassed
                  ? 'assets/images/win.webp'
                  : 'assets/images/lose.jpg'),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Text(
                  'Your Score: ${widget.score}',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
            SizedBox(
              height: 280,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 60,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                      // Provider.of<saveScore>(context, listen: false)
                      //     .clearScore();
                    },
                    child: Text('Back to Home'),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    // Navigate back to the quiz screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreenGk()),
                    );
                    Provider.of<saveScore>(context, listen: false).score = 0;
                    Provider.of<saveScore>(context, listen: false)
                        .currentQuestionIndex = 0;
                  },
                  child: Text('Restart Quiz'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveTimeAndDate() async {
    final now = DateTime.now();

    final prefs = await SharedPreferences.getInstance();
    final storedTimes = prefs.getStringList('storedTimes') ?? [];
    storedTimes.add(now.toString());
    await prefs.setStringList('storedTimes', storedTimes);
  }
}
