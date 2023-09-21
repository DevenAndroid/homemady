 import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:homemady/routers/routers.dart';
import 'package:web_socket_channel/io.dart';
 const String stripeApiKey =
     "pk_test_xIudhR1N8ZnqHogumhfmpskw00NJg6zqor";


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if(Platform.isAndroid){

    FlutterBranchSdk.validateSDKIntegration();
  }
  Stripe.publishableKey = stripeApiKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'Homemady',
      theme: ThemeData(
        fontFamily: 'poppinsSans',
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages:MyRouters.route,
    );
  }
}