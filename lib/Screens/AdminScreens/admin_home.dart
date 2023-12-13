import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Hello Admin!!',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateColor.resolveWith((states) {
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
                      ],
                    ),
                  ),
                  const Text('User List',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  const Divider(
                    color: Colors.amber,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView(
                          children: snapshot.data!.docs.map((document) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(0.1),
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          document['FullName'],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          document['Email'],
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          document['MobileNumber'] ?? '',
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (document['status'])
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Updating data. Please wait... "),
                                            backgroundColor: Colors.grey,
                                            duration:
                                                Duration(milliseconds: 100),
                                          ));
                                          FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(document['Email'])
                                              .update({'status': false});
                                        },
                                        child: const Text(
                                          'Active',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.green),
                                        ),
                                      ),
                                    ),
                                  if (!document['status'])
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Updating data. Please wait... "),
                                            backgroundColor: Colors.grey,
                                            duration:
                                                Duration(milliseconds: 100),
                                          ));
                                          FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(document['Email'])
                                              .update({'status': true});
                                        },
                                        child: const Text(
                                          'Inactive',
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("Deleting user. Please wait..."),
                                        ));
                                        FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(document['Email'])
                                            .delete();
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
