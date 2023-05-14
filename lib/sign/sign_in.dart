import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sign_in/HomePage.dart';
import 'package:sign_in/sign/forget_pass.dart';
import 'package:sign_in/sign/sign_up.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  final formkey = GlobalKey<FormState>();
  void navigatenextpage(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return sign_up();
    }));
  }

  void navigatenextpage2(BuildContext ctx, email) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return forget_pass(email:email);
    }));
  }

  void navigatenextpage3(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return HomePage();
    }));
  }

  TextEditingController _emailControlleur = TextEditingController();
  TextEditingController _passwordControlleur = TextEditingController();

  bool isloading = false;
  Future<void> sign() async {
    setState(() {
      isloading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailControlleur.text,
        password: _passwordControlleur.text,
      );
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    setState(() {
      isloading = false;
    });
  }

  bool b = true;

  //hnaa newpassword

  @override
  Widget build(BuildContext context) {
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
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            //text1
                            Padding(
                              padding: const EdgeInsets.only(top: 28, left: 0),
                              child: Text(
                                "Login account",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                ),
                              ),
                            ),
                            //text2
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 10),
                              child: Text(
                                "Hello, you should login first to be able to use the  application and enjoy all the features in Needy.",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            //email textfield
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
                              height: 28,
                            ),
                            //password textfield
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
                                        color: Colors.grey, size: 20),
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
                                  
                            //forget password
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      navigatenextpage2(context, _emailControlleur.text);
                                    },
                                    child: Text(
                                      "Forget Password?",
                                      style: TextStyle(
                                          color: Color(0xFF0097B2), fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                                  
                            //sign in button
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: isloading
                                  ? CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: () async {
                                        if (this.formkey.currentState!.validate()) {
                                        await sign();
                                        navigatenextpage3(context);}
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
                                          "Sign In",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                                  
                            SizedBox(
                              height: 30,
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
                                    child: Text("Or Sign In With"),
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
                                        borderRadius: BorderRadius.circular(
                                            100), // <-- Radius
                                      ),
                                      backgroundColor: Color(0xFFF2F2F2),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 13, horizontal: 10)),
                                  child: Image.asset(
                                    "images/google.png",
                                    height: 18,
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
                                          BorderRadius.circular(100), // <-- Radius
                                    ),
                                    backgroundColor: Color(0xFFF2F2F2),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 13, horizontal: 10),
                                  ),
                                  child: Image.asset(
                                    "images/facebook.png",
                                    height: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don’t have an account?"),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      navigatenextpage(context);
                                    },
                                    child: Text(
                                      "Join Us",
                                      style: TextStyle(
                                          color: Color(0xFF0097B2), fontSize: 13),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
