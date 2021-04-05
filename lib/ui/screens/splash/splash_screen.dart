import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:randomsampleapp/config/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Sample App',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }

  _startTime() {
    return Timer(Duration(seconds: 3), _navigationPage);
  }

  void _navigationPage() {
    if (isAuthenticated())
      Navigator.pushReplacementNamed(context, Routes.dashBoard);
    else
      Navigator.pushReplacementNamed(context, Routes.login);
  }

  bool isAuthenticated() {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
