// ignore_for_file: non_constant_identifier_names, file_names, avoid_print

import 'dart:developer';

import 'Variables.dart';

CustomPrint(var message) {
  if (isprint) {
    print(message);
  }
}

Customlog(var message) {
  if (isprint) {
    log(message.toString());
  }
}
