// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/gk.dart';

import 'package:shared_preferences/shared_preferences.dart';

class GkScore extends StatefulWidget {
  GkScore({Key? key}) : super(key: key);

  @override
  State<GkScore> createState() => _GkScoreState();
}

class _GkScoreState extends State<GkScore> {
  List<String> storedTimes = [];

  @override
  void initState() {
    super.initState();
    // getUserScores();
    loadStoredTimes();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<saveScore>(context).getUserScores();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 3, 3),
      appBar: AppBar(
        title: Text('General Knowledge'),
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
                    Provider.of<saveScore>(context, listen: false)
                        .clearSharedPreferences();
                  },
                  child: Text('Clear History'),
                ),
              ];
            },
          )
        ],
      ),
      body: Consumer<saveScore>(builder: (context, list, child) {
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
                    padding: const EdgeInsets.only(top: 20, left: 16),
                    child: Text(
                      'Score : ${list.userScores[index]}',
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
                      storedTimes[
                          index], // Check if dateAndTime has enough items
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: list.userScores.length,
        );
      }),
    );
  }

  Future<void> loadStoredTimes() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTimesList = prefs.getStringList('storedTimes');
    //await prefs.clear();
    setState(() {
      storedTimes = storedTimesList ?? [];
    });
  }
}
