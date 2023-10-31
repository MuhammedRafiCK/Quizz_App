import 'package:flutter/material.dart';
import 'package:quiz_app/Login%20Page/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

List<String> signUpNameList = [];
List<String> mobileNumberList = [];
List<String> signUpPasswordList = [];

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    super.initState();
    // getUserScores();
    loadSignUpTask();
  }

  final userNameSignUp = TextEditingController();
  final mobileNumberSignUp = TextEditingController();
  final passwordSignUp = TextEditingController();
  final conformPasswordSignUp = TextEditingController();

  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    // addSignUpdata(
    //     userNameSignUp.text, mobileNumberSignUp.text, passwordSignUp.text);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 31, 41),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 10),
                    child: Image.asset(
                      'assets/images/quizre.png',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 15.5),
                    child: Text(
                      'USER SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: userNameSignUp,
                          decoration: InputDecoration(
                            hintText: 'Enter Your Full Name',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: mobileNumberSignUp,
                          decoration: InputDecoration(
                            hintText: 'Enter Mobile Number ',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          obscureText: obscurePassword,
                          controller: passwordSignUp,
                          decoration: InputDecoration(
                            hintText: 'Creat Password',
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: conformPasswordSignUp,
                          obscureText: obscurePassword,
                          decoration: InputDecoration(
                            hintText: 'Conform Your Password ',
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
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 21, 92, 150),
                            ),
                          ),
                          onPressed: () {
                            if (userNameSignUp.text.isNotEmpty &&
                                mobileNumberSignUp.text.isNotEmpty &&
                                passwordSignUp.text.isNotEmpty &&
                                conformPasswordSignUp.text ==
                                    passwordSignUp.text) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                              addSignUpdata(userNameSignUp.text,
                                  mobileNumberSignUp.text, passwordSignUp.text);
                            }
                          },
                          child: Text('Sign Up'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Log In',
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveSignUpData() async {
    final pref = await SharedPreferences.getInstance();

    pref.setStringList('saved_userName', signUpNameList);
    pref.setStringList('saved_mobileNumber', mobileNumberList);
    pref.setStringList('saved_password', signUpPasswordList);

    print(signUpNameList);
    print(mobileNumberList);
    print(signUpPasswordList);
  }

  // ignore: non_constant_identifier_names
  void addSignUpdata(String Name, String Number, String Passsword) {
    signUpNameList.add(Name);
    mobileNumberList.add(Number);
    signUpPasswordList.add(Passsword);
    saveSignUpData();
  }

}

  Future<void> loadSignUpTask() async {
    final pref = await SharedPreferences.getInstance();

    signUpNameList = pref.getStringList('saved_userName') ?? [];
    mobileNumberList = pref.getStringList('saved_mobileNumber') ?? [];
    signUpPasswordList = pref.getStringList('saved_password') ?? [];
    // await pref.clear();
    // ignore: avoid_print
    print(signUpNameList);
    // ignore: avoid_print
    print(mobileNumberList);
    // ignore: avoid_print
    print(signUpPasswordList);
  }
