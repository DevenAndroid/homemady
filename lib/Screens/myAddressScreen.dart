import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';


class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({Key? key}) : super(key: key);

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context: context,title: 'My Address'),
body: SingleChildScrollView(
  child:   Column(
    
      children: [
  addHeight(30),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index) {
              
             return      Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children: [
                   Row(
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
                   addHeight(20)
                 ],
               ),
             );
          },),
        )
      ],
  ),
),
    );
  }
}
