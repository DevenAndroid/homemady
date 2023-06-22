import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
         child: Column(
           children: [
             ListView.builder(
                 physics: AlwaysScrollableScrollPhysics(),
                 itemCount: 2,
                 shrinkWrap: true,
                 scrollDirection: Axis.vertical,
                 itemBuilder: (context, index) {
                   return InkWell(
                     onTap: (){
                       // Get.toNamed(VendorOrderDetails1.vendorOrderDetails1);
                     },
                     child: Padding(
                       padding: const EdgeInsets.only(
                           left: 13, right: 13, bottom: 8),
                       child: Container(
                         height: 112,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(11),
                             boxShadow: [

                               BoxShadow(
                                 color: Colors.grey.shade300,
                                 offset: const Offset(.1, .1,
                                 ),
                                 blurRadius: 20.0,
                                 spreadRadius: 1.0,
                               ),
                             ],
                             color: Colors.white),
                         width: Get.width,
                         child: Row(
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(left: 14),
                               child: Container(
                                 height: 88,
                                 width: 88,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     color: Color(0x12ff7e02)),
                                 child: Center(
                                     child: Padding(
                                       padding: const EdgeInsets.all(20),
                                       child: Image.asset(
                                           'assets/images/ordercart.png'),
                                     )),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(12.0),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Row(
                                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         'Order ID:',
                                         style: TextStyle(
                                           fontSize: 15,
                                           fontWeight: FontWeight.w500,
                                           color: Color(0xff293044),
                                         ),
                                       ),
                                       SizedBox(width: 10,),
                                       Container(
                                         padding: EdgeInsets.symmetric(horizontal: 7,vertical: 7),
                                         decoration: BoxDecoration(
                                             color: Color(0xFFFFEFD6),
                                             borderRadius:
                                             BorderRadius.circular(50)),
                                         child:
                                         Text(
                                           '',
                                           style: TextStyle(
                                               fontWeight: FontWeight.w500,
                                               fontSize: 10,
                                               color: Color(0xffFF9D00)),
                                         ),
                                       )
                                     ],
                                   ),
                                   Text(
                                     '',
                                     style: TextStyle(
                                       fontSize: 11,
                                       fontWeight: FontWeight.w400,
                                       color: Color(0xff1D2848),
                                     ),
                                   ),
                                   Text(
                                     'Total Amount:',
                                     style: TextStyle(
                                       fontSize: 12,
                                       fontWeight: FontWeight.w400,
                                       color: Color(0xff545F7E),
                                     ),
                                   ),
                                   Row(
                                     children: [
                                       Text(
                                         'Date:',
                                         style: TextStyle(
                                           fontSize: 12,
                                           fontWeight: FontWeight.w400,
                                           color: Color(0xff727786),
                                         ),
                                       ),
                                       SizedBox(
                                         width: 15,
                                       ),
                                       Text(
                                         'Time:',
                                         style: TextStyle(
                                           fontSize: 12,
                                           fontWeight: FontWeight.w400,
                                           color: Color(0xff727786),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                   );
                 })
           ],
         ),
      ),
    );
  }
}
