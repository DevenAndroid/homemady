import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:salesiq_mobilisten/launcher.dart';
import 'package:salesiq_mobilisten/salesiq_mobilisten.dart';
import 'package:url_launcher/url_launcher.dart';

import '../routers/routers.dart';




class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);
  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  void sendEmail() async {
    // Change the email address and subject to suit your needs
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'mailto:support@homemady.com',
      query: '',
    );

    // if (await canLaunch(params.toString())) {
    await launch(params.toString());
    // } else {
    //   throw 'Could not launch email';
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: backAppBar(title: 'Help Center', context: context),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                // mailToAdminRepo().then((value){
                //   if(value.status==true){
                //     NewHelper.showToast(value.message);
                //   }
                // });
                sendEmail();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF37C666).withOpacity(0.10),
                      offset: const Offset(
                        .1,
                        .1,
                      ),
                      blurRadius: 20.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/helpMsg.png',
                      width: 52,
                      height:40,
                    ),
                    const SizedBox(width: 20,),
                    const Expanded(
                      child:  Text("Email HomeMady Support",
                        style:TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: Color(0xFF1A2E33)
                        ),),
                    ),
                  ],
                ),
              ),
            ),
            addHeight(15),
            InkWell(
              onTap: (){
                print("aaaaa...........");
                if (Platform.isIOS || Platform.isAndroid) {
                  String appKey;
                  String accessKey;
                  if (Platform.isIOS) {
                    appKey = "CXSxB2zDTR92eCpY2B9Ar7fJpCdLj5EA4xwT0nLKXx7WU5yivlXE6U5XBR8ptcf%2B";
                    accessKey = "czr96nQAmURlIp0QfhdgmKwx0KfVWpqqjymaXq0fDdDsbRADfg%2Fb3l2jov6QDmeC7trYc%2FHkd3cfnrlsdo4FyGjRy5sJGueCoizmImVkEkmSQ3Ke1FwZ%2Bw%3D%3D";
                  } else {
                    appKey = "CXSxB2zDTR92eCpY2B9Ar7fJpCdLj5EA4xwT0nLKXx7WU5yivlXE6U5XBR8ptcf%2B";
                    accessKey = "czr96nQAmUQn%2BokFyAG44hRqx8e2B8kEBn1b2iIYIe0cmuClIQs86k1y3ez0XUib%2F0feVTWmuweRAaJSWUUbBAvkuOmxi0ahpYvNZh4A8NP%2FN6rB8C9yUC37acWIuqhzwGvDn17nOuM%3D";
                  }
                  ZohoSalesIQ.init(appKey, accessKey).then((_) {
                    // initialization successful
                    ZohoSalesIQ.launcher.show(VisibilityMode.never);
                    ZohoSalesIQ.openNewChat();
                    // To show the default live chat launcher, you can use the launcher.show API.
                    // Alternatively, you may use the 'Avail floating chat button for your app' option under Settings → Brands → Installation → Android/iOS.
                  }).catchError((error) {
                    // initialization failed
                    print(error);
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF37C666).withOpacity(0.10),
                      offset: const Offset(
                        .1,
                        .1,
                      ),
                      blurRadius: 20.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/headphone.png',
                      width: 52,
                      height:40,
                    ),
                    const SizedBox(width: 20,),
                    const Expanded(
                      child: Text("Chat HomeMady Support",
                        style:TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: Color(0xFF1A2E33)
                        ),),
                    ),
                  ],
                ),
              ),
            ),
            addHeight(15),
            GestureDetector(
              onTap: (){
                Get.toNamed(MyRouters.faqsScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF37C666).withOpacity(0.10),
                      offset: const Offset(
                        .1,
                        .1,
                      ),
                      blurRadius: 20.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/faq.png',
                      width: 52,
                      height:40,
                    ),
                    const SizedBox(width: 20,),
                    const Text("FAQ",
                      style:TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color(0xFF1A2E33)
                      ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}


