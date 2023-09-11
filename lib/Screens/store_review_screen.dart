import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:readmore/readmore.dart';
import '../controller/review_screen_controller.dart';
import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';


class StoreReviewScreen extends StatefulWidget {
  const StoreReviewScreen({Key? key}) : super(key: key);
  static var storeReviewScreen = "/storeReviewScreen";
  @override
  State<StoreReviewScreen> createState() => _StoreReviewScreenState();
}

class _StoreReviewScreenState extends State<StoreReviewScreen> {
  final controller = Get.put(StoreRevierwController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getData();
  }
  double fullRating = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(title: 'Cook Review', context: context),
        body: controller.isDataLoading.value ?
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(controller.model.value.data!.avgRating.toString(),style: const TextStyle(
                      color: Color(0xFF1B233A),
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                    ),),
                    addWidth(26),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBar.builder(
                          initialRating: double.parse(controller.model.value.data!.avgRating.toString()),
                          minRating: 1,
                          unratedColor: const Color(0xFFECE3D0),
                          itemCount: 7,
                          itemSize: 16.0,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          updateOnDrag: false,
                          tapOnlyMode: false,
                          ignoreGestures: true,
                          allowHalfRating: true,

                          itemBuilder: (context, index) =>
                              Image.asset('assets/images/star.png',
                                color: Colors.amber,
                              ),
                          onRatingUpdate: (rating) {
                            log(rating.toString());
                          },
                        ),
                        addHeight(3),
                        Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: 4.0),
                          child:  Text('Based on ${(controller.model.value.data!.reviewsCount ).toString()} Reviews',style: const TextStyle(
                            color: Color(0xFF969AA3),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Food Quality',style: TextStyle(
                            color: Color(0xFF969AA3),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),),
                          SizedBox(height: 5,),
                          Text('Food Quantity',style: TextStyle(
                            color: Color(0xFF969AA3),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),),
                          SizedBox(height: 5,),
                          Text('Communication',style: TextStyle(
                            color: Color(0xFF969AA3),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),),
                          SizedBox(height: 5,),
                          Text('Hygiene',style: TextStyle(
                            color: Color(0xFF969AA3),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      ),
                    ),
                    Expanded(flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LinearPercentIndicator(
                            lineHeight: 6.0,
                            barRadius: const Radius.circular(12),
                            backgroundColor: const Color(0xFFFAE9E4),
                            animation: true,
                            progressColor: const Color(0xFFF8B859),
                            percent:  double.parse(controller.model.value.data!.totalReviews![3].avg.toString()) / 10,
                            animationDuration: 1200,
                          ),
                          const SizedBox(height: 15,),
                          LinearPercentIndicator(
                            lineHeight: 6.0,
                            barRadius: const Radius.circular(12),
                            backgroundColor: const Color(0xFFFAE9E4),
                            // width: AddSize.screenWidth,
                            animation: true,
                            progressColor: const Color(0xFFF7E742),
                            percent: double.parse(controller.model.value.data!.totalReviews![2].avg.toString()) / 10,
                            animationDuration: 1200,
                          ),
                          const SizedBox(height: 15,),
                          LinearPercentIndicator(
                            lineHeight: 6.0,
                            barRadius: const Radius.circular(12),
                            backgroundColor: const Color(0xFFFAE9E4),
                            animation: true,
                            progressColor: const Color(0xFFA4D131),
                            percent: double.parse(controller.model.value.data!.totalReviews![1].avg.toString()) / 10,
                            animationDuration: 1200,
                          ),
                          const SizedBox(height: 15,),
                          LinearPercentIndicator(
                            lineHeight: 6.0,
                            barRadius: const Radius.circular(12),
                            backgroundColor: const Color(0xFFFAE9E4),
                            animation: true,
                            progressColor: const Color(0xFF5DAF5E),
                            percent: double.parse(controller.model.value.data!.totalReviews![0].avg.toString()) / 10,
                            animationDuration: 1200,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                addHeight(20),
                const Divider(
                  height: 1,
                  thickness: 1.5,
                  color: Color(0xFFE8F2EC),
                ),
                addHeight(20),
                controller.model.value.data!.reviewsList!.isNotEmpty ?
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.model.value.data!.reviewsList!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(borderRadius: BorderRadius.circular(50) ,
                              child: CachedNetworkImage(
                                imageUrl: controller.model.value.data!.reviewsList![index].profileImage.toString(),
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                                errorWidget: (_, __, ___) => Image.asset(
                                  'assets/images/Ellipse 67.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                placeholder: (_, __) =>
                                const Center(child: CircularProgressIndicator()),
                              ),
                            ),
                            //Image.asset('assets/images/Ellipse 1563.png',height: 50,),
                            addWidth(20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:  const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Text(controller.model.value.data!.reviewsList![index].userName.toString().capitalizeFirst.toString(),
                                      style: const TextStyle(
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
                                    child:
                                    ReadMoreText(
                                      controller.model.value.data!.reviewsList![index].review.toString().capitalizeFirst.toString(),
                                      trimLines: 1,style:
                                    const TextStyle(color: Color(0xFF969AA3)),
                                      colorClickableText: const Color(0xFF567DF4),
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'read more',
                                      trimExpandedText: 'read less',
                                      moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal,color: Color(0xFF567DF4)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // const Spacer(),
                            Padding(
                              padding:  const EdgeInsets.symmetric(vertical: 3.0),
                              child:  Text(controller.model.value.data!.reviewsList![index].date.toString(),style: const TextStyle(
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
                ) : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('No FeedBack',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                  ],
                ),
              ],
            ),
          ),
        ): const Center(child: CircularProgressIndicator()),
      );
    });
  }
}
