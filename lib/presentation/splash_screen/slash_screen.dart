
import 'dart:async';

import 'package:flutter/material.dart';

import '../login_screen/login_screen.dart';
import 'SplashServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashScreen=SplashServices();


  @override

  void initState() {
    super.initState();
    splashScreen.isLogin(context);

  }

  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        child:  Center(
          child: Image.asset(
            'assets/e_com.png',
            fit: BoxFit.cover,
            width: 70,
            height: 70,
          )
        ),
      ),
    );
  }
}
