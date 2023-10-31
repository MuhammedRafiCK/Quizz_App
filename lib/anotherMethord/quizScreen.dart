// import 'package:flutter/material.dart';
// import 'package:quiz_app/catogorys/questionListModel.dart';

// // ignore: must_be_immutable
// class QuizScreen extends StatefulWidget {
//   List<QuestionList> questionsAndOptions = [];
//   QuizScreen({
//     super.key,
//     required this.questionsAndOptions,
//   });

//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   int currentQuestionIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(colors: [
//             Color.fromARGB(255, 7, 88, 134),
//             Color.fromARGB(255, 5, 25, 27),
//           ], begin: Alignment.topLeft, end: Alignment.bottomRight),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [_questionWidget(), _answerList()],
//         ),
//       ),
//     );
//   }

//   _questionWidget() {
//     return Column(
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: const EdgeInsets.only(top: 100, left: 25),
//               child: Text(
//                 " ${currentQuestionIndex + 1}.",
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//             const SizedBox(),
//             Container(
//               width: 330,
//               margin: const EdgeInsets.only(top: 100),
//               decoration: const BoxDecoration(),
//               child: Text(
//                 widget.questionsAndOptions[currentQuestionIndex].questionGk!,
//                 textAlign: TextAlign.start,
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 25,
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _answerList() {
//     return SizedBox(
//       child: Container(
//         margin: const EdgeInsets.only(top: 40),
//         child: Column(
//           children: [
//             Text("s"),
//           ],
//         ),
//       ),
//     );
//   }
// }
