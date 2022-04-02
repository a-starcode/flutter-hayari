import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mad_project/screens/home_page.dart';

import 'package:mad_project/screens/login_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _init = Firebase.initializeApp();

  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot) {
        // if error generated
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        // once finished loading
        if (snapshot.connectionState == ConnectionState.done) {
          // we will constantly monitor the login state live using a StreamBuilder
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              // if error
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${streamSnapshot.error}"),
                  ),
                );
              }

              // active does not mean the user has logged in successfully, it just means the state was changed 
              if (streamSnapshot.connectionState == ConnectionState.active) {
                // get the user
                User? _user = streamSnapshot.data as User?; // ? implies the variable can be null

                if (_user == null) {
                  return const LoginPage(); // LoginPage() 
                }
                else {
                  return const HomePage();
                }
              }

              // while loading
              return const Scaffold(
                body: Center(
                  child: Text("Initializing app"),
                ),
              );
            },
          );
        }

        // while loading
        return const Scaffold(
          body: Center(
            child: Text("Initializing app"),
          ),
        );
      },
    );
  }
}
