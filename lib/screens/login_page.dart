import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mad_project/constants.dart';
import 'package:mad_project/screens/sign_up_page.dart';
import 'package:mad_project/widgets/custom_btn.dart';
import 'package:mad_project/widgets/custom_form_input.dart';

// user: testemail@email.com
// password: 123456

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
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

  bool _loginFormLoading = false;

  void _submitForm() async {
    // show loading indicator
    setState(() {
      _loginFormLoading = true;
    });
    // will store errors while creating account
    String? _loginFeedback = await _loginAccount();
    if (_loginFeedback != null) {
      // if error is generated, then we display it in a dialog box
      _alertDialogBuilder(context, _loginFeedback);

      // show loading indicator
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  // Form input fields
  String _loginEmail = "";
  String _loginPassword = "";

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
          width: double.infinity, // takes up all space
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 24.0),
                child: Text(
                  "Welcome to ${Constants.appName}!\nPlease login",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomFormInput(
                    hintText: "Email",
                    onChanged: (value) {
                      _loginEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode!.requestFocus(); // change focus
                    },
                    // will show next button on keyboard (cuz password field is next)
                    textInputAction: TextInputAction.next,
                  ),
                  CustomFormInput(
                    hintText: "Password",
                    onChanged: (value) {
                      _loginPassword = value;
                    },
                    onSubmitted: (value) {
                      _submitForm();
                    },
                    isPasswordField: true,
                  ),
                  CustomBtn(
                    btnText: "Login",
                    btnColor: Constants.customBtnColor,
                    isLoading: _loginFormLoading,
                    onPressed: () {
                      _submitForm();
                      setState(() {
                        _loginFormLoading = true;
                      });
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "Dont have an account? Create one!",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    CustomBtn(
                      btnText: "Sign Up",
                      btnColor: Constants.customBtnColor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
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
