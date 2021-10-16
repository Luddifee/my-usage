import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:my_learning/data/country_codes.dart';
import 'package:my_learning/prefs.dart';
import 'package:my_learning/utils.dart';

class FlagsPage extends StatefulWidget {
  const FlagsPage({Key? key}) : super(key: key);

  @override
  _FlagsPageState createState() => _FlagsPageState();
}

class _FlagsPageState extends State<FlagsPage> {
  final _countryTextKey = GlobalKey();
  final _countryTextFocusNode = FocusNode();
  final _countryTextEditingController = TextEditingController();

  int _score = 0;
  late String _code;

  _FlagsPageState() {
    _code = _randomCode;
  }

  String get _randomCode => countryCodesEn.keys
      .elementAt(Random.secure().nextInt(countryCodesEn.length));

  void next(String code) {
    if (code == _code) {
      _score += 1;
      if (_score > Prefs.flagsHighscore) {
        Prefs.flagsHighscore = _score;
      }
    } else {
      _score = 0;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(countryCodes[_code] ?? 'Unbekanntes Land'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    _code = _randomCode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text('Score: $_score'),
          subtitle: Text('Highscore: ${Prefs.flagsHighscore}'),
        ),
        actions: [
          TextButton(
            onPressed: () => setState(() => toggleCountryLang()),
            child: Text(Prefs.flagsLang.toUpperCase()),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidthMargin(context, 250),
                ),
                child: Image.asset(
                  'assets/flags/$_code.png',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidthMargin(context, 250),
                ),
                child: TypeAheadField(
                  key: _countryTextKey,
                  errorBuilder: (context, _) => Container(),
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
                    focusNode: _countryTextFocusNode,
                    controller: _countryTextEditingController,
                  ),
                  suggestionsCallback: (s) => (countryCodes).entries.where(
                        (e) =>
                            e.key == s.clean() ||
                            e.value
                                .toLowerCase()
                                .contains(s.clean().toLowerCase()),
                      ),
                  itemBuilder: (context, data) => Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 5,
                    ),
                    child: Text(
                      (data as MapEntry<String, String>).value,
                    ),
                  ),
                  onSuggestionSelected: (e) {
                    _countryTextEditingController.clear();
                    next((e as MapEntry<String, String>).key);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
