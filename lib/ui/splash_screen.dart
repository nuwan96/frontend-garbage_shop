import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   _showWelcomeScreen();

  //   super.initState();
  // }
  // void _showWelcomeScreen() async {
  //   String? accessToken= await Settings.getAccessToken();
  //   Timer(const Duration(seconds: 2),(){
  //       if(accessToken.isEmpty || accessToken == ''){
  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Login()));
  //       }
  //       else{
  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
  //       }
  //   });
  // }
  @override
  void initState() {
    _showWelcomeScreen();

    super.initState();
  }

  void _showWelcomeScreen() async {
    Timer(const Duration(seconds: 2), () {
      //  print('waitting');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/images/killos.png",
          height: 165,
          width: 165,
        ),
      ),
    );
  }
}
