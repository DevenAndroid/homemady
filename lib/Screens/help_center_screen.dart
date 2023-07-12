import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/dimenestion.dart';




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
      appBar: AppBar(
        toolbarHeight: 80,
        //elevation: 1,
        //shadowColor: Colors.grey.shade300,
        titleSpacing: 30,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
        ),
        leadingWidth: AddSize.size40 * 0.9,
        title: const Text( 'Help Center',
          style:TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xFF303D48)
          ),
        ),
      ),
      body:  Column(
        children: [

         Card(
           child: Padding(
             padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 10),
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
         Card(
           color: const Color(0xffFFFFFF),
           surfaceTintColor: Color(0xffFFFFFF),
           child: Padding(
             padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 10),
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
         Card(
           child: Padding(
             padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 10),
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
    );
  }
}
