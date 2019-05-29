import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _signup() async {
    if (_passwordController.text.trim() !=
        _passwordConfirmController.text.trim()) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = _nameController.text.trim();

      await user.updateProfile(info);

      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Your account has been created successfully."),
        ),
      );
    } catch (ex) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text((ex as PlatformException).message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.deepOrange,
      body: Form(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 72.0, bottom: 36.0),
              child: Icon(
                Icons.rss_feed,
                size: 60.0,
                color: Colors.white,
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding: const EdgeInsets.all(
                4.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white.withOpacity(0.5), width: 1.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                    color: Colors.white.withOpacity(0.5),
                    margin: const EdgeInsets.only(right: 10.0),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your name",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding: const EdgeInsets.all(
                4.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white.withOpacity(0.5), width: 1.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Icon(
                      Icons.alternate_email,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                    color: Colors.white.withOpacity(0.5),
                    margin: const EdgeInsets.only(right: 10.0),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your email",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding: const EdgeInsets.all(
                4.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white.withOpacity(0.5), width: 1.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Icon(
                      Icons.lock_open,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                    color: Colors.white.withOpacity(0.5),
                    margin: const EdgeInsets.only(right: 10.0),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _passwordController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your password",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding: const EdgeInsets.all(
                4.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white.withOpacity(0.5), width: 1.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Icon(
                      Icons.lock_open,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                    color: Colors.white.withOpacity(0.5),
                    margin: const EdgeInsets.only(right: 10.0),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _passwordConfirmController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Re-enter your password",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      splashColor: Colors.white,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        _signup();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                "SIGN UP",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                "Already have an account? Login here.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
