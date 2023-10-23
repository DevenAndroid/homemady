import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
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
        appBar: backAppBar(title: 'Privacy Policy :', context: context),
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
              ],
            ),
          ) ,
        ) : const Center(child: CircularProgressIndicator()),
      );
    });
  }
}
