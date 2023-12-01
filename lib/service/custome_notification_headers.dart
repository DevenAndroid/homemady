import 'dart:developer';

import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackBarKey =
GlobalKey<ScaffoldMessengerState>();

class CustomNotificationHeaders {
  static final CustomNotificationHeaders _instance = CustomNotificationHeaders._internal();
  // BuildContext? context;
  factory CustomNotificationHeaders() {
    return _instance;
  }

  CustomNotificationHeaders._internal() {
    // initialization logic
    log("My class initialized......       ${DateTime.now()}");
  }
}