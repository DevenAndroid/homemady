import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/controller/referandearn_controller.dart';
import 'package:homemady/widgets/app_theme.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:share_plus/share_plus.dart';

import '../controller/deeplinking_Controller.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({Key? key}) : super(key: key);
  static var referAndEarnScreen = "/referAndEarnScreen";

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  final shareController = Get.put(DeepLinkingController());
  final controller = Get.put(ReferAndEranController());
  final key = GlobalKey<ScaffoldState>();
  final String _copy = "YAF5KJHGCX45YTUY";
  BranchContentMetaData metadata = BranchContentMetaData();
  BranchUniversalObject? buo;
  BranchLinkProperties lp = BranchLinkProperties();
  StreamController<String> controllerUrl = StreamController<String>();
 // String? = controller.model.value.data!.referCode.toString();
  void onShare(code,BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(code,
        subject: "link",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
  getDataSubscription() {
    generateLink(
        BranchUniversalObject(
            canonicalIdentifier: 'flutter/branch',
            canonicalUrl: '',
            title: '',
            contentDescription: '',
            contentMetadata: BranchContentMetaData()..addCustomMetadata('referralCode', 47),
            keywords: ['Plugin', 'Branch', 'Flutter'],
            publiclyIndex: true,
            locallyIndex: true,
            expirationDateInMilliSec: DateTime.now().add(const Duration(days: 365)).millisecondsSinceEpoch),
        BranchLinkProperties(
            channel: 'facebook',
            feature: 'sharing',
            stage: 'new share',
            campaign: 'campaign',
            tags: ['one', 'two', 'three']));
    // Get.toNamed(ThankuScreen.thanku);
    setState(() {});
  }
  void initDeepLinkData() {
    metadata = BranchContentMetaData()
      ..addCustomMetadata('referralCode', 47)
    //--optional Custom Metadata
      ..contentSchema = BranchContentSchema.COMMERCE_PRODUCT
      ..price = 50.99
      ..currencyType = BranchCurrencyType.BRL
      ..quantity = 50
      ..sku = 'sku'
      ..productName = 'productName'
      ..productBrand = 'productBrand'
      ..productCategory = BranchProductCategory.ELECTRONICS
      ..productVariant = 'productVariant'
      ..condition = BranchCondition.NEW
      ..rating = 100
      ..ratingAverage = 50
      ..ratingMax = 100
      ..ratingCount = 2
      ..setAddress(street: 'street', city: 'city', region: 'ES', country: 'Brazil', postalCode: '99999-987')
      ..setLocation(31.4521685, -114.7352207);

    buo = BranchUniversalObject(
        canonicalIdentifier: 'flutter/branch',
        canonicalUrl: '',
        title: '',
        contentDescription: '',
        contentMetadata: metadata,
        keywords: ['Plugin', 'Branch', 'Flutter'],
        publiclyIndex: true,
        locallyIndex: true,
        expirationDateInMilliSec: DateTime.now().add(const Duration(days: 365)).millisecondsSinceEpoch);

    lp = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        stage: 'new share',
        campaign: 'campaign',
        tags: ['one', 'two', 'three'])
      ..addControlParam('\$uri_redirect_mode', '1');
  }
  void generateLink(BranchUniversalObject? buo, BranchLinkProperties lp) async {
    BranchResponse response = await FlutterBranchSdk.getShortUrl(buo: buo!, linkProperties: lp);
    if (response.success) {
      controllerUrl.sink.add('${response.result}');
      controller.model.value.data!.referCode = response.result;
      setState(() {});
    } else {
      controllerUrl.sink.add('Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getData();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: InkWell(
              onTap: (){
                Get.back();
              },
              child: const Icon(Icons.arrow_back,color: Colors.black,),
            ),
            title: Text('Refer And Earn',
              style:GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: const Color(0xFF1A2E33)
              ),
            ),),
          body: controller.isDataLoading.value ?
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * .01),
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * .02,
                    ),
                    Image.asset('assets/images/referimg.png'),
                    SizedBox(
                      height: height * .03,
                    ),
                    Text('Earn Free €${controller.model.value.data!.referAmount.toString()}',
                      style: TextStyle(
                          color: const Color(0xFF6BC744),fontSize: AddSize.size22,fontWeight: FontWeight.w600),),
                    /*Text(
                        "Earn Free \$${controller.referAndEarnModel.value.data!.referAmount.toString()}",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5!
                            .copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: AppTheme.primaryColor),
                      ),*/
                    SizedBox(
                      height: height * .005,
                    ),
                    Text(
                      "For every new user your refer",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppTheme.blackcolor),
                    ),
                    SizedBox(
                      height: height * .005,
                    ),
                    Text(
                      "Share you referral link and\nearn €${controller.model.value.data!.referAmount.toString()}",
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: AppTheme.subText),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppTheme.backgroundcolor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                // offset: Offset(2, 2),
                                blurRadius: 15)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04, vertical: height * .02),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                // onTap: () {
                                //   Clipboard.setData(
                                //       ClipboardData(text: controller.referAndEarnModel.value.data!.referCode.toString()
                                //        //   text: controller.referAndEarnModel.value.data!.referCode.toString()
                                //       ))
                                //       .then((value) =>
                                //       Fluttertoast.showToast(
                                //           msg: "Copied",
                                //           gravity: ToastGravity.CENTER));
                                // },
                                child: Row(children: [
                                  Image.asset('assets/images/Copied.png',height: 21,),
                                  // Image(
                                  //     height: height * .03,
                                  //     width: width * .05,
                                  //     fit: BoxFit.cover,
                                  //     image: const AssetImage(
                                  //         AppAssets.shareIcon1)),
                                  SizedBox(
                                    width: width * .04,
                                  ),

                                  /*Text(controller.referAndEarnModel.value.data!.referCode.toString(),
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),*/
                                  Text(controller.model.value.data!.referCode.toString(),style: TextStyle(
                                      color: const Color(0xFF7F8492),fontSize: AddSize.size16,fontWeight: FontWeight.w400),),
                                ]),
                              ),
                              GestureDetector(
                                onTap: () {
                                  shareController.generateLink("",referralCode: controller.model.value.data!.referCode.toString());
                                  //onShare(controller.model.value.data!.referCode.toString(), context) ;
                                  // onShare(controller.referAndEarnModel.value.data!.referCode.toString(),context);
                                },
                                child: const Icon(
                                  Icons.share_outlined,
                                  color: Color(0xFF6BC744),
                                  size: 25,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    /* Text(
                        "Earn Free \$${controller.referAndEarnModel.value.data!.referAmount.toString()}",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5!
                            .copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: AppTheme.blackcolor),
                      ),*/
                    Text('Earn Free €${controller.model.value.data!.referAmount.toString()}',style: TextStyle(
                        color: const Color(0xFF423E5E),fontSize: AddSize.size22,fontWeight: FontWeight.w600),),
                    SizedBox(
                      height: height * .005,
                    ),
                    Text(
                      "For any account you refer",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppTheme.blackcolor),
                    ),
                    SizedBox(
                      height: height * .06,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xFF6AC743),
                                Color(0xFF6AC743),
                              ]
                          )
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            shareController.generateLink("",referralCode: controller.model.value.data!.referCode.toString());
                            // onShare(controller.referAndEarnModel.value.data!.referCode.toString(),context);
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10), backgroundColor: Colors.transparent,
                              minimumSize: const Size(double.maxFinite, 55),
                              elevation: 0,
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          child: Text(
                            "SHARE",
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                color: AppTheme.backgroundcolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ): const Center(child: CircularProgressIndicator())
        //)
        //     :Center(child: CircularProgressIndicator());
        //  }
        // ),
      );
    });
  }
}
