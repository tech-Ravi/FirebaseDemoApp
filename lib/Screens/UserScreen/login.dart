import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_application/Screens/AdminScreens/admin_login.dart';
import 'package:flutter_demo_application/Screens/UserScreen/user_home.dart';
import 'package:flutter_demo_application/helper/google_signin_helper.dart';
import 'signup.dart';

class SignInScreen extends StatelessWidget {
  String? _email, _password;
  static String? email;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/test.png"),
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text("LOG IN",
                                style: TextStyle(
                                  color: Color(0xFFFFBD73),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                )),
                            TextButton(
                              // color: Colors.black12,
                              // textColor: Colors.white,
                              child: const Text('Sign Up',
                                  style: TextStyle(
                                    color: Color(0xFFFFBD73),
                                    fontWeight: FontWeight.bold,
                                  )),
                              onPressed: () {
                                print('Pressed SignUP!');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return SignUP();
                                  }),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.alternate_email,
                                  color: Color(0xFFFFBD73),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    _email = value;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Email Address",
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.lock,
                                color: Color(0xFFFFBD73),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                obscureText: true,
                                onChanged: (value) {
                                  _password = value;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          child: Container(
                            color: const Color(0xFFFFBD73),
                            margin: const EdgeInsets.only(top: 10.0),
                            width: double.infinity,
                            height: 50.0,
                            child: const Center(
                              child: Text('LogIn',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  )),
                            ),
                          ),
                          onTap: () async {
                            UserCredential user = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _email!, password: _password!);
                            if (user != null) {
                              email = _email;
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return UserHomeScreen();
                                }),
                              );
                            } else {
                              print('user does not exist');
                            }
                          },
                        ),
                        InkWell(
                          onTap: () async {
                            User? user = await Authentication.signInWithGoogle(
                                context: context);

                            if (user != null) {
                              await FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(user.email)
                                  .set({
                                'FullName': user.displayName,
                                'MobileNumber': user.phoneNumber ?? '000000000',
                                'Email': user.email,
                                'user_type': 'user',
                                'status': true,
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return UserHomeScreen();
                                }),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("User does not exist."),
                              ));
                              //  print('user does not exist');
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 30,
                            // width: 100,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/gbutton.jpg"),
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text('OR'),
                        const SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                          child: Container(
                            color: Color.fromARGB(255, 96, 96, 96),
                            margin: const EdgeInsets.only(top: 10.0),
                            width: double.infinity,
                            height: 50.0,
                            child: const Center(
                              child: Text('Admin LogIn',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  )),
                            ),
                          ),
                          onTap: () async {
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return AdminSignInScreen();
                              }),
                            );
                          },
                        ),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
