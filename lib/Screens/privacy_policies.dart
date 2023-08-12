import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';

import '../controller/privacy_policy_controller.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final controller = Get.put(PrivacyController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getData();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(title: 'Privacy Policy', context: context),
        body: controller.isDataLoading.value ?
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 16),
            child: Column(
              children:  [
                Html(
                  data: controller.model.value.data!.content.toString(),
                  style: {
                  'body': Style(
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize(13 ),
                      color: const Color(0xFF363539)
                  )
                  },
                )
                /*Text.rich(
           TextSpan(
               children: [
                 TextSpan(
                   text: 'For users with a separate Doc Send or Drop Lorem  Sign account, the DocSend Terms of Service can found here, and the Lorem Sign Terms of Service can found here',
                     style: TextStyle(
                         fontWeight: FontWeight.w400,
                         fontSize: 13,
                         color: Color(0xFF363539)
                     )
                 ),  */
                /*TextSpan(
                   text: ' here.',
                     style: TextStyle(
                         fontWeight: FontWeight.w400,
                         fontSize: 13,
                         color: Color(0xFF7968E2)
                     )
                 ),*//*
               ]
           )
         ),*/
                /*   addHeight(10),
              const Text('Thanks for using Dropbox! Our mission is to create a more enlightened way of working, and help you and those you work with stay coordinated. We do so by providing an intuitive, unified platform and suite of apps and services that keep your content safe, accessible and in sync. These terms of service (“Terms”) cover your use and access to our services',
                 style: TextStyle(
                     fontWeight: FontWeight.w400,
                     fontSize: 13,
                     color: Color(0xFF363539)
                 ),),
               addHeight(10),
              const Text('When you use our Services, you provide us with things like your files, content, messages, contacts, and so on (“Your Stuff”). Your Stuff is yours.',
                 style: TextStyle(
                     fontWeight: FontWeight.w400,
                     fontSize: 13,
                     color: Color(0xFF363539)
                 ),),
               addHeight(10),
              const Text('unified platform and suite of apps and services that keep your content safe, accessible and in sync. These terms of service (“Terms”) cover your use and access to our ',
                 style: TextStyle(
                     fontWeight: FontWeight.w400,
                     fontSize: 13,
                     color: Color(0xFF363539)
                 ),),
               addHeight(10),
              const Text('unified platform and suite of apps and services that keep your content safe, accessible and in sync. These terms of service (“Terms”) cover your use and access to our ',
                 style: TextStyle(
                     fontWeight: FontWeight.w400,
                     fontSize: 13,
                     color: Color(0xFF363539)
                 ),),*/
              ],
            ),
          ) ,
        ) : const Center(child: CircularProgressIndicator()),
      );
    });
  }
}
