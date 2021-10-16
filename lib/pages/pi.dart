import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_learning/data/pi_digits.dart';
import 'package:my_learning/prefs.dart';
import 'package:my_learning/utils.dart';

class PiPage extends StatefulWidget {
  const PiPage({Key? key}) : super(key: key);

  @override
  _PiPageState createState() => _PiPageState();
}

class _PiPageState extends State<PiPage> {
  final _piTextEditingController = TextEditingController();

  int _currentDigit = 0;

  String get _digitText {
    const len = 13;

    var res = '';

    int i = max(0, _currentDigit - len);
    while (i < _currentDigit) {
      res += pi_digits[i].toString();
      i += 1;
    }

    if (_currentDigit < len - 1) {
      res = '3.' + res;
    } else {
      res = '...' + res;
    }

    return res;
  }

  void step(int digit) {
    var d = pi_digits[_currentDigit];
    if (digit != d) {
      _currentDigit = max(0, _currentDigit - 3);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('3 digits back ($d)'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      _currentDigit += 1;

      if (_currentDigit > Prefs.piHighscore) {
        Prefs.piHighscore = _currentDigit;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text('Score: $_currentDigit'),
          subtitle: Text('Highscore: ${Prefs.piHighscore}'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _digitText,
                  style: const TextStyle(
                    fontSize: 44,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: TextField(
                    autofocus: true,
                    controller: _piTextEditingController,
                    keyboardType: TextInputType.number,
                    onChanged: (s) {
                      _piTextEditingController.clear();
                      setState(() {});

                      if (s.length != 1 || !digits.contains(s[0])) return;

                      var i = int.tryParse(s);
                      if (i == null) return;
                      step(i);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
