import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SignUP extends StatelessWidget {
  String? _email, _password, _fullName, _mobileNumber;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("SIGN UP",
                                style: TextStyle(
                                  color: Color(0xFFFFBD73),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                )),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.person,
                                color: Color(0xFFFFBD73),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  _fullName = value;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Full Name",
                                ),
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.phone,
                                color: Color(0xFFFFBD73),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  _mobileNumber = value;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Mobile Number",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
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
                        const Spacer(),
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
                                onChanged: (value) {
                                  _password = value;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                ),
                              ),
                            )
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
                              child: Text('Sign Up',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  )),
                            ),
                          ),
                          onTap: () async {
                            if (_fullName == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Please fill all fields"),
                              ));
                            } else if (_password == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Please fill all fields"),
                              ));
                            } else if (_mobileNumber == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Please fill all fields"),
                              ));
                            } else if (_password!.length < 6) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "Password should be greater than 6 digit."),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Please wait..."),
                              ));
                              UserCredential user = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _email!, password: _password!);
                              if (user != null) {
                                await FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(_email)
                                    .set({
                                  'FullName': _fullName,
                                  'MobileNumber': _mobileNumber,
                                  'Email': _email,
                                  'user_type': 'user',
                                  'status': true,
                                });
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return SignInScreen();
                                  }),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("User does not exist."),
                                ));
                                //  print('user does not exist');
                              }
                            }
                          },
                        ),
                        const Spacer(),
                        const Spacer(),
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
