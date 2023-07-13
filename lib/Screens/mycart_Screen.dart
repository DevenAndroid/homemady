import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/resources/add_text.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';

import '../controller/my_cart_controller.dart';
import '../repository/remove_cartitem_repo.dart';


class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final controller = Get.put(MyCartListController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getData();
  }
  bool? _isValue = false;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(title: 'My Cart', context: context),
        body: controller.isDataLoading.value ? controller.model.value.data!.cartItems!.isNotEmpty ?
        SingleChildScrollView(
          child: Column(
            children: [
              addHeight(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.model.value.data!.cartItems!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(onTap: (){
                      print(controller.model.value.data!.cartItems![index].id.toString(),);
                      print(controller.model.value.data!.cartItems![index].productId.toString(),);
                    },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF37C666).withOpacity(0.10),
                                  offset: const Offset(.1, .1,
                                  ),
                                  blurRadius: 20.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                            ),
                            child: Slidable(
                                endActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  extentRatio: 1/4,
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        removeCartItemRepo(cart_item_id: controller.model.value.data!.cartItems![index].id.toString(),context: context).then((value) {
                                          if(value.status == true){
                                            showToast(value.message.toString());
                                            print(controller.model.value.data!.cartItems![index].id.toString());
                                            setState(() {
                                              controller.getData();
                                            });
                                          }
                                        });
                                      },
                                      backgroundColor: const Color(0xFFFF5B4D),
                                      icon: Icons.delete,
                                      label: 'Delete',
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/images/Rectangle 39768.png',height: 74,),
                                      addWidth(10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text((controller.model.value.data!.cartItems![index].name!.isEmpty ? 'Test' : controller.model.value.data!.cartItems![index].name).toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: const Color(0xFF21283D)
                                            ),),
                                          addHeight(3),
                                          Row(
                                            children: [
                                              Text('${controller.model.value.data!.cartItems![index].cartItemQty.toString()} items',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: const Color(0xFF486769).withOpacity(0.70)
                                                ),),
                                              addWidth(10),
                                              Container(
                                                width: 1,
                                                height: 10,
                                                color: Colors.grey,
                                              ),
                                              addWidth(10),
                                              Text('',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: const Color(0xFF486769).withOpacity(0.70)
                                                ),),
                                            ],
                                          ),
                                          addHeight(5),
                                          Text('€ ${controller.model.value.data!.cartItems![index].price.toString()}',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: const Color(0xFF70CC49)
                                            ),),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ),
                          ),
                          addHeight(10)
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:6.0,top:15,right: 6),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF37C666).withOpacity(0.10),
                        offset: const Offset(.1, .1,
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
                        padding: const EdgeInsets.fromLTRB(15,18,14,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Eater get one free delivery automatically\napplied to the 11th order.',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff303D46)
                              ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,10,14,0),
                        child: Wrap(

                          children: List.generate(10, (index){
                            return Expanded(
                              child: Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                    activeColor: const Color(0xff7ED957),
                                    // focusColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      // side: BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(3)),
                                    value: _isValue,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isValue = value;
                                      });
                                    }),
                              ),
                            );
                          }),
                        ),
                      ),
                      addHeight(20)
                    ],

                  ),
                ),
              ),
              addHeight(10),
              Padding(
                padding: const EdgeInsets.only(left:6.0,top:15,right: 6),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF37C666).withOpacity(0.10),
                        offset: const Offset(.1, .1,
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
                        padding: const EdgeInsets.fromLTRB(15,18,14,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Subtotal:',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff1A2E33)
                              ),),
                            Spacer(),
                            Text( '€ ${controller.model.value.data!.cartPaymentSummary!.subTotal.toString()}.00',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff486769)
                              ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,10,14,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Tax and fee:',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1A2E33)
                              ),),
                            Spacer(),
                            Text( '€ ${controller.model.value.data!.cartPaymentSummary!.taxAndFee.toString()}.00',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff486769)
                              ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,10,14,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Delivery:',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1A2E33)
                              ),),
                            Spacer(),
                            Text( '€ ${controller.model.value.data!.cartPaymentSummary!.deliveryCharge.toString()}.00',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff486769)
                              ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,10,14,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Total:',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff6BC744)
                              ),),
                            Spacer(),
                            Text( '€ ${controller.model.value.data!.cartPaymentSummary!.total.toString()}.00',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff6BC744)
                              ),),
                          ],
                        ),
                      ),
                      addHeight(20)
                    ],

                  ),
                ),
              ),
              addHeight(39),
              Padding(
                padding:  EdgeInsets.only(left: 8.0,right: 8.0),
                child: CommonButton(title: 'Check out',onPressed: (){
                  Get.toNamed(MyRouters.checkOutScreen);
                },),
              ),

              addHeight(20),
            ],
          ),
        ):Center(child: Text('Cart Empty',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),)) :Center(child: CircularProgressIndicator()),
      );
    });
  }
}
