// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/constants.dart';
import 'package:mad_project/widgets/custom_btn.dart';
import 'package:mad_project/widgets/custom_form_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Alert dialog to show errors
  Future<void> _alertDialogBuilder(BuildContext context, String? error) async {
    return showDialog(
        context: context,
        barrierDismissible:
            false, // won't let user close the dialog by tapping anywhere on screen, they must tap on the popup button
        builder: (context) {
          return AlertDialog(
            title: const Text("Error!"),
            content: Text(error!),
            actions: [
              TextButton(
                onPressed: () {
                  // _alertDialogBuilder();
                  Navigator.pop(context);
                },
                child: const Text("Close dialog"),
              ),
            ],
          );
        });
  }

  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _signUpEmail,
        password: _signUpPassword,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-passowrd') {
        return "Password provided is too weak!";
      } else if (e.code == 'email-already-in-use') {
        return "Account name is taken, please try another";
      }
      return e.message; // some other error altogether
    } catch (e) {
      return e.toString();
    }
  }

  bool _signUpFormLoading = false;

  void _submitForm() async {
    print("function called");
    // show loading indicator
    setState(() {
      _signUpFormLoading = true;
    });

    // will store errors while creating account
    String? _createAccountFeedback = await _createAccount();
    if (_createAccountFeedback != null) {
      // if error is generated, then we display it in a dialog box
      _alertDialogBuilder(context, _createAccountFeedback);

      // if action completed without error, the loading indicator should stop
      setState(() {
        _signUpFormLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  // Form input fields
  String _signUpEmail = "";
  String _signUpPassword = "";

  // will help shift focus to password field once user has entered their email (enchances UX)
  FocusNode? _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 24.0),
                child: Text(
                  "Welcome to ${Constants.appName}!\nPlease enter your details",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomFormInput(
                    hintText: "Email",
                    onChanged: (value) {
                      _signUpEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode!.requestFocus(); // change focus
                    },
                    textInputAction: TextInputAction
                        .next, // will show next button on keyboard (cuz password field is next)
                  ),
                  CustomFormInput(
                    hintText: "Password",
                    onChanged: (value) {
                      _signUpPassword = value;
                    },
                    onSubmitted: (value) {
                      _submitForm();
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                  ),
                  CustomBtn(
                    btnText: "Sign Up",
                    btnColor: Constants.customBtnColor,
                    isLoading: _signUpFormLoading,
                    onPressed: () {
                      _submitForm();
                      setState(() {
                        _signUpFormLoading = true;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "Already have an account? Log in!",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    CustomBtn(
                      btnText: "Back to Login",
                      btnColor: Constants.customBtnColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      outlineBtn: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
