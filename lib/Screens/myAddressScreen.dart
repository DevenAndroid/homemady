import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';

import '../controller/my_address_controller.dart';
import '../repository/choose_order_address_repo.dart';
import '../resources/add_text.dart';
import 'choose_address.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({Key? key}) : super(key: key);

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  final myAddressController = Get.put(MyAddressController());
  final controller = Get.put(MyAddressController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      myAddressController.getData();
      // Add Your Code here.

    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(context: context, title: 'My Address'),
        body: myAddressController.isDataLoading.value ? myAddressController.model.value.data!.isNotEmpty ?
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
                   // Get.toNamed(MyRouters.checkOutScreen);
                    chooseOrderAddress(context: context,addressId: myAddressController.model.value.data![index].id.toString()).then((value) {
                      if(value.status == true){
                        showToast(value.message.toString());
                        controller.getData();
                       // Get.back();
                        //Get.toNamed(MyRouters.checkOutScreen);
                      }
                    });
                    print(myAddressController.model.value.data![index].id.toString());
                  },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.zero,
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                      Row(
                                        children: [
                                          Text(
                                            myAddressController
                                                .model.value.data![index].flatNo
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xff5C5C60)),
                                          ),
                                          addWidth(5),
                                          Text(
                                            myAddressController
                                                .model.value.data![index].location
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xff5C5C60)),
                                          ),
                                          /*Text('4295 Shinn Avenue, Indiana, States',
                                     style: GoogleFonts.poppins(
                                         fontSize: 14,
                                         fontWeight: FontWeight.w400,
                                         color: const Color(0xff5C5C60)
                                     ),)*/
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        myAddressController.id.value = myAddressController.model.value.data![index].id.toString();
                                        Get.toNamed(MyRouters.chooseAddress,arguments: [myAddressController.model.value.data![index]]);
                                        print(myAddressController.model.value.data![index].id.toString());
                                      },
                                      child: Image.asset(
                                        'assets/images/edit_alt.png',
                                        height: 24,
                                      ))
                                ],
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
        ): const Text('Address Empty',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),) : const Center(child: CircularProgressIndicator()),
      );
    });
  }
}
