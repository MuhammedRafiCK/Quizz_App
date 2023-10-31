import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/science.dart';
import '../homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Question {
  final String questionText;
  final List<Answer> answersList;

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
  list.add(Question('What is the chemical symbol for gold?', [
    Answer("Go", false),
    Answer("Au", true),
    Answer("Gd", false),
    Answer("Ag", false),
  ]));
  list.add(Question('Which planet is known as the "Red Planet"?', [
    Answer("Mars", true),
    Answer("Jupiter", false),
    Answer("Saturn", false),
    Answer("Venus", false),
  ]));
  list.add(Question(
      'What is the process by which plants make their own food using sunlight?',
      [
        Answer("Respiration", false),
        Answer("Photosynthesis", true),
        Answer("Fermentation", false),
        Answer("Fermentation", false),
      ]));
  list.add(Question(
      ' What is the smallest unit of matter that retains the properties of an element?',
      [
        Answer("Molecule  ", false),
        Answer("Proton", false),
        Answer("Atom ", true),
        Answer("Neutron", false),
      ]));
  list.add(Question(' What force causes an apple to fall to the ground?', [
    Answer("Electromagnetic  force", false),
    Answer("Gravitational force", true),
    Answer("Nuclear force", false),
    Answer("Frictional force", false),
  ]));
  return list;
}

// List<int> scoreListScience = [];

class QuizScreenScience extends StatefulWidget {
  const QuizScreenScience({super.key});

  @override
  State<QuizScreenScience> createState() => _QuizScreenScienceState();
}

class _QuizScreenScienceState extends State<QuizScreenScience> {
  List<Question> questionList = getQuestion();

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
            Consumer<SaveScoreScience>(builder: (context, value, child) {
              return Container(
                margin: const EdgeInsets.only(top: 100, left: 25),
                child: Text(
                  " ${value.currentQuestionIndexScience + 1}.",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              );
            }),
            Consumer<SaveScoreScience>(builder: (context, value, child) {
              return Container(
                width: 330,
                margin: const EdgeInsets.only(top: 100),
                decoration: const BoxDecoration(),
                child: Text(
                  questionList[value.currentQuestionIndexScience].questionText,
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
      child: Consumer<SaveScoreScience>(builder: (context, value, child) {
        return Container(
          margin: const EdgeInsets.only(top: 40),
          child: Column(
            children: questionList[value.currentQuestionIndexScience]
                .answersList
                .map(
                  (b) => _answerButton(b),
                )
                .toList(),
          ),
        );
      }),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected =
        answer == Provider.of<SaveScoreScience>(context).selectedAnswerScience;

    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10),
      child: SizedBox(
        width: 300,
        child:
            Consumer<SaveScoreScience>(builder: (context, dataScience, child) {
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
              if (dataScience.selectedAnswerScience == null) {
                // Check if the selected answer is correct
                if (answer.isCorrect) {
                  dataScience.scoreScience++;
                }
              }
              Provider.of<SaveScoreScience>(context, listen: false)
                  .selectedanswerScience(answer);
            },
            child: Text(
              answer.answerText,
              style: const TextStyle(
                color: Colors.white,
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
    if (Provider.of<SaveScoreScience>(context).currentQuestionIndexScience ==
        questionList.length - 1) {
      isLastQuestion = true;
    }

    return Container(
      margin: const EdgeInsets.only(left: 10, top: 30),
      child: SizedBox(
        width: 300,
        child:
            Consumer<SaveScoreScience>(builder: (context, dataScience, child) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 173, 53, 53),
            ),
            onPressed: () {
              if (isLastQuestion) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultScreen(
                              scoreScience: dataScience.scoreScience,
                              currentQuestionIndexScience:
                                  dataScience.currentQuestionIndexScience,
                              questionList: [],
                            )));
              } else {
                Provider.of<SaveScoreScience>(context, listen: false)
                    .scoreIncreseScience();
              }
            },
            // Check if an answer is already selected

            child: Text(isLastQuestion ? "submit" : "next"),
          );
        }),
      ),
    );
  }
}

// ignore: must_be_immutable
class ResultScreen extends StatefulWidget {
  int scoreScience;
  int currentQuestionIndexScience;
  List<Question> questionList = getQuestion();

  ResultScreen(
      {super.key,
      required this.scoreScience,
      required this.currentQuestionIndexScience,
      required this.questionList});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<SaveScoreScience>(context).saveQuizResultScience();
    saveTimeAndDateScience();
    double passingPercentage = 0.6;
    bool isPassed = false;

    if (widget.scoreScience >= widget.questionList.length * passingPercentage) {
      isPassed = true;
    }

    // scoreListScience.add(widget.scoreScience);

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
            Container(
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
                  'Your Score: ${widget.scoreScience}',
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
                      // Navigate back to the home screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                      // Provider.of<SaveScoreScience>(context, listen: false)
                      //     .clearScoreScience();
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
                    // Navigate back to the home screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizScreenScience()),
                    );
                    Provider.of<SaveScoreScience>(context, listen: false)
                        .clearScoreScience();
                  },
                  child: Text('Restart Quiz'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> saveTimeAndDateScience() async {
    final now = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    final storedTimesScience = prefs.getStringList('storedTimesScience') ?? [];
    storedTimesScience.add(now.toString());
    await prefs.setStringList('storedTimesScience', storedTimesScience);
  }
}
