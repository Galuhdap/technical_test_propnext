import 'package:flutter/material.dart';
import 'package:technical_test_propnext/presentations/splash/page/splash_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      title: 'Flutter Demo',
      home: SplashPage(),
    );
  }
}
