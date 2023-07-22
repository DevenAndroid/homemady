import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homemady/repository/ratingreview_repo.dart';
import 'package:homemady/resources/add_text.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:homemady/widgets/editprofiletextfiled.dart';

import '../controller/order_details_controller.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final _formKey = GlobalKey<FormState>();

  final controller = Get.put(OrderDetailsController());
  String ratingvalue = '';
  double fullRating = 0;
  bool _isValue = false;
  bool _isValue1 = false;
  bool _isValue2 = false;
  bool _isValue3 = false;
  bool _isValue4 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: 'Send Feedback', context: context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
           padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 8.0),
                 child:  Text('How did we do?',
                   style: TextStyle(
                   color: Color(0xFF1A1917),
                   fontWeight: FontWeight.w700,
                   fontSize: 15
                 ),),
               ),
              addHeight(20),
              RatingBar.builder(
                initialRating: 6,
                glowColor: Colors.white10,
                minRating: 1,
                unratedColor: const Color(0xFFE0DEDA),
                itemCount: 6,
                itemSize: 34.0,
                itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                updateOnDrag: true,
                allowHalfRating: true,
                itemBuilder: (context, index) =>
                    Image.asset('assets/images/star.png',
                      color: Colors.amber,
                    ),
                onRatingUpdate: (rating) {
                  log(double.parse(rating.toString())
                      .round()
                      .toString());
                  setState(() {
                    ratingvalue = double.parse(rating.toString()).round().toString();
                  });
                },
              ),
              addHeight(25),
          //     ...List.generate(5, (index)
          //        {
          //       return Column(
          //   children: [
          //     Row(
          //       children: [
          //         Checkbox(
          //             activeColor: AppTheme.primaryColor,
          //             shape: RoundedRectangleBorder(
          //                 borderRadius:
          //                 BorderRadius.circular(5)),
          //             value: _isValue,
          //             onChanged: (bool? value) {
          //               setState(() {
          //                 _isValue = value;
          //               });
          //             }),
          //       ],
          //     ),
          //   ],
          // );
          //        }
          //
          //     ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                            activeColor: Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue,
                            onChanged: ( value) {
                              setState(() {
                                _isValue = value!;
                              });
                            }),
                      ),
                      const Text("Food Quality",style: TextStyle(
                          color: Color(0xFF969AA3),
                          fontWeight: FontWeight.w400,
                          fontSize: 15
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                            activeColor: Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue1,
                            onChanged: (value) {
                              setState(() {
                                _isValue1 = value!;
                              });
                            }),
                      ),
                      const Text(" Food Quantity",style: TextStyle(
                          color: Color(0xFF969AA3),
                          fontWeight: FontWeight.w400,
                          fontSize: 15
                      ),),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                        side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                        activeColor: Color(0xff7ED957),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(3)),
                        value: _isValue2,
                        onChanged: ( value) {
                          setState(() {
                            _isValue2 = value!;
                          });
                        }),
                  ),
                  const Text("Communication",style: TextStyle(
                      color: Color(0xFF969AA3),
                      fontWeight: FontWeight.w400,
                      fontSize: 15
                  ),),
                  const SizedBox(width: 35,),
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                        side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                        activeColor: Color(0xff7ED957),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(3)),
                        value: _isValue3,
                        onChanged: (value) {
                          setState(() {
                            _isValue3 = value!;
                          });
                        }),
                  ),
                  const Text("Hygiene",style: TextStyle(
                      color: Color(0xFF969AA3),
                      fontWeight: FontWeight.w400,
                      fontSize: 15
                  ),)
                ],
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                        side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                        activeColor: Color(0xff7ED957),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(3)),
                        value: _isValue4,
                        onChanged: ( value) {
                          setState(() {
                            _isValue4 = value!;
                          });
                        }),
                  ),
                  const Text("Delivery",style: TextStyle(
                      color: Color(0xFF969AA3),
                      fontWeight: FontWeight.w400,
                      fontSize: 15
                  ),),

                ],
              ),
              addHeight(30),
              DottedLine(
              dashColor: Colors.grey.shade300,
              ),
              addHeight(20),
              const Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 8.0),
                 child: Text('Care to share more about it?',
                  style: TextStyle(
                      color: Color(0xFF1A1917),
                      fontWeight: FontWeight.w600,
                      fontSize: 15
                  ),),
               ),
              addHeight(10),
              EditProfileTextFieldWidget(
                onTap: (){},
                minLines: 8,
                maxLines: null,
              ),
              addHeight(25),
              CommonButton(title: 'Publish Feedback',onPressed: (){
               ratingReviewRepo(storeId: controller.model.value.data!.vendor!.id.toString(),type: 'driver', driverId: '45', rating: ratingvalue, foodQuality: _isValue, foodQuantity: _isValue1, communication: _isValue2, hygiene: _isValue3, delivery: _isValue4, context: context).then((value) {
                 if(value.status == true){
                   showToast(value.message.toString());
                   Get.toNamed(MyRouters.feedBackScreen);
                 }
                 else {
                   showToast(value.message.toString());
                 }
               });

                 // print("object");
              },),
              addHeight(25),
               Center(
                 child: GestureDetector(
                   onTap: (){
                     Get.back();
                   },
                   child: const Text("Skip",style: TextStyle(
                       color: Colors.black,
                       fontWeight: FontWeight.w700,
                       fontSize: 19
                   ),),
                 ),
               ),
              // CommonButton(title: 'Skip',onPressed: (){
              //   Get.toNamed(MyRouters.bottomNavbar);
              //     print("object");
              // },),
              addHeight(16),
              // const Text('Your review will be posted to the Google Play store.',
              //   style: TextStyle(
              //       color: Color(0xFFA3A29E),
              //       fontWeight: FontWeight.w600,
              //       fontSize: 13
              //   ),),
            ],
          ),
        ),
      ),
    );
  }
}
