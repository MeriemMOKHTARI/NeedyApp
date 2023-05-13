import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in/sign/sign_in.dart';

import '../auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final User? user = auth().currentUser;

  BuildContext? get ctx => null;

  Future<void> signOut() async {
    await auth().signOut();
  }

  void navigatenextpage4(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return sign_in();
    }));
  }

  Widget _UserUid() {
    return Text(user?.email ?? 'User email');
  }

  @override
  Widget build(BuildContext context) {
    Widget _SignOutButton() {
      return ElevatedButton(
        onPressed: () {
          signOut();
          navigatenextpage4(context);
        },
        child: const Text('Sign Out'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _UserUid(),
            _SignOutButton(),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return const Text('home page');
  }
}
