import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:using_hive/home_page.dart';

void main() async {
  ///init hive
  await Hive.initFlutter();

  ///open box
  var storage = await Hive.openBox("storage");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.redAccent,
      ),
    );
  }
}
