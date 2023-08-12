import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/app_theme.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:share_plus/share_plus.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({Key? key}) : super(key: key);
  static var referAndEarnScreen = "/referAndEarnScreen";

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  final key = GlobalKey<ScaffoldState>();
  final String _copy = "YAF5KJHGCX45YTUY";
  void onShare(code,BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(code,
        subject: "link",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
      body:
    //  Obx(() {
       // return controller.isLoadingData.value?SingleChildScrollView(
          //  child:
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                      Text('Earn Free €5.00',
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
                            .headline5!
                            .copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: AppTheme.blackcolor),
                      ),
                      SizedBox(
                        height: height * .005,
                      ),
                      Text(
                        "Share you referral link and\nearn \€5.00",
                        textAlign: TextAlign.center,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5!
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
                                    Text('YAF5KJHGCX45YTUY',style: TextStyle(
                                        color: Color(0xFF7F8492),fontSize: AddSize.size16,fontWeight: FontWeight.w400),),
                                  ]),
                                ),
                                GestureDetector(
                                  onTap: () async{
                                      await Share.share('HomeMady ');
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
                      Text('Earn Free €5.00',style: TextStyle(
                          color: Color(0xFF423E5E),fontSize: AddSize.size22,fontWeight: FontWeight.w600),),
                      SizedBox(
                        height: height * .005,
                      ),
                      Text(
                        "For any account you connect",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5!
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
                            gradient: LinearGradient(
                                colors: const[
                                  Color(0xFF6AC743),
                                  Color(0xFF6AC743),
                                ]
                            )
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                             // onShare(controller.referAndEarnModel.value.data!.referCode.toString(),context);
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(10),
                                minimumSize: const Size(double.maxFinite, 55),
                                primary: Colors.transparent,
                                elevation: 0,
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            child: Text(
                              "SHARE",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline5!
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
            )
    //)
       //     :Center(child: CircularProgressIndicator());
    //  }
     // ),
    );
  }
}
