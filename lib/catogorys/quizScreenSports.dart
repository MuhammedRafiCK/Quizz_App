import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/sports.dart';
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
  list.add(Question('Who won the FIFA World Cup in 2022?', [
    Answer("Brazil", false),
    Answer("Argentina", true),
    Answer("Germany", false),
    Answer("France", false),
  ]));
  list.add(Question(
      'In soccer, what is the maximum number of substitutions a team can make during a regular match (excluding extra time)?',
      [
        Answer("3 substitutions", true),
        Answer("2 substitutions", false),
        Answer("4 substitutions", false),
        Answer("5 substitutions", false),
      ]));
  list.add(Question(
      'Who is known as the "Black Pearl" and is considered one of the greatest soccer players from Brazil?',
      [
        Answer("Ronaldinho", false),
        Answer("Pelé", true),
        Answer("Vinicios", false),
        Answer("Ronaldo", false),
      ]));
  list.add(Question('Which country hosted the 2014 FIFA World Cup?', [
    Answer("Germany  ", false),
    Answer("Giraffe", false),
    Answer("Brazil ", true),
    Answer("Russia", false),
  ]));
  list.add(Question(
      'Which tournament is considered the most prestigious club competition in European soccer (football)?',
      [
        Answer("FIFA World Cup", false),
        Answer("UEFA Champions League", true),
        Answer("Copa Libertadores", false),
        Answer("UEFA  Championship", false),
      ]));
  return list;
}

class QuizScreenSports extends StatefulWidget {
  const QuizScreenSports({Key? key}) : super(key: key);

  @override
  State<QuizScreenSports> createState() => _QuizScreenSportsState();
}

class _QuizScreenSportsState extends State<QuizScreenSports> {
  List<Question> questionList = getQuestion();
  // int currentQuestionNumber = 0;
  // Answer? selectedAnswers;
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
            Consumer<saveScoreSports>(
              builder: (context, value, child) {
                return Container(
                  margin: const EdgeInsets.only(top: 100, left: 25),
                  child: Text(
                    " ${value.currentQuestionNumber + 1}.",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
            const SizedBox(),
            Consumer<saveScoreSports>(
              builder: (context, value, child) {
                return Container(
                  width: 330,
                  margin: const EdgeInsets.only(top: 100),
                  decoration: const BoxDecoration(),
                  child: Text(
                    questionList[value.currentQuestionNumber].questionText,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _answerList() {
    return SizedBox(
      child: Consumer<saveScoreSports>(builder: (context, value, child) {
        return Container(
          margin: const EdgeInsets.only(top: 40),
          child: Column(
            children: questionList[value.currentQuestionNumber]
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
        answer == Provider.of<saveScoreSports>(context).selectedAnswers;

    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10),
      child: SizedBox(
        width: 300,
        child: Consumer<saveScoreSports>(builder: (context, dataSports, child) {
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
              if (dataSports.selectedAnswers == null) {
                // Check if the selected answer is correct
                if (answer.isCorrect) {
                  dataSports.mark++;
                }
              }
              Provider.of<saveScoreSports>(context, listen: false)
                  .selectedanswerSports(answer);
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
    if (Provider.of<saveScoreSports>(context).currentQuestionNumber ==
        questionList.length - 1) {
      isLastQuestion = true;
    }

    return Container(
      margin: const EdgeInsets.only(left: 10, top: 30),
      child: SizedBox(
        width: 300,
        child: Consumer<saveScoreSports>(builder: (context, dataSports, child) {
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
                              mark: dataSports.mark,
                              currentQuestionNumber:
                                  dataSports.currentQuestionNumber,
                              questionList: [],
                            )));
              } else {
                Provider.of<saveScoreSports>(context, listen: false)
                    .scoreIncreseSports();
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
  int mark;
  int currentQuestionNumber;
  List<Question> questionList = getQuestion();
  ResultScreen(
      {super.key,
      required this.mark,
      required this.currentQuestionNumber,
      required this.questionList});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<saveScoreSports>(context).saveQuizResultSports();
    saveTimeAndDateSports();
    double passingPercentage = 0.6;
    bool isPassed = false;

    if (widget.mark >= widget.questionList.length * passingPercentage) {
      isPassed = true;
    }

    // scoreListSports.add(widget.mark);

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
                  'Your Score: ${widget.mark}',
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
                      // Provider.of<saveScoreSports>(context, listen: false)
                      //     .clearScoreSports();
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
                          builder: (context) => QuizScreenSports()),
                    );
                    Provider.of<saveScoreSports>(context, listen: false).mark =
                        0;
                    Provider.of<saveScoreSports>(context, listen: false)
                        .currentQuestionNumber = 0;
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

  Future<void> saveTimeAndDateSports() async {
    final now = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    final storedTimesSports = prefs.getStringList('storedTimesSports') ?? [];
    storedTimesSports.add(now.toString());
    await prefs.setStringList('storedTimesSports', storedTimesSports);
  }
}
