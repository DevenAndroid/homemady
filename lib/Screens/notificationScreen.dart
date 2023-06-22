import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: backAppBar(title: "Notification", context: context),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.only(left: 8, right: 8, bottom: 16),
                    child: Container(
                      height: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF04666E).withOpacity(0.14),
                              spreadRadius: 1.0,
                              blurRadius: 20.0,
                              offset: Offset(3.0, 3.0))
                        ],
                      ),
                      width: Get.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          addWidth(8),
                          Container(
                            height: 60,
                            width: 3,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Color(0xff7ED957),
                            ),
                            // child: VerticalDivider(
                            //   color: Color(0xffFF6100),
                            //   thickness: 2.5,
                            // ),
                          ),
                          const SizedBox(width: 13,),
                          const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircleAvatar(
                              backgroundColor: Color(0xff7ED957),
                              child: Text(
                                'B',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6,),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                 Padding(
                                  padding:
                                 const EdgeInsets.only(left: 10, right: 6),
                                  child: Text(
                                    'Date - 17-02-2022',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff7ED957),
                                    ),
                                  ),
                                ),
                                 Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 2),
                                  child: Text(
                                    'Lorem ipsum dolor sit amet',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                ),
                                 Padding(
                                  padding: const  EdgeInsets.only(top: 2, left: 10,right: 10),
                                  child: Text(
                                    'Lorem ipsum dolor sit amet consecrate disciplining elit sed do eiusmod',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: const Color(0xff292F34),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

