import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controller/my_cart_controller.dart';
import '../routers/routers.dart';
import '../widgets/app_theme.dart';
import '../widgets/dimenestion.dart';

showToast(message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      // backgroundColor: const Color(0xFF7ED957),
      textColor: Colors.white,
      fontSize: 16.0);
}
String? validateMobile(String? value) {
  if (value!.length != 10) {
    return 'Enter Mobile Number & must be of 10 digit';
  } else {
    return null;
  }
}

String? validateName(String? name) {
  if (name!.isEmpty) {
    return 'Please Enter Name';
  } else {
    return null;
  }
}

String? validateEmail(String? email) {
  if (email!.isEmpty) {
    return 'Please Enter Email';
  } else {
    return null;
  }
}

addCartSection(){
  final myCartController = Get.put(MyCartListController());
  return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: Obx(() {
        return myCartController.isDataLoading.value
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    // begin: Alignment.topCenter,
                    // end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF7ED957),
                        Color(0xFF68C541)]
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(MyRouters.myCartScreen,);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize:
                      Size(double.maxFinite, AddSize.size30 * 2),
                      // primary: AppTheme.primaryColor,
                      foregroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                                "${(myCartController.sum.value ?? '' ).toString()} Items",
                                // 'k',
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: AppTheme.backgroundcolor,
                                    fontWeight: FontWeight.w400),
                              ),
                             // if(myCartController.model.value.data!.cartPaymentSummary!.subTotal != null)
                              Text(
                                "€ ${(myCartController.model.value.data!.cartPaymentSummary!.subTotal ?? '').toString()}",
                                //'sgdhs',
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: AppTheme.backgroundcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Text(
                              "View Cart",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.backgroundcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.arrow_right,
                              size: 30,
                              color: Colors.white,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AddSize.size20,
            ),
          ],
        )
            : const SizedBox();
      }));
}