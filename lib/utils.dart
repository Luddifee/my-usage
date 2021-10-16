import 'package:flutter/material.dart';

Widget cardButton(
  String text, {
  void Function()? onPressed,
  Widget? icon,
  String? subtitle,
}) =>
    Card(
      child: ListTile(
        title: Text(text),
        onTap: onPressed,
        subtitle: subtitle != null ? Text(subtitle) : null,
        leading: icon,
      ),
    );

void push(BuildContext context, Widget page) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );

const digits = '0123456789';

double screenWidthMargin(BuildContext context, int max) {
  var f = MediaQuery.of(context).size.width;
  return f > max ? (f - max) / 2 : 0;
}

extension StringExtension on String {
  String clean() => trim().replaceAll(RegExp('\\s+'), ' ');
}
