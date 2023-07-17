import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';


class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  bool? _isValue = false;
  bool? _isValue1 = false;
  bool? _isValue2 = false;
  bool? _isValue3 = false;
  bool? _isValue4 = false;
  bool? _isValue5 = false;
  bool? _isValue6 = false;
  bool? _isValue7 = false;
  bool? _isValue8 = false;
  bool? _isValue9 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: 'My Cart', context: context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11.0,vertical: 15),
          child: Column(
            children: [
              addHeight(10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                   return Column(
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
                                   onPressed: (context) {},
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
                                       Text('Panna Onion Pasta',
                                         style: GoogleFonts.poppins(
                                             fontWeight: FontWeight.w600,
                                             fontSize: 16,
                                             color: const Color(0xFF21283D)
                                         ),),
                                       addHeight(3),
                                       Row(
                                         children: [
                                           Text('3 Items ',
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
                                           Text('1.5km',
                                             style: GoogleFonts.poppins(
                                                 fontWeight: FontWeight.w400,
                                                 fontSize: 12,
                                                 color: const Color(0xFF486769).withOpacity(0.70)
                                             ),),
                                         ],
                                       ),
                                       addHeight(5),
                                       Text('€6.99',
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
                   );
                },
              ),
              addHeight(10),
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
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff303D46)
                          ),),
                      ],
                    ),
                  ),
                  addHeight(6),
                  Wrap(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                            activeColor: const Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue = value;
                              });
                            }),
                      ),
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                            activeColor: const Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue1,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue1 = value;
                              });
                            }),
                      ),
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                            activeColor: const Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue2,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue2 = value;
                              });
                            }),
                      ),
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                            activeColor: const Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue3,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue3 = value;
                              });
                            }),
                      ),
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                            activeColor: const Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue4,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue4 = value;
                              });
                            }),
                      ),
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                            activeColor: const Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue5,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue5 = value;
                              });
                            }),
                      ),
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                            activeColor: const Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue6,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue6 = value;
                              });
                            }),
                      ),
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                            activeColor: const Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue7,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue7 = value;
                              });
                            }),
                      ),
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                            activeColor: const Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue8,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue8 = value;
                              });
                            }),
                      ),
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            side: BorderSide(color: Colors.grey.shade300,width: 1.4),
                            activeColor: const Color(0xff7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(3)),
                            value: _isValue9,
                            onChanged: (bool? value) {
                              setState(() {
                                _isValue9 = value;
                              });
                            }),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(15,10,14,0),
                  //   child: Wrap(
                  //     children: List.generate(10, (index){
                  //       return Expanded(
                  //         child: Transform.scale(
                  //           scale: 1.5,
                  //           child: Checkbox(
                  //               activeColor: const Color(0xff7ED957),
                  //               // focusColor: Colors.black,
                  //               shape: RoundedRectangleBorder(
                  //                 // side: BorderSide(color: Colors.grey),
                  //                   borderRadius:
                  //                   BorderRadius.circular(3)),
                  //               value: _isValue,
                  //               onChanged: (bool? value) {
                  //                 setState(() {
                  //                   _isValue = value;
                  //                 });
                  //               }),
                  //         ),
                  //       );
                  //     }),
                  //   ),
                  // ),
                  addHeight(20)
                ],

              ),
                ),
              addHeight(20),
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
                padding: const EdgeInsets.fromLTRB(15,18,14,0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Subtotal:',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff1A2E33)
                          ),),
                        const Spacer(),
                        Text( '€12.99',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff486769)
                          ),),
                      ],
                    ),
                    addHeight(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Tax and fee:',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff1A2E33)
                          ),),
                        const Spacer(),
                        Text( '€5.00',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff486769)
                          ),),
                      ],
                    ),
                    addHeight(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Delivery:',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff1A2E33)
                          ),),
                        const Spacer(),
                        Text( 'Free',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff486769)
                          ),),
                      ],
                    ),
                    addHeight(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Total:',
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff6BC744)
                          ),),
                        const Spacer(),
                        Text( '€17.99',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff6BC744)
                          ),),
                      ],
                    ),
                    addHeight(20)
                  ],

                ),
              ),
              addHeight(25),
               CommonButton(title: 'Check out',onPressed: (){
                   Get.toNamed(MyRouters.checkOutScreen);
               },),
              addHeight(20),
            ],
          ),
        ),
      ),
    );
  }
}
