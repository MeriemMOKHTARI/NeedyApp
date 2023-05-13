import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomePage.dart';
import 'sign/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //
 
 
 
  SystemChrome.setPreferredOrientations( 
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]); 
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle( 
    statusBarColor: Colors.transparent, // transparent status bar 
    systemNavigationBarColor: Colors.transparent, // navigation bar color 
  )); 
   
 
 
  await Firebase.initializeApp(); //
  User? auth = FirebaseAuth.instance.currentUser; 
  // print(user!.uid); 
  runApp(my_app());
}


class my_app extends StatefulWidget {
  const my_app({super.key});

  @override
  State<my_app> createState() => _my_appState();
}

class _my_appState extends State<my_app> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  
              StreamBuilder<User?>( 
                stream: FirebaseAuth.instance.authStateChanges(), 
                builder: (context, snapshot) { 
                  if (snapshot.connectionState == ConnectionState.waiting) { 
 
                    return  Center( 
                      child: CircularProgressIndicator(), 
                    ); 
                  } else if (snapshot.hasData) { 
                     
                   // HNA ROHI DIRECT LEL ACCUEIL CBNNNNN !!! 
                    return HomePage(); 
                  } else if (snapshot.hasError) { 
                    return const Center( 
                      child: Text('error'), 
                    ); 
                  } else { 
                    //HNA ROHI LEL SIGNIN 
                    return sign_in(); 
                  } 
                },),
    );
  }
}
