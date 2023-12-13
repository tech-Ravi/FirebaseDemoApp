import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_application/Screens/AdminScreens/admin_home.dart';

class AdminSignInScreen extends StatelessWidget {
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
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/back.png"),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
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
                            const Text("Admin LOG IN",
                                style: TextStyle(
                                  color: Color(0xFFFFBD73),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                )),
                          ],
                        ),
                        const Spacer(),
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
                                    hintText: "Admin Email Address",
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
                                  hintText: "Admin Password",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return AdminHome();
                                }),
                              );
                            } else {
                              print('user does not exist');
                            }
                          },
                        ),
                        const Spacer(),
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
