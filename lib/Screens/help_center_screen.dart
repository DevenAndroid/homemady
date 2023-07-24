import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';

import '../routers/routers.dart';




class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);
  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: backAppBar(title: 'Help Center', context: context),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
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
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              child: GestureDetector(
                onTap: (){
                  Get.toNamed(MyRouters.chatScreen);
                },
                child: Row(
                 children: [
                   Image.asset(
                     'assets/images/helpMsg.png',
                     width: 52,
                     height:40,
                   ),
                   SizedBox(width: 20,),
                   Text("Chat/Email", style:GoogleFonts.poppins(
                       fontWeight: FontWeight.w500,
                       fontSize: 19,
                       color: Color(0xFF1A2E33)
                   ),),
                 ],
             ),
              ),
           ),
           addHeight(15),
           Container(
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(4),
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
             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
             child: GestureDetector(
               onTap: (){
                 Get.toNamed(MyRouters.chatScreen);
               },
               child: Row(
                 children: [
                   Image.asset(
                     'assets/images/headphone.png',
                     width: 52,
                     height:40,
                   ),
                   SizedBox(width: 20,),
                   Text("HomeMady team", style:GoogleFonts.poppins(
                       fontWeight: FontWeight.w500,
                       fontSize: 19,
                       color: Color(0xFF1A2E33)
                   ),),
                 ],
               ),
             ),
           ),
            addHeight(15),
            GestureDetector(
              onTap: (){
                Get.toNamed(MyRouters.faqsScreen);
              },
              child: Container(
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(4),
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
               padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
               child: Row(
                 children: [
                   Image.asset(
                     'assets/images/faq.png',
                     width: 52,
                     height:40,
                   ),
                   SizedBox(width: 20,),
                   Text("FAQ", style:GoogleFonts.poppins(
                       fontWeight: FontWeight.w500,
                       fontSize: 19,
                       color: Color(0xFF1A2E33)
                   ),),
                 ],
               ),
           ),
            ),
          ],
        ),
      ),
    );
  }
}
