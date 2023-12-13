import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_application/helper/google_signin_helper.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  String userEmail = '';
  String userName = '', userMobile = '';
  bool userStatus = false, isLoading = true;

  Future<void> getData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = await auth.currentUser!;
    userEmail = user.email ?? '';
    print('UserName' +
        FirebaseFirestore.instance
            .collection('Users')
            .doc(user.email)
            .collection('MobileNumber')
            .toString());
    // setState(() {});

    FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['Email'] == user.email) {
          print(doc["MobileNumber"]);

          userName = doc['FullName'];
          userMobile = doc["MobileNumber"];
          userStatus = doc['status'];
          if (isLoading)
            setState(() {
              isLoading = false;
            });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return SafeArea(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
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
              const Spacer(),
              Column(children: [
                Text(
                  'Hello there!!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You login with ',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        userEmail.toString(),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name:-  ' + userName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    Text(
                      'Mobile number:-  ' + userMobile,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    Text(
                      'Profile status:-  ' +
                          '${(userStatus) ? 'Activated' : 'Deactivated'}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ]),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  User? user =
                      await Authentication.signInWithGoogle(context: context);
                  if ((user!.email) != null) {
                    await Authentication.signOut(context: context);
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    // If the button is pressed, return green, otherwise blue
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.grey;
                    }
                    return Colors.yellow;
                  }),
                ),
                child: const Text('Log Out',
                    style: TextStyle(color: Colors.black)),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
