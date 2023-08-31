

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';

import '../controller/get_saved_card_details_controller.dart';
import '../controller/my_address_controller.dart';
import '../controller/my_cart_controller.dart';
import '../model/my_address_model.dart';
import '../repository/apply_coupon_repo.dart';
import '../repository/checkout_order_repo.dart';
import '../resources/add_text.dart';
import 'myAddressScreen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final myAddressController = Get.put(MyAddressController());
  final getSavedDetailsController = Get.put(SavedCardDetailsController());
  final myCartController = Get.put(MyCartListController());
  final TextEditingController specialRequestController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController deliveryInstructionController = TextEditingController();
  bool showError = false;
  Rx<AddressData> addressModel = AddressData().obs;
  bool showValidation = false;
  RxBool checkboxColor = false.obs;
  RxBool checkboxColor2 = false.obs;

  String? selectedMethod;
  RxString? selectedSavedCard ="".obs;
  List method = ["D", "P"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myCartController.getData();
      getSavedDetailsController.getSavedCardData();
      // log('order id'+ )
      // Add Your Code here.
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  // String selectValue = 'male';
  bool value = false;
  bool value2 = false;
  String _selectedValue = 'one';
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus!.unfocus();
          },
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
          appBar: backAppBar(title: 'Checkout', context: context),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    addHeight(15),
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
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 9.0),
                              child: Text(
                                'Delivery Option',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff1A2E33)),
                              ),
                            ),
                            addHeight(10),
                            Row(
                              children: [
                                myCartController.model.value.data!.cartItems![0].collectionStatus!
                                    ? const SizedBox()
                                    : Theme(
                                        data: ThemeData(
                                          unselectedWidgetColor: Colors.green,
                                        ),
                                        child: addRadioButton(0)),
                                addWidth(5),
                                myCartController.model.value.data!.cartItems![0].collectionStatus!
                                    ? const SizedBox()
                                    : Text(
                                        'Delivery',
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xFF000000), fontWeight: FontWeight.w300, fontSize: 16),
                                      ),
                                myCartController.model.value.data!.cartItems![0].collectionStatus! ? const SizedBox() : addWidth(40),
                                Theme(
                                    data: ThemeData(
                                      unselectedWidgetColor: Colors.green,
                                    ),
                                    child: addRadioButton(1)),
                                addWidth(5),
                                Text(
                                  'Pickup',
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xFF000000), fontWeight: FontWeight.w300, fontSize: 16),
                                )
                              ],
                            ),
                            // addHeight(20),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 9.0),
                            //   child: Text('When',
                            //     style: GoogleFonts.poppins(
                            //         fontSize: 18,
                            //         fontWeight: FontWeight.w500,
                            //         color: const Color(0xff1A2E33)
                            //     ),),
                            // ),
                            // addHeight(5),
                            // Row(
                            //   children: [
                            // Theme(
                            // data: ThemeData(
                            // //here change to your color
                            // unselectedWidgetColor: Colors.green,
                            // ),
                            //       child: Radio<String>(
                            //         visualDensity: const VisualDensity(
                            //             horizontal: -4,
                            //             vertical: -1),
                            //         value: 'date',
                            //         activeColor:Colors.green,
                            //         groupValue: _selectedValue,
                            //
                            //         onChanged: (value) {
                            //           setState(() {
                            //             _selectedValue = value!;
                            //           });
                            //         },
                            //       ),
                            //     ),
                            //     addWidth(5),
                            //     Text('Now',style: GoogleFonts.poppins(
                            //         color: Color(0xFF000000),
                            //         fontWeight: FontWeight.w300,
                            //         fontSize: 16
                            //     ),),
                            //     addWidth(56),
                            //     Theme(
                            //       data: ThemeData(
                            //         //here change to your color
                            //         unselectedWidgetColor: Colors.green,
                            //       ),
                            //       child: Radio<String>(
                            //         value: 'now',
                            //         activeColor:Colors.green,
                            //         groupValue: _selectedValue,
                            //
                            //         onChanged: (value) {
                            //           setState(() {
                            //             _selectedValue = value!;
                            //           });
                            //         },
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: Text('Specify Time/Date',style: GoogleFonts.poppins(
                            //           color: Color(0xFF000000),
                            //           fontWeight: FontWeight.w300,
                            //           fontSize: 16
                            //       ),),
                            //     )
                            //   ],
                            // ),

                            addHeight(20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 9.0),
                              child: Text(
                                'Special Request',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff1A2E33)),
                              ),
                            ),
                            addHeight(15),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 9.0),
                              child: RegistrationTextFieldChk(
                                controller: specialRequestController,
                                focusNode: FirstDisabledFocusNode(),
                                hint: 'Type here..',
                                minLines: 3,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                              ),
                            ),

                            addHeight(20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 9.0),
                              child: Text(
                                'Instructions for delivery',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff1A2E33)),
                              ),
                            ),
                            addHeight(15),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 9.0),
                              child: RegistrationTextFieldChk(
                                controller: deliveryInstructionController,
                                hint: 'Type here...',
                                minLines: 3,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    addHeight(15),
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
                                      } else if (value.status == false) {
                                        showToast(value.message);
                                      }
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      'Apply',
                                      style:
                                          GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                    addHeight(15),
                    selectedMethod.toString() == 'P'
                        ? const SizedBox()
                        : Container(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Deliver to',
                                        style: GoogleFonts.poppins(
                                            fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xff1A2E33)),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(MyRouters.chooseAddress);
                                        },
                                        child: Image.asset(
                                          'assets/images/pencilImg.png',
                                          height: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Color(0xFFF2F2F2),
                                  height: 1,
                                  thickness: 1.2,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const MyAddressScreen());
                                    // Get.toNamed(MyRouters.chooseAddress);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, top: 10, bottom: 15, right: 5),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/Group 1000004233.png',
                                          height: 36,
                                        ),
                                        addWidth(10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              myCartController.model.value.data!.orderAddress == null
                                                  ? 'Choose address'
                                                  : myCartController.model.value.data!.orderAddress!.addressType,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff1A2E33)),
                                            ),
                                            Row(
                                              children: [
                                                Obx(() {
                                                  return Text(
                                                    (myCartController.model.value.data!.orderAddress == null
                                                            ? 'Select address'
                                                            : myCartController.model.value.data!.orderAddress!.flatNo
                                                                    .toString() +
                                                                ',' +
                                                                myCartController.model.value.data!.orderAddress!.landmark
                                                                    .toString() +
                                                                ',' +
                                                                myCartController.model.value.data!.orderAddress!.pinCode
                                                                    .toString())
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        color: const Color(0xff5C5C60)),
                                                  );
                                                })
                                                // addWidth(5),
                                                /* Text((myCartController.model.value.data!.orderAddress!.landmark).toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff5C5C60)
                                        ),),*/
                                              ],
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF04666E),
                                          size: 17,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                    // addHeight(15),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order Summary',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xff1A2E33)),
                                ),
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: const Color(0xFF6CC845)),
                                        borderRadius: BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
                                      child: Text(
                                        'Add items',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xFF6CC845)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            addHeight(18),
                            const Divider(
                              color: Color(0xFFF2F2F2),
                              height: 1,
                              thickness: 1.2,
                            ),
                            addHeight(10),
                            ListView.builder(
                              itemCount: myCartController.model.value.data!.cartItems!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: myCartController.model.value.data!.cartItems![index].image.toString(),
                                            fit: BoxFit.cover,
                                            height: 76,
                                            width: 76,
                                            errorWidget: (_, __, ___) => Image.asset(
                                              'assets/images/Rectangle 39702.png',
                                              height: 76,
                                              width: 76,
                                            ),
                                            placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0, left: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  myCartController.model.value.data!.cartItems![index].name.toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 16,
                                                      color: const Color(0xFF21283D)),
                                                ),
                                                addHeight(2),
                                                Text(
                                                  '€ ${myCartController.model.value.data!.cartItems![index].totalPrice.toString()}',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16,
                                                      color: const Color(0xFF7DD856)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(MyRouters.myCartScreen);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Image.asset(
                                              'assets/images/edit_icon.png',
                                              height: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Divider(
                                        color: Color(0xFFE8E8E8),
                                        height: 1,
                                        thickness: 1,
                                      ),
                                    ),
                                    addHeight(16)
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    addHeight(15),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Payment Method',
                              style: GoogleFonts.alegreyaSans(
                                  fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xff000000)),
                            ),
                            addHeight(14),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(MyRouters.addNewCardScreen, arguments: [selectedMethod,specialRequestController.text,deliveryInstructionController.text]);
                                  },
                                  child: Container(
                                    width: 41,
                                    height: 57,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(42),
                                        border: Border.all(color: const Color(0xFFF2F2F2))),
                                    child: const Center(
                                        child: Icon(
                                      Icons.add,
                                      color: Color(0xFF7DD856),
                                    )),
                                  ),
                                ),


                                Container(
                                  height: 60,
                                  width: 57,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: const Color(0xFFF2F2F2))),
                                  child: Center(
                                      child: Image.asset(
                                    'assets/images/mastercard.png',
                                    height: 36,
                                  )),
                                ),
                                Container(
                                  height: 60,
                                  width: 57,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: const Color(0xFFF2F2F2))),
                                  child: Center(
                                      child: Image.asset(
                                    'assets/images/google_pay.png',
                                    height: 16,
                                  )),
                                ),
                                Container(
                                  height: 60,
                                  width: 57,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: const Color(0xFFF2F2F2))),
                                  child: Center(
                                      child: Image.asset(
                                    'assets/images/paytm_img.png',
                                    height: 20,
                                  )),
                                ),
                                Container(
                                  height: 60,
                                  width: 57,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: const Color(0xFFF2F2F2))),
                                  child: Center(
                                      child: Image.asset(
                                    'assets/images/paypal.png',
                                    height: 30,
                                  )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                  getSavedDetailsController.isDataLoading.value && getSavedDetailsController.savedDetailsModel.value.data != null ?
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
                        padding: const EdgeInsets.all(8.0),
                        child:

                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Saved Card',
                                style: GoogleFonts.alegreyaSans(
                                    fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xff000000)),
                              ),
                              addHeight(14),
                              getSavedDetailsController.isDataLoading.value && getSavedDetailsController.savedDetailsModel.value.data!.isNotEmpty ?
                              SizedBox(
                                height: 100,
                                child: Obx(() {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: getSavedDetailsController.savedDetailsModel.value.data!.length,
                                      itemBuilder: (BuildContext context, index){
                                        return InkWell(
                                          onTap: () {
                                            //Get.toNamed(MyRouters.addNewCardScreen, arguments: [selectedMethod,specialRequestController.text,deliveryInstructionController.text]);
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                  child: Text(
                                                    "**** **** **** ${getSavedDetailsController.savedDetailsModel.value.data![index].last4.toString()}",style: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15
                                                  ),),
                                                ),
                                              ),
                                              Theme(
                                                  data: ThemeData(
                                                    unselectedWidgetColor: Colors.green,
                                                  ),
                                                  child:
                                                  Obx((){
                                                    return addRadioButtonCard(cardToken: getSavedDetailsController.savedDetailsModel.value.data![index].id.toString());
                                                  })),
                                            ],
                                          ),
                                        );
                                      });
                                })
                              ):const SizedBox()
                            ],
                          ),

                      ),
                    )
                      :SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                      ),
                      child: Container(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 18, 14, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Subtotal',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff1A2E33)),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '€ ${myCartController.model.value.data!.cartPaymentSummary!.subTotal.toString()}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xff3A3A3A)),
                                  ),
                                ],
                              ),
                            ),
                            myCartController.model.value.data!.cartPaymentSummary!.tipAmount == 0
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 18, 14, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tip for Delivery Partner:',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff1A2E33)),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '€ ${myCartController.model.value.data!.cartPaymentSummary!.tipAmount.toString()}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xff3A3A3A)),
                                        ),
                                      ],
                                    ),
                                  ),
                            myCartController.model.value.data!.cartPaymentSummary!.couponDiscount == 0
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 18, 14, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Coupon Discount:',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff1A2E33)),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '€ ${myCartController.model.value.data!.cartPaymentSummary!.couponDiscount.toString()}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xff3A3A3A)),
                                        ),
                                      ],
                                    ),
                                  ),
                            myCartController.model.value.data!.cartPaymentSummary!.serviceCharge != 0
                                ? Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 18, 14, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Service charges',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff1A2E33)),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '€ ${myCartController.model.value.data!.cartPaymentSummary!.serviceCharge.toString()}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xff3A3A3A)),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                            myCartController.model.value.data!.cartPaymentSummary!.deliveryCharge != 0
                                ? Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 10, 14, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Delivery fee',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff1A2E33)),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '€ ${myCartController.model.value.data!.cartPaymentSummary!.deliveryCharge.toString()}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xff3A3A3A)),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(15, 10, 14, 0),
                              child: Divider(
                                color: Color(0xFFE8E8E8),
                                height: 1,
                                thickness: 1.5,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 14, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff1A2E33)),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '€ ${myCartController.model.value.data!.cartPaymentSummary!.total.toString()}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xff3A3A3A)),
                                  ),
                                ],
                              ),
                            ),
                            addHeight(20)
                          ],
                        ),
                      ),
                    ),
                    addHeight(40),
                    CommonButton(
                      title: 'Place Order'.toUpperCase(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if(getSavedDetailsController.savedDetailsModel.value.data!.isEmpty){
                            showToast("Please add card");
                            return;
                          }
                          if(selectedSavedCard == null){
                            showToast("Please select card");
                            return;
                          }
                          if (selectedMethod == "D") {
                             if (myCartController.model.value.data!.orderAddress != null) {
                               // return;
                              checkOut(
                                      context: context,
                                      payment_type: 'online',
                                      deliveryInstruction: deliveryInstructionController.text,
                                      specialRequest: specialRequestController.text,
                                      delivery_type: selectedMethod)
                                  .then((value1) {
                                   // log('Token iddddddddddddddddddddd'+value.id.toString());
                                    payment(
                                        orderId: value1.data!.orderId.toString(),
                                        token: selectedSavedCard,
                                        amount: value1.data!.grandTotal,
                                        context: context)
                                        .then((value2) {
                                      if (value2.status == true) {
                                        // showToast(value2.message.toString());
                                        myCartController.getData();
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
                            }
                             else {
                               showToast('Please select address');
                             }
                          }
                          else {
                            if (selectedMethod != null) {
                              checkOut(
                                  context: context,
                                  payment_type: 'online',
                                  deliveryInstruction: deliveryInstructionController.text,
                                  specialRequest: specialRequestController.text,
                                  delivery_type: selectedMethod)
                                  .then((value1) {
                                // log('Token iddddddddddddddddddddd'+value.id.toString());
                                payment(
                                    orderId: value1.data!.orderId.toString(),
                                    token: selectedSavedCard,
                                    amount: value1.data!.grandTotal,
                                    context: context)
                                    .then((value2) {
                                  if (value2.status == true) {
                                    // showToast(value2.message.toString());
                                    myCartController.getData();
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
                            }

                          }

                        }
                        // Get.toNamed(MyRouters.addNewCardScreen);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Row addRadioButton(int btnValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          hoverColor: const Color(0xFF68C541),
          activeColor: const Color(0xFF68C541),
          value: method[btnValue],
          groupValue: selectedMethod,
          onChanged: (value) {
            setState(() {
              selectedMethod = value;
              print(selectedMethod);
            });
          },
        ),
      ],
    );
  }



  Row addRadioButtonCard({
    required String cardToken
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
       Obx(() {
         return  Radio<String>(
           hoverColor: const Color(0xFF68C541),
           activeColor: const Color(0xFF68C541),
           value: cardToken,
           groupValue: selectedSavedCard!.value,
           onChanged: (value) {
             setState(() {
               selectedSavedCard!.value = value!;
               print(selectedSavedCard);
             });
           },
         );
       })
      ],
    );
  }

}
