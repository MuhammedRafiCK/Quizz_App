import 'package:flutter/material.dart';
import 'package:quiz_app/History/scienceHistory.dart';
import 'package:quiz_app/History/sportsHistory.dart';
import 'gkHistory.dart';

class ResultHistory extends StatefulWidget {
  const ResultHistory({super.key});

  @override
  State<ResultHistory> createState() => _ResultHistoryState();
}

class _ResultHistoryState extends State<ResultHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color.fromARGB(255, 75, 73, 73),
        title: Text('Categorys'),
        centerTitle: true,
        actions: [
          IconButton.filled(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GkScore(),
                    ),
                  );
                },
                child: Container(
                  height: 70,
                  width: 360,
                  margin: EdgeInsets.only(left: 15, top: 0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 219, 211, 211)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 25),
                    child: Text(
                      'General Knowledge',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => sportsScore(),
                      ),
                    );
                  },
                  child: Container(
                      height: 70,
                      width: 360,
                      margin: EdgeInsets.only(left: 15, top: 0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 219, 211, 211)),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, left: 25),
                        child: Text('Sports',
                            style: TextStyle(color: Colors.white)),
                      )))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => scienceScore(),
                    ),
                  );
                },
                child: Container(
                  height: 70,
                  width: 360,
                  margin: EdgeInsets.only(left: 15, top: 0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 219, 211, 211)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 25),
                    child:
                        Text('Science', style: TextStyle(color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}




// Future<void> SaveTask() async {
//   final pref = await SharedPreferences.getInstance();
//   pref.setString('score', scoreList[score] as String);
// }

// Future<void> LoadTask() async {
//   final pref = await SharedPreferences.getInstance();
//   pref.getStringList('score') ?? [];
//   print('$scoreList,mmm');
// }

