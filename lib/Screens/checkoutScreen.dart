import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';


class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  String _selectedGender = 'male';
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: backAppBar(title: 'Checkout', context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery Option',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff1A2E33)
                    ),),
                  addHeight(10),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'other',
                        activeColor:Colors.green,
                        groupValue: _selectedGender,

                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      Text('Delivery',style: GoogleFonts.poppins(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w300,
                        fontSize: 16
                      ),),
                    addWidth(40),
                      Radio<String>(
                        value: 'other',
                        activeColor:Colors.green,
                        groupValue: _selectedGender,

                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      Text('Pickup',style: GoogleFonts.poppins(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w300,
                        fontSize: 16
                      ),)
                    ],
                  ),
                  addHeight(26),
                  Text('When',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff1A2E33)
                    ),),
                  addHeight(10),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'other',
                        activeColor:Colors.green,
                        groupValue: _selectedGender,

                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      Text('Now',style: GoogleFonts.poppins(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w300,
                          fontSize: 16
                      ),),
                      addWidth(64),
                      Radio<String>(
                        value: 'other',
                        activeColor:Colors.green,
                        groupValue: _selectedGender,

                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      Text('Specify Time/Date',style: GoogleFonts.poppins(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w300,
                          fontSize: 16
                      ),)
                    ],
                  ),
                  addHeight(25),
                  Text('Special Request',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff1A2E33)
                    ),),
                  addHeight(15),

                  CustomTextField2(
                    obSecure: false.obs,
                  hintText: 'Type Name'.obs,
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
              child: CustomTextField1(obSecure: false.obs,
                hintText: 'Apply Promo Code'.obs,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12),
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
            child:    Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Deliver to',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff1A2E33)
                    ),),
                  addHeight(14),
                  const Divider(
                    color: Color(0xFFF2F2F2),
                    height: 1,
                    thickness: 1.2,
                  ),
                  addHeight(14),
                  InkWell(
                    onTap: (){
                      Get.toNamed(MyRouters.myAddressScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Text('4295 Shinn Avenue, Indiana, States',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff5C5C60)
                                ),),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Color(0xFF04666E),size: 15,)
                      ],
                    ),
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order Summary',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff1A2E33)
                        ),),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF6CC845)),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                  addHeight(23),
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
                                Image.asset('assets/images/Rectangle 39702.png',height: 76,),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0,left: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Panna Onion Pasta',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: const Color(0xFF21283D)
                                        ),),
                                      Text('\$12.00',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: const Color(0xFF7DD856)
                                        ),),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image.asset('assets/images/edit_icon.png',height: 20,),
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
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff000000)
                    ),),
                  addHeight(14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 41,
                        height: 57,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(42),
                          border: Border.all(color: const Color(0xFFF2F2F2))
                        ),
                        child: const Center(child: Icon(Icons.add,color: Color(0xFF7DD856),)),
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
                            Text('Subtotal:',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff1A2E33)
                              ),),
                            Spacer(),
                            Text( '€12.99',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
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
                            Text('Delivery fee:',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff1A2E33)
                              ),),
                            Spacer(),
                            Text( '€5.00',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
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
                            Text('Total:',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff1A2E33)
                              ),),
                            Spacer(),
                            Text( '€17.99',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
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
                Get.toNamed(MyRouters.thankYouScreen);
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
