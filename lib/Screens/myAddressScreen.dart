import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';

import '../controller/my_address_controller.dart';
import '../controller/my_cart_controller.dart';
import '../controller/user_profile_controller.dart';
import '../repository/choose_order_address_repo.dart';
import '../repository/remove_address_repo.dart';
import '../resources/add_text.dart';
class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({Key? key}) : super(key: key);

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  final myAddressController = Get.put(MyAddressController());
  final myCartController = Get.put(MyCartListController());
  final profileController = Get.put(UserProfileController());

  int currentIndex = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      myAddressController.getData();
      // Add Your Code here.

    });
  }

  showUploadWindow(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AddSize.size10),
                    Text("Are you sure you want to delete this address?",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: AddSize.font16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text("No",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF7ED957),
                                  fontSize: AddSize.font18)),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: Text("Yes",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF7ED957),
                                  fontSize: AddSize.font18)),
                          onPressed: () {
                            removeAddress(
                                addressId: index.id.toString(),
                                context: context)
                                .then((value) {
                              showToast(value.message.toString());
                              if (value.status == true) {
                                myAddressController.getData();
                                Get.back();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(context: context, title: 'My Address'),
        body:
        myAddressController.isDataLoading.value ? myAddressController.model.value.data!.isNotEmpty ?
        SingleChildScrollView(
          child: Column(
            children: [
              addHeight(30),
              ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: myAddressController.model.value.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(onTap: (){
                    print("choose here");
                   // Get.toNamed(MyRouters.checkOutScreen);
                   //  chooseOrderAddress(context: context,addressId: myAddressController.model.value.data![index].id.toString()).then((value) {
                   //    if(value.status == true){
                   //      myCartController.getData();
                   //      showToast(value.message.toString());
                   //     Get.back();
                   //     //  Get.toNamed(MyRouters.checkOutScreen);
                   //      // myCartController.getData();
                   //    }
                   //  });
                    print(myAddressController.model.value.data![index].id.toString());
                  },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(

                        children: [
                          InkWell(
                            onTap: (){
                              currentIndex = index;
                              chooseOrderAddress(context: context,addressId: myAddressController.model.value.data![index].id.toString()).then((value) {
                                if(value.status == true){

                                  myCartController.getData();
                                  profileController.getData().then((value) {
                                    profileController.address.value = profileController.model.value.data!.defaultAddress![0].addressType.toString();
                                  });
                                  showToast(value.message.toString());
                                  Get.back();

                                }
                              });

                              setState(() {});

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.zero,
                                border: Border.all(
                                    width: 2,
                                    color: currentIndex == index ? Color(0xff7ED957): Colors.transparent),
                                boxShadow: [
                                  BoxShadow(
                                    color:  currentIndex == index ?  Color(0xFF37C666).withOpacity(0.10):Colors.transparent,
                                    offset:  currentIndex == index ?  Offset(
                                      .2,
                                      .2,
                                    ):Offset(0, 0),
                                    blurRadius: 20.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/Group 1000004233.png',
                                      height: 40,
                                    ),
                                    addWidth(10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                myAddressController
                                                    .model.value.data![index].addressType
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(0xff1A2E33)),
                                              ),
                                              // GestureDetector(
                                              //     onTap: () {
                                              //       myAddressController.id.value = myAddressController.model.value.data![index].id.toString();
                                              //       Get.toNamed(MyRouters.chooseAddress,arguments: [myAddressController.model.value.data![index]]);
                                              //       print(myAddressController.model.value.data![index].id.toString());
                                              //     },
                                              //     child: Image.asset(
                                              //       'assets/images/edit_alt.png',
                                              //       height: 24,
                                              //     ))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  myAddressController
                                                      .model.value.data![index].flatNo
                                                      .toString()+' ' + myAddressController
                                                .model.value.data![index].landmark
                                                .toString()+', ' + myAddressController
                                                      .model.value.data![index].pinCode
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: const Color(0xff5C5C60)),
                                                ),
                                              ),
                                              addWidth(5),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  myAddressController
                                                      .model.value.data![index].note
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: const Color(0xff5C5C60)),
                                                ),
                                              ),
                                              addWidth(5),
                                              // Expanded(
                                              //   child: Text(
                                              //    "",
                                              //     style: GoogleFonts.poppins(
                                              //         fontSize: 14,
                                              //         fontWeight: FontWeight.w400,
                                              //         color: const Color(0xff5C5C60)),
                                              //   ),
                                              // ),
                                              // addWidth(5),
                                              // Expanded(
                                              //   child: Text(
                                              //     myAddressController
                                              //         .model.value.data![index].pinCode
                                              //         .toString(),
                                              //     style: GoogleFonts.poppins(
                                              //         fontSize: 14,
                                              //         fontWeight: FontWeight.w400,
                                              //         color: const Color(0xff5C5C60)),
                                              //   ),
                                              // ),
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  showUploadWindow(
                                                      myAddressController
                                                          .model
                                                          .value
                                                          .data![index]);
                                                },
                                                child: const Text(
                                                  "Remove",
                                                  style: TextStyle(
                                                      color: Color(0xFF7ED957),
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500),
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                  width * .02),
                                              Container(
                                                color: const Color(0xFF7ED957),
                                                height:
                                                height * .012,
                                                width: width * .003,
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  myAddressController.id.value = myAddressController.model.value.data![index].id.toString();
                                                  Get.toNamed(MyRouters.chooseAddress,arguments: [myAddressController.model.value.data![index]]);
                                                  print(myAddressController.model.value.data![index].id.toString());
                                                },
                                                child: const Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      color: Color(0xFF7ED957),
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          addHeight(20),
                        ],
                      ),
                    ),
                  );
                },
              ),
              addHeight(173),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CommonButton(
                  title: 'Add Address',
                  onPressed: () {
                    Get.toNamed(MyRouters.chooseAddress);
                  },
                ),
              ),
              addHeight(30)
            ],
          ),
        ):   Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CommonButton(
              title: 'Add Address',
              onPressed: () {
                Get.toNamed(MyRouters.chooseAddress);
              },
            ),
          ),
        ) :
       const Center(child: CircularProgressIndicator(color: Colors.green,))
      );
    });
  }
}
