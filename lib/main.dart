import 'package:flutter/material.dart';
import 'package:my_learning/pages/home.dart';
import 'package:my_learning/prefs.dart';
import 'package:my_learning/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const HomePage(),
    );
  }
}
