import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homemady/Screens/subscription_history.dart';
import 'package:homemady/Screens/thankyou_screen2.dart';
import 'package:homemady/repository/subscription_repo.dart';

import '../resources/add_text.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';


class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);
  static var subscriptionScreen = '/subscriptionScreen';
  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  CardFormEditController controller = CardFormEditController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: backAppBar(title: 'Subscribe Plan', context: context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                SizedBox(height: height * .02,),
                Container(
                  width: AddSize.screenWidth,
                  decoration:  BoxDecoration(
                    color: const Color(0xFF6BC743),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: width * .1,vertical: 5),
                    child: Column(
                      children: [
                        SizedBox(height: height * .03,),
                         const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Column(
                              children: [
                                Text('9.99',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: 'Graphit.ttf',
                                      fontWeight: FontWeight.w600,
                                      color:  Colors.white
                                  ),),
                                SizedBox(height: 5,),
                                Text('Per Month',
                                  style: TextStyle(
                                      fontSize: 15,height: .05,
                                      fontWeight: FontWeight.w500,
                                      color:  Colors.white
                                  ),),
                              ],
                            ),
                            Column(
                              children: [
                                Text('€',
                                  style: TextStyle(
                                      fontSize: 20,
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                      color:  Colors.white
                                  ),),
                              ],
                            ),

                          ],
                        ),

                        SizedBox(height: height * .03,),
                        const Text('Get 0€ Service Charge On All\n Orders',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color:  Colors.white,
                          ),),
                        SizedBox(height: height * .04,),
                      ],
                    ),
                  ),

                ),
                SizedBox(height: height * .04,),
                CardFormField(
                  controller: controller,
                  autofocus: true,
                  style: CardFormStyle(
                    // borderColor: Colors.black
                      backgroundColor: Colors.white,
                      textColor: const Color(0xFF535353),
                      placeholderColor: Colors.black,
                      textErrorColor: Colors.red,
                      fontSize: AddSize.padding16.toInt(),
                      cursorColor: Colors.black,
                      borderRadius: 10,borderColor: const Color(0xFFCDCDCD),
                      borderWidth: 1),
                ),
                // SizedBox(height: height * .05,),

              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (controller.details.complete == false) {
                      showToast("Fill the card details correctly");
                    } else {
                      Stripe.instance.createToken(const CreateTokenParams.card(params: CardTokenParams())).then((value) {
                        log(value.toString());
                        log('token--' + value.id.toString());
                        {
                          log('token--' + value.id.toString());
                        }
                        subscription(token: value.id.toString(), amount: '9', context: context).then((value) {
                          if(value.status == true){
                            showToast(value.message.toString());
                           Get.toNamed(ThankYouScreen2.thankYouScreen2);
                          }
                        });

                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: const  Color(0xff7ED957),
                      minimumSize: const Size(double.maxFinite, 62),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  child: Text(
                    "Buy Plan",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: const Color(0xffFFFFFF), fontWeight: FontWeight.w700, fontSize: 20),
                  )),
              SizedBox(height: height * .01,),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(SubscriptionHistoryScreen.subscriptionHistoryScreen);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.transparent,
                      minimumSize: const Size(double.maxFinite, 62),
                      elevation: 0,
                      side: const BorderSide(width:3, color: Color(0xff7ED957)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  child: Text(
                    "Subscription History",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Color(0xFF69C541), fontWeight: FontWeight.w700, fontSize: 20),
                  )),
            ],
          ),
        ),
      ),

    );
  }
}
