import 'package:flutter/material.dart';
import 'package:quiz_app/Login%20Page/signUpPage.dart';
import 'package:quiz_app/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

List<String> usernameList = [];
List<String> passwordList = [];

final userName = TextEditingController();
final password = TextEditingController();
// String name = 'rafi';
// String lock = '1234';

class LoginPageState extends State<LoginPage> {
  bool obscurePassword = true; // Track password visibility

  @override
  void initState() {
    super.initState();
    LoadTask();
    loadSignUpTask();
  }

  @override
  Widget build(BuildContext context) {
    SaveData();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 31, 41),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset('assets/images/quiz.png'),
                Text(
                  'USER LOGIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: userName,
                        decoration: InputDecoration(
                          hintText: 'User Name',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: password,
                    obscureText: obscurePassword, // Toggle password visibility
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              obscurePassword = !obscurePassword;
                            },
                          );
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2.2),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'forgot password',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 21, 92, 150),
                      ),
                    ),
                    onPressed: () {
                      validation(context);
                    },
                    child: Text('Log in'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text(
                    'sign up',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
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

  removeLoginData() {
    usernameList.removeAt(0);
    passwordList.removeAt(0);
    SaveData();
  }

  void validation(BuildContext context) async {
    for (int i = 0; i < signUpNameList.length; i++) {
      if (userName.text == signUpNameList[i] &&
          password.text == signUpPasswordList[i]) {
        AddTask(userName.text, password.text);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }
  }
}

// ignore: non_constant_identifier_names
void AddTask(String UserName, String Password) {
  usernameList.add(UserName);
  passwordList.add(Password);
  userName.clear();
  password.clear();
  SaveData();
}

// ignore: non_constant_identifier_names
Future<void> SaveData() async {
  final pref = await SharedPreferences.getInstance();

  pref.setStringList('saved_value', usernameList);
  pref.setStringList('saved_value1', passwordList);
}

// ignore: non_constant_identifier_names
Future<void> LoadTask() async {
  final pref = await SharedPreferences.getInstance();

  usernameList = pref.getStringList('saved_value') ?? [];
  passwordList = pref.getStringList('saved_value1') ?? [];
  // await pref.clear();
  // ignore: avoid_print
  print(usernameList);
  // ignore: avoid_print
  print(passwordList);
}
