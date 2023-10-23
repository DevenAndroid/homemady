import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemady/repository/ratingreview_repo.dart';
import 'package:homemady/resources/add_text.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homemady/widgets/editprofiletextfiled.dart';

import '../controller/order_details_controller.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final orderDetailsController = Get.put(OrderDetailsController());
  final _formKey = GlobalKey<FormState>();

  final controller = Get.put(OrderDetailsController());
  String ratingvalue1 = '';
  String ratingvalue2 = '';
  String ratingvalue3 = '';
  String ratingvalue4 = '';
  String ratingvalue5 = '';
  double fullRating = 0;
  final bool _isValue = false;
  final bool _isValue1 = false;
  final bool _isValue2 = false;
  final bool _isValue3 = false;
  final bool _isValue4 = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: backAppBar(title: 'Send Feedback', context: context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Happy with your order ?',
                  style: TextStyle(
                      color: Color(0xFF1A1917),
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                  ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height *.034,
                ),
                 const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Food Quality',style: TextStyle(
                        color: Color(0xFF1A1917),
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *.013,
                ),
                FittedBox(
                  child: RatingBar.builder(
                    initialRating: 6,
                    glowColor: Colors.white10,
                    minRating: 1,
                    unratedColor: const Color(0xFFE0DEDA),
                    itemCount: 7,
                    itemSize: 22.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        ratingvalue1 = double.parse(rating.toString()).round().toString();
                        print("Rating 1.....$ratingvalue1");
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *.022,
                ),
                 const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Communication',style: TextStyle(
                          color: Color(0xFF1A1917),
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ),),
                    ),

                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *.013,
                ),
                FittedBox(
                  child: RatingBar.builder(
                    initialRating: 6,
                    glowColor: Colors.white10,
                    minRating: 1,
                    unratedColor: const Color(0xFFE0DEDA),
                    itemCount: 7,
                    itemSize: 22.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        ratingvalue2 = double.parse(rating.toString()).round().toString();
                        print("Rating 2.....$ratingvalue2");
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *.022,
                ),
                 const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Hygiene',style: TextStyle(
                          color: Color(0xFF1A1917),
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ),),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *.013,
                ),
                FittedBox(
                  child: RatingBar.builder(
                    initialRating: 6,
                    glowColor: Colors.white10,
                    minRating: 1,
                    unratedColor: const Color(0xFFE0DEDA),
                    itemCount: 7,
                    itemSize: 22.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        ratingvalue3 = double.parse(rating.toString()).round().toString();
                        print("Rating 3.....$ratingvalue3");
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *.022,
                ),
                 const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Food Quantity',style: TextStyle(
                          color: Color(0xFF1A1917),
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ),),
                    ),

                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *.013,
                ),
                FittedBox(
                  child: RatingBar.builder(
                    initialRating: 6,
                    glowColor: Colors.white10,
                    minRating: 1,
                    unratedColor: const Color(0xFFE0DEDA),
                    itemCount: 7,
                    itemSize: 22.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        ratingvalue4 = double.parse(rating.toString()).round().toString();
                        print("Rating 4.....$ratingvalue4");
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *.022,
                ),
                 const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Delivery',style: TextStyle(
                          color: Color(0xFF1A1917),
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ),),
                    ),

                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *.013,
                ),
                FittedBox(
                  child: RatingBar.builder(
                    initialRating: 1,
                    glowColor: Colors.white10,
                    minRating: 1,
                    unratedColor: const Color(0xFFE0DEDA),
                    itemCount: 7,
                    itemSize: 22.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        ratingvalue5 = double.parse(rating.toString()).round().toString();
                        print("Rating 5.....$ratingvalue5");
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *.10,
                ),
                const Text('Care to share more about it?',
                  style: TextStyle(
                      color: Color(0xFF1A1917),
                      fontWeight: FontWeight.w600,
                      fontSize: 15
                  ),),
                addHeight(10),
                EditProfileTextFieldWidget(
                  controller: controller.feedbackController,
                  onTap: (){},
                  minLines: 5,
                  maxLines: 10,
                ),
                addHeight(25),

                CommonButton(title: 'Publish Feedback',onPressed: (){
                  ratingReviewRepo(
                      orderId: controller.model.value.orderDetail!.orderId.toString(),
                      review:controller.feedbackController.text,
                      foodQuality: ratingvalue1.toString(),
                      foodQuantity: ratingvalue2.toString(),
                      communication: ratingvalue3.toString(),
                      hygiene: ratingvalue4.toString(),
                      delivery: ratingvalue5.toString(),
                      context: context).then((value) {
                    if(value.status == true){
                      Get.back();
                      Get.back();
                      controller.feedbackController.clear();
                      orderDetailsController.getData();
                      showToast(value.message.toString());
                     // Get.toNamed(MyRouters.thankYouScreen);
                    }
                    else {

                     // showToast(value.message.toString());
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
      ),
    );
  }
}
