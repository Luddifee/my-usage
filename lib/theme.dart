import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

bool get darkMode =>
    SchedulerBinding.instance!.window.platformBrightness == Brightness.dark;

ThemeData get theme => darkMode ? ThemeData.dark() : ThemeData.light();
