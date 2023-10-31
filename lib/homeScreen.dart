// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/History/history.dart';
import 'package:quiz_app/Login%20Page/loginPage.dart';
import 'package:quiz_app/Login%20Page/profile.dart';
import 'package:quiz_app/catogorys/quizScreenGk.dart';
import 'package:quiz_app/catogorys/quizScreenScience.dart';
import 'package:quiz_app/provider/gk.dart';
import 'package:quiz_app/provider/science.dart';
import 'package:quiz_app/provider/sports.dart';
import 'catogorys/quizScreenSports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    LoadTask();
  }

  @override
  Widget build(BuildContext context) {
    print('all rebuild');
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
                bottomRight: Radius.circular(70))),
        backgroundColor: Color.fromARGB(255, 75, 73, 73),
        toolbarHeight: 110,
        title: Text(
          'Quize App',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 252, 252, 252)),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 19, 18, 18),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(color: Color.fromARGB(255, 54, 53, 53)),
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 55),
                child: Text(
                  'Quiz App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.white),
              ),
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(context,
                    (MaterialPageRoute(builder: (context) => ProfilePage())));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.history,
                color: Colors.white,
              ),
              title: Text(
                'History',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResultHistory(),
                  ),
                );
              },
            ),

            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Handle the settings item tap
              },
            ),
            // Add more list items for navigation options
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 20,
                      top: MediaQuery.of(context).size.width / 20),
                  child: Text(
                    'Catogorys',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 221, 221, 221),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 20,
                  ),
                  child: Text(
                    '(select your catogory)',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreenGk(),
                      ),
                    );
                    Provider.of<saveScore>(context, listen: false).clearScore();
                    Provider.of<saveScore>(context, listen: false)
                        .currentQuestionIndex = 0;
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 20),
                    child: Container(
                      height: 120,
                      width: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 75, 73, 73)),
                      child: Column(children: [
                        Row(
                          children: [
                            Container(
                              height: 92,
                              width: 130,
                              margin: EdgeInsets.only(top: 10),
                              child: Image.asset(
                                'assets/images/gk.png',
                                scale: 6,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 25, top: 10),
                                  child: Text(
                                    'General Knowledge',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizScreenSports(),
                      ),
                    );
                    Provider.of<saveScoreSports>(context, listen: false)
                        .clearScoreSports();
                    Provider.of<saveScoreSports>(context, listen: false)
                        .currentQuestionNumber = 0;
                    // setState(() {
                    //   currentQuestionNumber = 0;
                    //   mark = 0;
                    //   selectedAnswers = null;
                    // });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      height: 120,
                      width: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 75, 73, 73)),
                      child: Column(children: [
                        Row(
                          children: [
                            Container(
                              height: 92,
                              width: 130,
                              margin: EdgeInsets.only(top: 10),
                              child: Image.asset(
                                'assets/images/sportsIcon.png',
                                scale: 7,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25, top: 10),
                              child: Text(
                                'Sports',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizScreenScience(),
                      ),
                    );
                    Provider.of<SaveScoreScience>(context, listen: false)
                        .clearScoreScience();
                    Provider.of<SaveScoreScience>(context, listen: false)
                        .currentQuestionIndexScience = 0;
                    // setState(() {
                    //   currentQuestionIndexScience = 0;
                    //   scoreScience = 0;
                    //   selectedAnswerScience = null;
                    // });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      height: 120,
                      width: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 75, 73, 73)),
                      child: Column(children: [
                        Row(
                          children: [
                            Container(
                              height: 92,
                              width: 130,
                              margin: EdgeInsets.only(top: 10),
                              child: Image.asset(
                                'assets/images/scienceIcon.png',
                                scale: 7,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25, top: 10),
                              child: Text(
                                'Science',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
