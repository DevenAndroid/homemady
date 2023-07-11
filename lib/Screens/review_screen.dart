import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homemady/routers/routers.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: 'Send Feedback', context: context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
              CommonButton(title: 'Skip',onPressed: (){
                Get.toNamed(MyRouters.bottomNavbar);
                  print("object");
              },),
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
