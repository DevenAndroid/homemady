import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/subscription_list_controller.dart';
import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';

class SubscriptionHistoryScreen extends StatefulWidget {
  const SubscriptionHistoryScreen({Key? key}) : super(key: key);
  static var subscriptionHistoryScreen = '/SubscriptionHistoryScreen';
  @override
  State<SubscriptionHistoryScreen> createState() => _SubscriptionHistoryScreenState();
}

class _SubscriptionHistoryScreenState extends State<SubscriptionHistoryScreen> {
  final controller = Get.put(SubscriptionListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: backAppBar(title: 'Subscribe Plan', context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ controller.isDataLoading.value ?
           ListView.builder(
             physics: const BouncingScrollPhysics(),
               shrinkWrap: true,
               itemBuilder: (BuildContext context,int index){
             return GestureDetector(
               onTap: (){

               },child:  Container(
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10),
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
                 padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text('€ 9.99',
                           style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w600,
                               fontSize: 15,
                               color: Colors.black
                           ),),
                         Container(
                           decoration: BoxDecoration(
                             color: Color(0xFF6BC743),
                             borderRadius: BorderRadius.circular(5),
                           ),
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                             child: Text('Active',
                               style: GoogleFonts.poppins(
                                   fontWeight: FontWeight.w600,
                                   fontSize: 15,
                                   color: Colors.white
                               ),),
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 10,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text('Purchased on',
                           style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w300,
                               fontSize: 15,
                               color: Colors.black
                           ),),
                         Text('10 Aug, 2023 08:20PM',
                           style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w300,
                               fontSize: 15,
                               color: Colors.black
                           ),),
                       ],
                     ),
                     SizedBox(height: 15,),
                     Divider(
                       height: 3,
                       color: Color(0xFFD9D9D99E),
                     ),
                     SizedBox(height: 10,),
                     Text('Transition Details',
                       style: GoogleFonts.poppins(
                           fontWeight: FontWeight.w600,
                           fontSize: 15,
                           color: Colors.black
                       ),),
                     SizedBox(height: 10,),
                     Row(
                       children: [
                         Text('Order ID',
                           style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w300,
                               fontSize: 15,
                               color: Colors.black
                           ),),
                         Spacer(),
                         Text('TB854239941',
                           style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w300,
                               fontSize: 15,
                               color: Colors.black
                           ),),
                       ],
                     ),
                     SizedBox(height: 5,),
                     Row(
                       children: [
                         Text('Payment Mode',
                           style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w300,
                               fontSize: 15,
                               color: Colors.black
                           ),),
                         Spacer(),
                         Text('Stripe',
                           style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w300,
                               fontSize: 15,
                               color: Colors.black
                           ),),
                       ],
                     ),
                     SizedBox(height: 5,),
                     Row(
                       children: [
                         Text('Plan Start Date',
                           style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w300,
                               fontSize: 15,
                               color: Colors.black
                           ),),
                         Spacer(),
                         Text('10 Aug, 2023',
                           style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w300,
                               fontSize: 15,
                               color: Colors.black
                           ),),
                       ],
                     ),
                     SizedBox(height: 5,),
                     Row(
                       children: [
                         Text('Plan End Date',
                           style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w300,
                               fontSize: 15,
                               color: Colors.black
                           ),),
                         Spacer(),
                         Text('11 Sep, 2023',
                           style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w300,
                               fontSize: 15,
                               color: Colors.black
                           ),),
                       ],
                     ),
                   ],
                 ),
               ),
             ),
             );
           }): const Center(child:  CircularProgressIndicator())

          ],
        ),
      ),
    );
  }
}