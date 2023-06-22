import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/dimenestion.dart';


class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
               children: [
                 addHeight(62),
                  Image.asset('assets/images/thankyouImg.png',width: 232,),
                 addHeight(15),
                 Text('Thank You!',
                 style: GoogleFonts.poppins(
                   fontSize: 65,
                   fontWeight: FontWeight.w400,
                   color: Color(0xFF423E5E),
                 ),
                 ),
                 addHeight(5),
                 Text('Your Order Has Been Successfull',
                   style: GoogleFonts.poppins(
                     fontSize: 14,
                     fontWeight: FontWeight.w300,
                     color: Color(0xFF5E6F71),
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
                             fontWeight: FontWeight.w500,
                             color: Color(0xFF1A2E33),
                           ),
                         ),

                         Text('#254600',
                           style: GoogleFonts.poppins(
                             fontSize: 14,
                             fontWeight: FontWeight.w400,
                             color: Color(0xFF486769),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
                 addHeight(140),
                 InkWell(
                   onTap: () {
                     // Get.back();
                   },
                   child: Container(
                     height: 55,
                     width: AddSize.screenWidth,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(4),
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
                   onTap: () {},
                   child: Container(
                     height: 55,
                     width: AddSize.screenWidth,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(4),
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
    );
  }
}
