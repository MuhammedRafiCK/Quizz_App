import 'package:flutter/material.dart';
import 'package:quiz_app/Login%20Page/loginPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  LoginPageState log = LoginPageState();

  @override
  void initState() {
    super.initState();
    LoadTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 90, top: 70),
                child: Image.asset(
                  'assets/images/myProfile.png',
                  scale: 10,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Text(
                  userName.text,
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 90),
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    log.removeLoginData();

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                  child: Text('Log Out'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
