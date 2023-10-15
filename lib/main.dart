import 'package:flutter/material.dart';
import 'package:pretest_mdi_pai/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
