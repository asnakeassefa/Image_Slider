import 'package:flutter/material.dart';

import 'feature/pickphoto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xff023047),
          ),
          fontFamily: 'poppins',
          appBarTheme: AppBarTheme(
            color: Color(0xff023047),
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'poppins'),
          )),
      home: const MultipleImageSelector(),
      debugShowCheckedModeBanner: false,
    );
  }
}
