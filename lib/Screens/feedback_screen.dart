import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../widgets/custome_size.dart';


class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);
  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  double fullRating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: 'Feedback', context: context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10),
          child: Column(
            children: [
               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   const Text('6.8',style: TextStyle(
                      color: Color(0xFF1B233A),
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                    ),),
                   addWidth(26),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       RatingBar.builder(
                         initialRating: 4,
                         minRating: 1,
                         unratedColor: const Color(0xFFECE3D0),
                         itemCount: 5,
                         itemSize: 16.0,
                         itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                         updateOnDrag: true,
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
                      addHeight(3),
                     const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.0),
                        child:  Text('basad on 23 reviews',style: TextStyle(
                           color: Color(0xFF969AA3),
                           fontSize: 13,
                           fontWeight: FontWeight.w400,
                         ),),
                      ),
                     ],
                   ),
                 ],
               ),
                addHeight(15),
               ListView.builder(
                 shrinkWrap: true,
                 itemCount: 5,
                 itemBuilder: (context, index) {
                   return Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           const Text('Excellent',style: TextStyle(
                             color: Color(0xFF969AA3),
                             fontSize: 12,
                             fontWeight: FontWeight.w400,
                           ),),
                           LinearPercentIndicator(
                             lineHeight: 6.0,
                             barRadius: const Radius.circular(16),
                             backgroundColor: const Color(0xFFFAE9E4),
                             width: AddSize.screenWidth*0.71,
                             animation: true,
                             progressColor: const Color(0xFF5DAF5E),
                             percent: 0.7,
                             animationDuration: 1200,
                           ),
                         ],
                       ),
                       addHeight(4),
                     ],
                   );
                 },
               ),
              addHeight(20),
              const Divider(
                height: 1,
                thickness: 1.5,
                color: Color(0xFFE8F2EC),
              ),
              addHeight(20),
              ListView.builder(
                shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                     return Column(
                        children: [
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                Image.asset('assets/images/Ellipse 1563.png',height: 50,),
                               addWidth(20),
                               Expanded(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     const Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Text('Abhishek Jangid',
                                         style: TextStyle(
                                         color: Color(0xFF1B233A),
                                         fontSize: 16,
                                         fontWeight: FontWeight.w600,
                                     ),),
                                      ),
                                     addHeight(10),
                                     RatingBar.builder(
                                       initialRating: 4,
                                       minRating: 1,
                                       unratedColor: const Color(0xFFECE3D0),
                                       itemCount: 5,
                                       itemSize: 16.0,
                                       itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                       updateOnDrag: true,
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
                                     addHeight(7),
                                      Padding(
                                       padding: const  EdgeInsets.symmetric(horizontal: 5.0),
                                       child: RichText(
                                         text: const TextSpan(
                                             children: [
                                           TextSpan(
                                               text: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking...',
                                               style: TextStyle(
                                                 color: Color(0xFF969AA3),
                                                 fontSize: 13,
                                                 fontWeight: FontWeight.w300,
                                               
                                               )),
                                           TextSpan(
                                               text: 'read more',
                                               style: TextStyle(
                                                   fontSize: 13,
                                                   fontWeight: FontWeight.w400,
                                                   color: Color(0xFF567DF4)))
                                         ]),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                               // const Spacer(),
                               const Padding(
                                 padding:  EdgeInsets.symmetric(vertical: 3.0),
                                 child:  Text('Oct 23, 2022',style: TextStyle(
                                   color: Color(0xFF969AA3),
                                   fontSize: 12,
                                   fontWeight: FontWeight.w400,
                                 ),),
                               ),
                             ],
                           ),
                          SizedBox(
                            height: AddSize.size5,
                          ),
                          index != 2
                              ? const Divider()
                              : const SizedBox(),
                          SizedBox(
                            height: AddSize.size5,
                          ),
                        ],
                     );
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
