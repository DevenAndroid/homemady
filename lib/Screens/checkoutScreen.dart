import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';

import '../controller/my_address_controller.dart';
import '../controller/my_cart_controller.dart';
import '../model/my_address_model.dart';
import '../repository/checkout_order_repo.dart';
import '../resources/add_text.dart';


class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final myAddressController = Get.put(MyAddressController());
  final myCartController = Get.put(MyCartListController());

  Rx<AddressData> addressModel = AddressData().obs;
  @override
  String _selectedGender = 'male';
  String _selectedValue = 'one';
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: backAppBar(title: 'Checkout', context: context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                  offset: const Offset(.1, .1,
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
                    child: Text('Delivery Option',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff1A2E33)
                      ),),
                  ),
                  addHeight(10),
                  Row(
                    children: [
                  Theme(
                  data: ThemeData(
                         unselectedWidgetColor: Colors.green,),
                        child: Radio<String>(
                          visualDensity: const VisualDensity(
                              horizontal: -4,
                              vertical: -1),
                          value: 'pickup',
                          activeColor:Colors.green,
                          groupValue: _selectedGender,

                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                      ),
                      addWidth(5),
                      Text('Delivery',style: GoogleFonts.poppins(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w300,
                        fontSize: 16
                      ),),
                    addWidth(40),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.green,),
                        child: Radio<String>(
                          visualDensity: const VisualDensity(
                              horizontal: -4,
                              vertical: -4),
                          value: 'delivery',
                          activeColor:Colors.green,
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                      ),
                      addWidth(5),
                      Text('Pickup',style: GoogleFonts.poppins(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w300,
                        fontSize: 16
                      ),)
                    ],
                  ),
                  addHeight(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9.0),
                    child: Text('When',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff1A2E33)
                      ),),
                  ),
                  addHeight(5),
                  Row(
                    children: [
                  Theme(
                  data: ThemeData(
                  //here change to your color
                  unselectedWidgetColor: Colors.green,
                  ),
                        child: Radio<String>(
                          visualDensity: const VisualDensity(
                              horizontal: -4,
                              vertical: -1),
                          value: 'date',
                          activeColor:Colors.green,
                          groupValue: _selectedValue,

                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                        ),
                      ),
                      addWidth(5),
                      Text('Now',style: GoogleFonts.poppins(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w300,
                          fontSize: 16
                      ),),
                      addWidth(56),
                      Theme(
                        data: ThemeData(
                          //here change to your color
                          unselectedWidgetColor: Colors.green,
                        ),
                        child: Radio<String>(
                          value: 'now',
                          activeColor:Colors.green,
                          groupValue: _selectedValue,

                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: Text('Specify Time/Date',style: GoogleFonts.poppins(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w300,
                            fontSize: 16
                        ),),
                      )
                    ],
                  ),
                  addHeight(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9.0),
                    child: Text('Special Request',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff1A2E33)
                      ),),
                  ),
                  addHeight(15),
                const Padding(
                   padding:  EdgeInsets.symmetric(horizontal: 9.0),
                   child:  RegistrationTextFieldChk(
                      hint: 'Type Name',
                      minLines: 3,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,),
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
                  offset: const Offset(.1, .1,
                  ),
                  blurRadius: 20.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 14,bottom: 5),
              child: CustomTextField1(
                obSecure: false.obs,
                hintText: 'Apply Promo Code'.obs,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 36,
                    width: 94,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF7ED957),
                          Color(0xFF68C541),
                        ]
                      ),
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: Center(
                      child: Text(
                        'Apply',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                ),
              )
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
                offset: const Offset(.1, .1,
                ),
                blurRadius: 20.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
            child:    Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25,top: 10,bottom: 10,right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Deliver to',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff1A2E33)
                        ),),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(MyRouters.chooseAddress);
                        },
                        child: Image.asset('assets/images/pencilImg.png',
                          height: 13,),
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
                  onTap: (){
                    Get.toNamed(MyRouters.myAddressScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,top: 10,bottom: 15,right: 5),
                    child: Row(
                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Image.asset('assets/images/Group 1000004233.png',height: 36,),
                          addWidth(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Home',
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff1A2E33)
                                ),),
                              Row(
                                children: [
                                  Text('sdjfg',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff5C5C60)
                                    ),),
                                  addWidth(5),
                                  Text('fgfg',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff5C5C60)
                                    ),),
                                ],
                              )
                            ],
                          ),
                          Spacer(),
                          const Icon(Icons.arrow_forward_ios,color: Color(0xFF04666E),size: 17,)
                      ],
                    ),
                  ),
                )
              ],
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
                offset: const Offset(.1, .1,
                ),
                blurRadius: 20.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order Summary',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff1A2E33)
                        ),),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF6CC845)),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 7),
                            child: Text('Add items',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF6CC845)
                              ),),
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
                    itemCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/Rectangle 39702.png',height: 70,),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0,left: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Panna Onion Pasta',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: const Color(0xFF21283D)
                                        ),),
                                      addHeight(2),
                                      Text('\$12.00',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: const Color(0xFF7DD856)
                                        ),),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(MyRouters.myOrderScreen);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Image.asset('assets/images/edit_icon.png',height: 20,),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding:  EdgeInsets.only(top: 16),
                              child: Divider(
                                color:  Color(0xFFE8E8E8),
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
                offset: const Offset(.1, .1,
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
                  Text('Payment Method',
                    style: GoogleFonts.alegreyaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xff000000)
                    ),),
                  addHeight(14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.toNamed(MyRouters.addNewCardScreen);
                        },
                        child: Container(
                          width: 41,
                          height: 57,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(42),
                            border: Border.all(color: const Color(0xFFF2F2F2))
                          ),
                          child: const Center(child: Icon(Icons.add,color: Color(0xFF7DD856),)),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 57,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFF2F2F2))
                        ),
                        child:  Center(child: Image.asset('assets/images/mastercard.png',height: 36,)),
                      ),
                      Container(
                        height: 60,
                        width: 57,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFF2F2F2))
                        ),
                        child: Center(child: Image.asset('assets/images/google_pay.png',height: 16,)),
                      ),
                      Container(
                        height: 60,
                        width: 57,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFF2F2F2))
                        ),
                        child: Center(child: Image.asset('assets/images/paytm_img.png',height: 20,)),
                      ),
                      Container(
                        height: 60,
                        width: 57,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFF2F2F2))
                        ),
                        child: Center(child: Image.asset('assets/images/paypal.png',height: 30,)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
              Padding(
                padding: const EdgeInsets.only(top:15,),
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
                            Text('Subtotal',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff1A2E33)
                              ),),
                            Spacer(),
                            Text( '€12.99',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff3A3A3A)
                              ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,10,14,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Delivery fee',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff1A2E33)
                              ),),
                            Spacer(),
                            Text( '€5.00',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff3A3A3A)
                              ),),
                          ],
                        ),
                      ),
                      const Padding(
                     padding:  EdgeInsets.fromLTRB(15,10,14,0),
                     child: Divider(
                       color:  Color(0xFFE8E8E8),
                       height: 1,
                       thickness: 1.5,
                     ),
                   ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,10,14,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Total',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff1A2E33)
                              ),),
                            Spacer(),
                            Text( '€17.99',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff3A3A3A)
                              ),),
                          ],
                        ),
                      ),
                      addHeight(20)
                    ],

                  ),
                ),
              ),
              addHeight(40),
              CommonButton(title: 'Place Order'.toUpperCase(),
              onPressed: (){

                checkOut(context: context,payment_type: 'cod').then((value) {
                  if(value.status == true){
                    print('order id is...${value.data!.orderId}');
                    showToast(value.message.toString());
                    Get.toNamed(MyRouters.thankYouScreen,arguments: [value.data!.orderId]);

                    myAddressController.getData();
                  }
                });
              //  Get.toNamed(MyRouters.thankYouScreen);
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
