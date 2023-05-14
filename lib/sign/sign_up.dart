import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sign_in/HomePage.dart';
import 'confirmation.dart';

import 'pass_changed.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  final formkey = GlobalKey<FormState>();

 

  TextEditingController _emailControlleur = TextEditingController();
  TextEditingController _nameControlleur = TextEditingController();
  TextEditingController _numberControlleur = TextEditingController();

  TextEditingController _passwordControlleur = TextEditingController();
  bool isloading = false;
 
  bool b = true;

  @override
  Widget build(BuildContext context) {
     Future<void> signupAA() async {
    setState(() {
      isloading = true;
    });
    try {
      String id = "";
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailControlleur.text,
        password: _passwordControlleur.text,
      )
          .then((value) async {
  
User user = value.user! ;
await user.sendEmailVerification();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      // return confirm();
      return changed(user: user,
      email: _emailControlleur.text,
         name: _nameControlleur.text,
         number: _numberControlleur.text,
         password: _passwordControlleur.text,
      );
    }));


     
     }); 
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    setState(() {
      isloading = false;
    });
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
                //
                SizedBox(
                  height: 24,
                ),
                Container(
                  width: 343,
                  height: 580,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Form(
                    key: formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //text1
                          Padding(
                            padding: const EdgeInsets.only(top: 26, left: 0),
                            child: Text(
                              "Register to get started",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          //username textfield
                    
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 17),
                            child: TextFormField(
                              controller: _nameControlleur,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.assignment_ind_rounded,
                                    color: Color(0xFF0097B2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Color(0XFFE8ECF4)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Color(0XFFE8ECF4)),
                                  ),
                                  fillColor: Color(0xFFF7F8F9),
                                  filled: true,
                                  labelText: ' Name',
                                  hintText: 'Enter Your First Name'),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^[a-zA-Z]{3,}$').hasMatch(value)) {
                                  return "enter correct name ";
                                } else {
                                  return null;
                                }
                              },
                              
                         
                              obscureText: false,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                    
                          //email text field
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 17),
                            child: TextFormField(
                              controller: _emailControlleur,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.mail_rounded,
                                    color: Color(0xFF0097B2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Color(0XFFE8ECF4)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Color(0XFFE8ECF4)),
                                  ),
                                  fillColor: Color(0xFFF7F8F9),
                                  filled: true,
                                  labelText: 'Email',
                                  hintText: 'Enter Your email'),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                  return "enter correct Email ";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          //hna
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 17),
                            child: TextFormField(
                              controller: _passwordControlleur,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      b = !b;
                                    });
                                  },
                                  icon: Icon(
                                    b ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.lock,
                                    color: Color(0xFF0097B2), size: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Color(0XFFE8ECF4)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Color(0XFFE8ECF4)),
                                ),
                                fillColor: Color(0xFFF7F8F9),
                                filled: true,
                                labelText: '  Password',
                                hintText: '  Enter Your password',
                              ),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                        .hasMatch(value)) {
                                  return "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one number ";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: b,
                            ),
                          ),
                    
                          SizedBox(
                            height: 18,
                          ),
                          //sise
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 17),
                            child: TextFormField(
                              controller: _numberControlleur,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Color(0xFF0097B2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Color(0XFFE8ECF4)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Color(0XFFE8ECF4)),
                                  ),
                                  fillColor: Color(0xFFF7F8F9),
                                  filled: true,
                                  labelText: 'Phone Number',
                                  hintText: 'Enter Your Phone Number'),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^\d{10}$')
                                        .hasMatch(value)) {
                                  return "enter correct phone number ";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: false,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                    
                          SizedBox(
                            height: 20,
                          ),
                          //sign up button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: isloading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      if (this.formkey.currentState!.validate()) {
                                        await signupAA();
                    

                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // <-- Radius
                                        ),
                                        backgroundColor: Color(0xFF0097B2),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 17)),
                                    child: Center(
                                      child: Text(
                                        // "Get a Confirmation Code"
                                        "sign up",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                    
                          SizedBox(
                            height: 25,
                          ),
                    
                    //devider
                    
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("Or Register With"),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    //
                    
                          SizedBox(
                            height: 23,
                          ),
                    
                    //google or facebok sign in
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                    //google button
                    
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5), // <-- Radius
                                    ),
                                    backgroundColor: Color(0xFFF2F2F2),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 13, horizontal: 10)),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/google.png",
                                      height: 18,
                                    ),
                                    Text(
                                      "  Google  ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                    //facebook button
                    
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(5), // <-- Radius
                                  ),
                                  backgroundColor: Color(0xFFF2F2F2),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 10),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/facebook.png",
                                      height: 20,
                                    ),
                                    Text(
                                      " Facebook",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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