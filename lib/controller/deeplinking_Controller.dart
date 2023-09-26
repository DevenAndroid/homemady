import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:homemady/controller/user_profile_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeepLinkingController extends GetxController{
  String? referralLink;
  // String? productId;

  void onShare(code, BuildContext context) async {
    // final box = context.findRenderObject() as RenderBox?;
    await Share.share(code, subject: "link",);
  }

  BranchContentMetaData metadata = BranchContentMetaData();
  BranchUniversalObject? buo;
  BranchLinkProperties lp = BranchLinkProperties();
  BranchEvent? eventStandard;
  BranchEvent? eventCustom;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();
  StreamController<String> controllerUrl = StreamController<String>();
  final profileController = Get.put(UserProfileController());
 // final profileController = Get.put(ProfileController());
  void generateLink(String productId, {String? referralCode}) async {
    metadata = BranchContentMetaData();
    // ..addCustomMetadata('productId', productId)
    // ..addCustomMetadata('referralCode', referralCode);
    metadata.addCustomMetadata("productId", productId);
    if(referralCode != null) {
      metadata.addCustomMetadata("referralCode", referralCode);
    }
    log("metadata...       "+metadata.toMap().toString());

    buo = BranchUniversalObject(
      imageUrl: "assets/images/burgerIcon.png",
        canonicalIdentifier: 'flutter/branch',
        canonicalUrl: '',
        title: '',
        contentDescription: '',
        contentMetadata: metadata,
        keywords: ['Plugin', 'Branch', 'Flutter'],
        publiclyIndex: true,
        locallyIndex: true,
        expirationDateInMilliSec: DateTime.now()
            .add(const Duration(days: 365))
            .millisecondsSinceEpoch);

    lp = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        stage: 'new share',
        campaign: 'campaign',
        tags: ['one', 'two', 'three'])
      ..addControlParam('\$uri_redirect_mode', '1');
    BranchResponse response =
    await FlutterBranchSdk.getShortUrl(buo: buo!, linkProperties: lp);
    if (response.success) {
      controllerUrl.sink.add('${response.result}');
      referralLink = response.result;
      log("referralLink $productId");

      Share.share(referralLink!, subject: "link");
      log("referralLink $referralLink");
    } else {
      controllerUrl.sink
          .add('Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }
}