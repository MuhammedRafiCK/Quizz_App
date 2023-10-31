import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/sports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class sportsScore extends StatefulWidget {
  const sportsScore({super.key});

  @override
  State<sportsScore> createState() => _sportsScoreState();
}

class _sportsScoreState extends State<sportsScore> {
  // List<int> userScoresSports = [];
  List<String> storedTimesSports = [];
  @override
  void initState() {
    super.initState();
    loadStoredTimesSports();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<saveScoreSports>(context).getUserScoresSports();

    loadStoredTimesSports();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Sports'),
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
                    Provider.of<saveScoreSports>(context, listen: false)
                        .clearSharedPreferencesSports();
                  },
                  child: Text('Clear History'),
                ),
              ];
            },
          )
        ],
      ),
      body: Consumer<saveScoreSports>(builder: (context, dataGet, child) {
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
                      'Score : ${dataGet.userScoresSports[index]}',
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
                      storedTimesSports[
                          index], // Check if dateAndTime has enough items
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: dataGet.userScoresSports.length,
        );
      }),
    );
  }

  Future<void> loadStoredTimesSports() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTimesSportsList = prefs.getStringList('storedTimesSports');
    //await prefs.clear();
    setState(() {
      storedTimesSports = storedTimesSportsList ?? [];
    });
  }
}
