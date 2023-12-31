import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'orderDetailsScreen.dart';


class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({super.key, required this.orderId});
  final String orderId;

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}


class _ThankYouScreenState extends State<ThankYouScreen> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Get.offAllNamed(MyRouters.bottomNavbar);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   addHeight(62),
                    Image.asset('assets/images/orderEnd.png',width: 232,),
                   addHeight(15),
                   GestureDetector(
                     onTap: (){
                       // log(Get.arguments[0]);
                     },
                     child: Text('Thank You!',
                     style: GoogleFonts.ramaraja(
                       fontSize: 65,
                       fontWeight: FontWeight.w400,
                       color: const Color(0xFF423E5E),
                     ),
                     ),
                   ),
                   Text('Your Order Has Been Successfully',
                     style: GoogleFonts.poppins(
                       fontSize: 14,
                       fontWeight: FontWeight.w300,
                       color: const Color(0xFF5E6F71),
                     ),
                   ),
                   addHeight(25),
                   Container(
                     height: 66,
                     width: AddSize.screenWidth,
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
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text('Order ID:',
                             style: GoogleFonts.poppins(
                               fontSize: 16,
                               fontWeight: FontWeight.w600,
                               color: const Color(0xFF1A2E33),
                             ),
                           ),

                           Text("#${widget.orderId.toString()}",
                             style: GoogleFonts.poppins(
                               fontSize: 14,
                               fontWeight: FontWeight.w400,
                               color: const Color(0xFF486769),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                   addHeight(140),
                   InkWell(
                     onTap: () {
                       Get.to(()=> OrderDetailsScreen(
                         storeID: widget.orderId,
                       ));
                     },
                     child: Container(
                       height: 55,
                       width: AddSize.screenWidth,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           border: Border.all(
                               color: const Color(0xFF7ED957)
                           )
                       ),
                       child: Center(
                         child: Text('order Details'.toUpperCase(),
                           style: GoogleFonts.poppins(
                             color: const Color(0xFF7ED957),
                             fontSize: 16,
                             fontWeight: FontWeight.w700,
                           ),
                           textAlign: TextAlign.center,
                         ),
                       ),
                     ),
                   ),
                   addHeight(10),
                   InkWell(
                     onTap: () {
                       Get.offAllNamed(MyRouters.bottomNavbar);
                     },
                     child: Container(
                       height: 55,
                       width: AddSize.screenWidth,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: const Color(0xFF7ED957)
                       ),
                       child:
                       Center(
                         child: Text('Back To Home'.toUpperCase(),
                           style: GoogleFonts.poppins(
                             color: const Color(0xFFFFFFFF),
                             fontSize: 16,
                             fontWeight: FontWeight.w700,
                           ),
                           textAlign: TextAlign.center,
                         ),
                       ),
                     ),
                   ),
                 ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
