import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:homemady/routers/routers.dart';
import 'package:overlay_support/overlay_support.dart';
import 'service/custome_notification_headers.dart';
import 'service/notification_service.dart';

 const String stripeApiKey =
     "pk_test_xIudhR1N8ZnqHogumhfmpskw00NJg6zqor";

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true
  );
  await NotificationService().initializeNotification();
  await FlutterBranchSdk.init();
  if(kDebugMode){
    FlutterBranchSdk.validateSDKIntegration();
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Stripe.publishableKey = stripeApiKey;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    CustomNotificationHeaders customNotificationHeaders = CustomNotificationHeaders();
  @override
  Widget build(BuildContext context) {
    // customNotificationHeaders.context = context;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return OverlaySupport.global(
      child: GetMaterialApp(
        title: 'Homemady',
        key: snackBarKey,
        theme: ThemeData(
          fontFamily: 'poppinsSans',
          primarySwatch: Colors.green,
          useMaterial3: false
        ),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        getPages:MyRouters.route,
      ),
    );
  }
}