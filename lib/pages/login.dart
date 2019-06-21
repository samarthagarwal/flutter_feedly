import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feedly/pages/feed.dart';
import 'package:flutter_feedly/pages/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loggingIn = false;

  _login() async {
    setState(() {
      _loggingIn = true;
    });

    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Logging you in..."),
      ),
    );

    try {
      FirebaseUser _user = await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Login successful."),
        ),
      );

      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return FeedPage();
      }));
    } catch (ex) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text((ex as PlatformException).message),
        ),
      );
    } finally {
      setState(() {
        _loggingIn = false;
      });
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
                size: 180.0,
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
                      obscureText: true,
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
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      splashColor: Colors.white,
                      color: Colors.white,
                      disabledColor: Colors.white.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: _loggingIn == true
                          ? null
                          : () {
                              _login();
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                "LOGIN",
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
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext ctx) {
                          return SignupPage();
                        }));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                "Don't have an Account? Create one.",
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
