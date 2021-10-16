import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_learning/prefs.dart';
import 'package:my_learning/theme.dart';
import 'package:my_learning/utils.dart';

class RootsPage extends StatefulWidget {
  const RootsPage({Key? key}) : super(key: key);

  @override
  _RootsPageState createState() => _RootsPageState();
}

class _RootsPageState extends State<RootsPage> {
  final _resultTextFocusNode = FocusNode();
  final _resultTextEditingController = TextEditingController();

  int _score = 0;
  late int _rootDegree, _origNumber;

  _RootsPageState() {
    _origNumber = _randOrig;
    _rootDegree = _randDegree;
  }

  int get _randOrig => Random.secure().nextInt(99) + 1;
  int get _randDegree => Random.secure().nextBool() ? 2 : 3;

  void next(int input) {
    if (_origNumber == input) {
      _score += 1;

      if (_score > Prefs.rootsHighscore) {
        Prefs.rootsHighscore = _score;
      }
    } else {
      _score = 0;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$_origNumber'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    _origNumber = _randOrig;
    _rootDegree = _randDegree;

    setState(() {});
  }

  static TableRow _rootsRow(int base, int exp) {
    var a = pow(base, exp);
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(5), child: Text('$base')),
        Padding(padding: const EdgeInsets.all(5), child: Text('$a')),
        Padding(padding: const EdgeInsets.all(5), child: Text('${a % 10}')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text('Score: $_score'),
          subtitle: Text('Highscore: ${Prefs.rootsHighscore}'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Table(
                    border: TableBorder.all(
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                    children:
                        List.generate(10, (i) => _rootsRow(i + 1, _rootDegree)),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.help),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${_rootDegree}te Wurzel aus ${pow(_origNumber, _rootDegree)}',
                    style: const TextStyle(fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: TextField(
                      autofocus: true,
                      focusNode: _resultTextFocusNode,
                      controller: _resultTextEditingController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (s) {
                        _resultTextFocusNode.requestFocus();
                        _resultTextEditingController.clear();
                        setState(() {});

                        var i = int.tryParse(s.clean());
                        if (i == null) return;

                        next(i);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
