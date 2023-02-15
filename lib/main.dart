import 'package:flutter/material.dart';

import 'package:pos_machine/components/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter POS Machine',
      theme: ThemeData(),
      home: const MainScreen(),
    );
  }
}
