import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_textfiled.dart';

import '../controller/get_saved_card_details_controller.dart';
import '../controller/my_cart_controller.dart';
import '../repository/checkout_order_repo.dart';
import '../resources/add_text.dart';
import '../widgets/dimenestion.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({Key? key}) : super(key: key);

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //log(Get.arguments[0]);
  }
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

        /*SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Name',style: GoogleFonts.poppins(
                     color: const Color(0xFF535353),
                     fontWeight: FontWeight.w400,
                     fontSize: 16,
                   ),),
                  addHeight(7.0),
                  EditProfileTextFieldWidget(
                    hint: 'Arlene Mccoy',
                    onTap: (){},
                  ),
                  addHeight(20.0),
                  Text('Card Number',style: GoogleFonts.poppins(
                    color: const Color(0xFF535353),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),),
                  addHeight(7.0),
                  EditProfileTextFieldWidget(
                    hint: '4561 456892 3521',
                    onTap: (){},
                    suffix: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/master_card.png',height: 20,),
                      ],
                    ),
                  ),
                  addHeight(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Expires ',style: GoogleFonts.poppins(
                              color: const Color(0xFF535353),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),),
                            addHeight(7),
                            EditProfileTextFieldWidget(
                              hint: '02/12',
                              onTap: (){},
                            ),
                          ],
                        ),
                      ),
                      addWidth(29.88),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CVV ',style: GoogleFonts.poppins(
                              color: const Color(0xFF535353),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),),
                            addHeight(7),
                            EditProfileTextFieldWidget(
                              hint: '5135',
                              onTap: (){},
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                  addHeight(20),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.0,
                        child: Theme(
                          data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              unselectedWidgetColor: checkboxColor.value == false
                                  ? Color(0xFF64646F)
                                  : Color(0xFF64646F)
                          ),
                          child: Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: value,
                              activeColor: Color(0xFF7ED957),
                              onChanged: (newValue) {
                                setState(() {
                                  value = newValue!;
                                  checkboxColor.value = !newValue!;
                                });
                              }),
                        ),
                      ),
                      Text(
                          'Securely save card and details',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: const Color(0xFF878787))),
                    ],
                  ),
                  addHeight(200),
                  CommonButton(title: 'Save',onPressed: (){
                    if (value != true) {
                      setState(() {
                        showErrorMessage = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Agree to our terms of Service"),
                            ));
                      }
                      );
                    }
                    else {
                      setState(() {
                        showErrorMessage = false;
                        // Get.toNamed(MyRouters.emailVerificationScreen);
                      });
                    }
                  }),
                ],
              ),
            ),
          ),
        ),*/
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ElevatedButton(
              onPressed: () {
                if (controller.details.complete == false) {
                  showToast("Fill the card details correctly");
                }
                else {
                  Stripe.instance.createToken(const CreateTokenParams.card(params: CardTokenParams())).then((value) {
                    log(value.toString());
                    log('token--${value.id}');
                    {
                      log('token--${value.id}');
                      saveCardDetailsRepo(stripeToken: value.id.toString(), context: context).then((value){
                        if(value.status==true){
                          showToast(value.message);
                          myCartController.getData();
                          getSavedDetailsController.getSavedCardData();
                          Get.back();
                        }
                        else{
                          showToast(value.message);
                        }
                      });
                      log('order id--' + value.id.toString());
                      // check
                      checkOut(
                          payment_type: 'online',
                          context: context,
                          deliveryInstruction: Get.arguments[2],
                          specialRequest: Get.arguments[1],
                          delivery_type: Get.arguments[0] )
                          .then((value1) {
                        log('Token iddddddddddddddddddddd'+value.id.toString());
                        payment(
                                orderId: value1.data!.orderId.toString(),
                                token: value.id.toString(),
                                amount: value1.data!.grandTotal,
                                context: context)
                            .then((value2) {
                          if (value2.status == true) {
                           // showToast(value2.message.toString());
                            myCartController.getData();
                            getSavedDetailsController.getSavedCardData();
                           // print('Order id====' + value2.data!.orderId);
                            Get.offAllNamed(MyRouters.thankYouScreen, arguments: [
                              value2.data!.orderDetail!.orderId,
                              value2.data!.orderDetail!.placedAt,
                              value2.data!.orderDetail!.stateTax,
                              value2.data!.orderDetail!.muncipalTax,
                              value2.data!.orderDetail!.grandTotal,
                             // value2.data!.or,
                              // value2.data!.card,
                              value2.data!.orderDetail!.itemTotal,
                            ]);
                          }
                        });
                      });
                      // out
                    }
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
                    .headline5!
                    .copyWith(color: const Color(0xffFFFFFF), fontWeight: FontWeight.w700, fontSize: 20),
              )),
        ),
      ),
    );
  }
}
