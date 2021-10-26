import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_learning/pages/flags.dart';
import 'package:my_learning/pages/pi.dart';
import 'package:my_learning/pages/roots.dart';
import 'package:my_learning/prefs.dart';
import 'package:my_learning/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nak? nak! Naknak nak?')),
      body: Center(
        child: Prefs.initialized
            ? ListView(
                children: [
                  cardButton(
                    'Pi lernen',
                    onPressed: () => push(context, const PiPage()),
                  ),
                  cardButton(
                    'Wurzeln ziehen',
                    onPressed: () => push(context, const RootsPage()),
                  ),
                  cardButton(
                    'Flaggen lernen',
                    onPressed: () => push(context, const FlagsPage()),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
