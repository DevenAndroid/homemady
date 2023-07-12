import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/app_theme.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:homemady/widgets/editprofiletextfiled.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double fullRating = 0;
  bool? _isValue = false;
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
               const Text('How did we do?',
                 style: TextStyle(
                 color: Color(0xFF1A1917),
                 fontWeight: FontWeight.w900,
                 fontSize: 15
               ),),
              addHeight(16),

              RatingBar.builder(
                initialRating: 4,
                glowColor: Colors.white10,
                minRating: 1,
                unratedColor: const Color(0xFFE0DEDA),
                itemCount: 5,
                itemSize: 48.0,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                updateOnDrag: true,
                allowHalfRating: true,
                itemBuilder: (context, index) =>
                    Image.asset('assets/images/star.png',
                      color: Colors.amber,
                    ),
                onRatingUpdate: (ratingvalue) {
                  setState(() {
                    fullRating = ratingvalue;
                  });
                },
              ),
              addHeight(20),
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
              Column(
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,

                        child: Checkbox(
                            activeColor: Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue = value;
                              });
                            }),
                      ),
                      const Text("Food Quality",style: TextStyle(
                          color: Color(0xFF969AA3),
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),),
                      SizedBox(width: 35,),
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            activeColor: Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue = value;
                              });
                            }),
                      ),
                      const Text(" Food Quantity",style: TextStyle(
                          color: Color(0xFF969AA3),
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),)
                    ],
                  ),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            activeColor: Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue = value;
                              });
                            }),
                      ),
                      const Text("Communication",style: TextStyle(
                          color: Color(0xFF969AA3),
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),),
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            activeColor: Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue = value;
                              });
                            }),
                      ),
                      const Text("Hygiene",style: TextStyle(
                          color: Color(0xFF969AA3),
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),)
                    ],
                  ),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            activeColor: Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue = value;
                              });
                            }),
                      ),
                      const Text("Delivery",style: TextStyle(
                          color: Color(0xFF969AA3),
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),),

                    ],
                  ),
                ],
              ),

              addHeight(50),
              DottedLine(
              dashColor: Colors.grey.shade300,
              ),
              addHeight(20),
              const Text('Care to share more about it?',
                style: TextStyle(
                    color: Color(0xFF1A1917),
                    fontWeight: FontWeight.w600,
                    fontSize: 14
                ),),
              addHeight(10),
              EditProfileTextFieldWidget(
                onTap: (){},
                minLines: 8,
                maxLines: null,
              ),
              addHeight(25),
              DottedLine(
                dashColor: Colors.grey.shade300,
              ),
              addHeight(25),
              CommonButton(title: 'Publish Feedback',onPressed: (){
                Get.toNamed(MyRouters.feedBackScreen);
                  print("object");
              },),
              addHeight(15),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Skip",style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 19
                  ),),
                ],
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
