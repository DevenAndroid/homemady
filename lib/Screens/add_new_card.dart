import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_textfiled.dart';

import '../controller/get_saved_card_details_controller.dart';
import '../controller/my_cart_controller.dart';
import '../repository/checkout_order_repo.dart';
import '../resources/add_text.dart';
import '../widgets/dimenestion.dart';
import 'thankyou_Screen.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {

  String? selectedMethod;
  List method = ["D", "P"];
  bool showErrorMessage = false;
  bool value = false;
  RxBool checkboxColor = false.obs;
  CardFormEditController controller = CardFormEditController();
  final getSavedDetailsController = Get.put(SavedCardDetailsController());
  final myCartController = Get.put(MyCartListController());

  bool apiHitted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: backAppBar(title: 'Add New Card', context: context),
        body: Container(
          color:  Colors.white,
          child: Stack(
            children: [

              Positioned(
                left: 20,
                right: 20,
                top: 30,
                child: CardFormField(

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
                      borderRadius: 10,
                      borderWidth: 1),
                ),
                // Container(
                //   decoration:  BoxDecoration(
                //     borderRadius: BorderRadius.circular(16),
                //     color: AppTheme.backgroundcolor,
                //   ),
                //   height: AddSize.size200 *1.5,
                //   width: AddSize.screenWidth,
                // ),
              ),

            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SafeArea(
            top: false,
            child: ElevatedButton(
                onPressed: () {
                  if (controller.details.complete == false) {
                    showToast("Fill the card details correctly");
                  }
                  else {
                    if(apiHitted == true)return;
                    apiHitted = true;
                    Stripe.instance.createToken(const CreateTokenParams.card(params: CardTokenParams())).then((value) {
                        log('token--${value.id}');
                        saveCardDetailsRepo(stripeToken: value.id.toString(), context: context).then((value){
                          apiHitted = false;
                          if(value.status==true){
                            apiHitted = false;
                            showToast(value.message);
                            myCartController.getData();
                            getSavedDetailsController.getSavedCardData();
                            Get.back();
                          }
                          else{
                            showToast(value.message);
                          }
                        }).catchError((e){
                          apiHitted = false;
                        });
                        log('order id--${value.id}');
                        // check
                        // checkOut(
                        //     payment_type: 'online',
                        //     context: context,
                        //     deliveryInstruction: Get.arguments[2],
                        //     specialRequest: Get.arguments[1],
                        //     delivery_type: Get.arguments[0] )
                        //     .then((value1) {
                        //   log('Token iddddddddddddddddddddd${value.id}');
                        //   payment(
                        //           orderId: value1.data!.orderId.toString(),
                        //           token: value.id.toString(),
                        //           amount: value1.data!.grandTotal,
                        //           context: context)
                        //       .then((value2) {
                        //     if (value2.status == true) {
                        //      // showToast(value2.message.toString());
                        //       myCartController.getData();
                        //       getSavedDetailsController.getSavedCardData();
                        //      // print('Order id====' + value2.data!.orderId);
                        //       Get.offAll(()=> ThankYouScreen(
                        //         orderId: value2.data!.orderDetail!.orderId.toString(),
                        //       ));
                        //       // Get.offAllNamed(MyRouters.thankYouScreen, arguments: [
                        //       //   value2.data!.orderDetail!.orderId,
                        //       //   value2.data!.orderDetail!.placedAt,
                        //       //   value2.data!.orderDetail!.stateTax,
                        //       //   value2.data!.orderDetail!.muncipalTax,
                        //       //   value2.data!.orderDetail!.grandTotal,
                        //       //  // value2.data!.or,
                        //       //   // value2.data!.card,
                        //       //   value2.data!.orderDetail!.itemTotal,
                        //       // ]);
                        //     }
                        //   });
                        // });
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
                  "SAVE",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: const Color(0xffFFFFFF), fontWeight: FontWeight.w700, fontSize: 20),
                )),
          ),
        ),
      ),
    );
  }
}
