
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/my_cart_controller.dart';
import '../controller/coupon_list_controller.dart';
import '../repository/apply_coupon_repo.dart';
import '../resources/add_text.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({Key? key}) : super(key: key);
  static var couponsScreen = "/couponsScreen";

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  final couponController = Get.put(CouponController());
  final myCartController = Get.put(MyCartListController());
  final TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    couponController.getData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: backAppBar(title: "Coupons".tr, context: context),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: height * .01),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
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
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 14, bottom: 5),
                        child: CustomTextField1(
                          controller: codeController,
                          obSecure: false.obs,
                          hintText: 'Apply Promo Code'.obs,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: 36,
                              width: 94,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color(0xFF7ED957),
                                    Color(0xFF68C541),
                                  ]),
                                  borderRadius: BorderRadius.circular(100)),
                              child: GestureDetector(
                                onTap: () {
                                  applyCoupons(couponCode: codeController.text.toString(), context: context).then((value) {
                                    if (value.status == true) {
                                      showToast(value.message);
                                      codeController.clear();
                                      myCartController.getData();
                                      Get.back();
                                      setState(() {});
                                    } else if (value.status == false) {
                                      showToast(value.message);
                                    }
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    'Apply',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),

                  Obx(() {
                    return couponController.isDataLoading.value
                        ? couponController.model.value.data!.isEmpty ?
                    Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Center(
                        child: Text("Coupons Not Available".tr,
                          style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black),),
                      ),
                    )
                        :ListView.builder(
                        itemCount:
                        couponController.model.value.data!.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: height * .01),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              // height: height * .23,
                              child: Stack(
                                children: [
                                  Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04,),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Html(data:couponController
                                                      .model
                                                      .value
                                                      .data![index]
                                                      .couponDetails
                                                      .toString()),
                                                ),
                                                Container(
                                                  height: height * .04,
                                                  width: width * .10,
                                                  decoration:
                                                   ShapeDecoration(
                                                      color: Color(0xff7ED957).withOpacity(.10),
                                                      shape:
                                                      CircleBorder()),
                                                  child: Center(
                                                      child: Image(
                                                          height: height * .02,
                                                          width: width * .04,
                                                          color: Color(0xff7ED957),
                                                          image: const AssetImage(
                                                            AppAssets.couponList,))),
                                                )
                                              ],
                                            ),

                                            SizedBox(
                                              height: height * .005,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5,right: 5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Max Discount: "),
                                                  Text("€ ${couponController
                                                      .model
                                                      .value
                                                      .data![index]
                                                      .maxDiscount
                                                      .toString()}"),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5,right: 5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Min order value: "),
                                                  Text("€ ${couponController
                                                      .model
                                                      .value
                                                      .data![index]
                                                      .minOrderValue
                                                      .toString()}"),

                                                ],
                                              ),
                                            ),

                                            const Divider(),
                                            SizedBox(
                                              height: height * .005,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                DottedBorder(
                                                    borderType:
                                                    BorderType.RRect,
                                                    dashPattern: const [5, 5],
                                                    color:
                                                    Color(0xff7ED957),
                                                    strokeWidth: 1.5,
                                                    child: Container(
                                                      decoration:
                                                       BoxDecoration(
                                                          color: Color(0xff7ED957).withOpacity(.10),),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            width *
                                                                0.03,
                                                            vertical:
                                                            height *
                                                                .005),
                                                        child: Text(
                                                          couponController
                                                              .model
                                                              .value
                                                              .data![index]
                                                              .couponCode
                                                              .toString(),
                                                          style: Theme.of(
                                                              context)
                                                              .textTheme
                                                              .headline5!
                                                              .copyWith(
                                                              color: AppTheme
                                                                  .blackcolor,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    )),
                                                GestureDetector(
                                                  onTap: () {
                                                    applyCoupons(couponCode: couponController
                                                        .model
                                                        .value
                                                        .data![index]
                                                        .couponCode
                                                        .toString(), context: context).
                                                    then((value){
                                                      showToast(value.message);
                                                      if(value.status == true){
                                                        myCartController.getData();
                                                        // cartController.getCartData();
                                                        // controller.onItemTap(1);
                                                        Get.back();
                                                        setState(() {

                                                        });
                                                      }
                                                    });
                                                  },
                                                  child: Text(
                                                    "APPLY".tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                        color: Color(0xff7ED957),
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * .03,
                                            ),
                                          ],
                                        ),
                                      )),

                                ],
                              ));
                        })
                        : const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff7ED957)
                        ));
                  }),
                  addHeight(5),
                ],
              ),
            )));
  }
}
