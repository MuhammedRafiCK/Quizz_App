import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/science.dart';
import 'package:shared_preferences/shared_preferences.dart';

class scienceScore extends StatefulWidget {
  const scienceScore({super.key});

  @override
  State<scienceScore> createState() => _scienceScoreState();
}

// ignore: camel_case_types
class _scienceScoreState extends State<scienceScore> {
  List<int> userScoresScience = [];
  List<String> storedTimesScience = [];
  @override
  void initState() {
    super.initState();
    // getUserScoresScience();
    loadStoredTimesScience();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SaveScoreScience>(context).getUserScoresScience();
    loadStoredTimesScience();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Science'),
        centerTitle: true,
        toolbarHeight: 60,
        backgroundColor: Color.fromARGB(255, 75, 73, 73),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle the selected item
              print("Selected: $value");
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  onTap: () {
                    Provider.of<SaveScoreScience>(context, listen: false)
                        .clearSharedPreferencesScience();
                  },
                  child: Text('Clear History'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Consumer<SaveScoreScience>(builder: (context, data, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 80,
                width: 280,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 219, 211, 211)),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'Score : ${data.userScoresScience[index]}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 23, right: 10),
                    child: Text(
                      storedTimesScience[
                          index], // Check if dateAndTime has enough items
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: data.userScoresScience.length,
        );
      }),
    );
  }

  Future<void> loadStoredTimesScience() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTimesScienceList = prefs.getStringList('storedTimesScience');
    //await prefs.clear();
    setState(() {
      storedTimesScience = storedTimesScienceList ?? [];
    });
  }
}
