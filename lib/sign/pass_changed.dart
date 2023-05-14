import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sign_in/home/HmePge.dart';
import 'package:sign_in/sign/sign_in.dart';
import '../HomePage.dart';
import 'verifcode.dart';

class changed extends StatefulWidget {
  final User user;
  final String name;
  final String email;
  final String number;
  final String password ;
  const changed(
      {required this.user,
      required this.name,
      required this.email,
      required this.number,
      required this.password,
      super.key});

  @override
  State<changed> createState() => _changedState();
}

class _changedState extends State<changed> {
  @override
  Widget build(BuildContext context) {
    void navigatenextpage(BuildContext ctx) {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
        return HomePage();
      }));
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF0097B2),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
//needy
                Center(
                  child: Text(
                    "Needy",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Pacifico",
                      fontSize: 35,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),

                Container(
                  width: 343,
                  height: 580,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      Image.asset(
                        "images/s.png",
                        height: 99,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      //text1

                      Padding(
                        padding: const EdgeInsets.only(top: 24, left: 0),
                        child: Text(
                          "email has been sent",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //text 02
                      Padding(
                        padding: const EdgeInsets.only(top: 13, left: 5),
                        child: Text(
                          "Please check your email",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),

                      SizedBox(
                        height: 18,
                      ),
                      //send code  button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ElevatedButton(
                          onPressed: () async { 
                             await FirebaseAuth.instance.signInWithEmailAndPassword(
        email:widget.email,
        password: widget.password,
      );
  
                                
                           if (FirebaseAuth.instance.currentUser!.emailVerified) {
                              CollectionReference collectionReference =
                                  FirebaseFirestore.instance.collection("user");
                              await collectionReference
                                  .doc(widget.user!.uid)
                                  .set({
                                "email": widget.email,
                                "name": widget.name,
                                "number": widget.number,
                              }).then((value) async {
                                print('aaaaaa');
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return HomePage();
      }));
        print('bbbbbbb');

                              });
                            } else {
                              // L'utilisateur n'a pas encore vérifié son adresse e-mail.
                              print("not verified");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                              backgroundColor: Color(0xFF0097B2),
                              padding: EdgeInsets.symmetric(vertical: 17)),
                          child: Center(
                            child: Text(
                              "I verified",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
