import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_size.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Padding( padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Image.asset('assets/images/avtarImg.png',height: 45,),
                        addWidth(6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Address',style: GoogleFonts.poppins(
                              color: const Color(0xFF636869),
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),),
                            addHeight(3),
                            Row(
                              children: [
                                Image.asset('assets/images/location.png',height: 13,),
                                addWidth(4),
                                Text('News Work City',style: GoogleFonts.poppins(
                                  color: const Color(0xFF000000),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),),
                                addWidth(4),
                                Image.asset('assets/images/pencilImg.png',height: 13,),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        InkWell(
                          child: Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF7ED957)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/shoppingImg.png',height: 30,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              Padding(padding: const EdgeInsets.only(left: 19,top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Text('Hello',
                       style: GoogleFonts.poppins(
                         color: const Color(0xFF676767),
                         fontWeight: FontWeight.w300,
                         fontSize: 16
                       ),
                       ),
                       Text('Alexandra',
                         style: GoogleFonts.poppins(
                             color: const Color(0xFF353535),
                             fontWeight: FontWeight.w600,
                             fontSize: 22
                         ),
                       ),
                     ],
                   ),
                  addHeight(20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 42,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  offset: const Offset(.1, .1,
                                  ),
                                  blurRadius: 20.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                              color: Colors.white
                          ),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior
                                  .never,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(8),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              fillColor: Colors.black,
                              //focusColor: Colors.black,
                              labelText: 'Search',
                              labelStyle: TextStyle(color: Color(0xFFABB1BA)),
                              prefixIcon: Icon(Icons.search_rounded,
                                color: Color(0xFFABB1BA), size: 18,),

                            ),
                            //suffix: Icon(Icons.search),
                            //hint: 'search',
                            // prefix: Icon(Icons.camera_alt_outlined),
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF7ED957)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/filterImg.png', height: 18,),
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                             border: Border.all(
                                 color: const Color(0xFF7ED957)
                             )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/sort-descending.png', height: 18,),

                          ),
                        ),
                      ),
                      addWidth(22)
                    ],
                  ),
                  addHeight(26),
                  SizedBox(
                    height: 144,
                    child: ListView.builder(
                        itemCount: 3,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                child: Image.asset('assets/images/slider.png'),
                              ),
                              addWidth(20)
                            ],
                          );
                        },
                    ),
                  ),
                  addHeight(14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 44,
                          width: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: const Color(0xFF7ED957)
                              )
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/clockImg.png', height: 18,),
                              ),
                              Text('Delivery Now',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF7ED957),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      addWidth(10),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 44,
                          width: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color(0xFF7ED957)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/truckimg.png', height: 18,),
                              ),
                              Text('Pick a Date',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFFFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  addHeight(20),

                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                         return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                           child: Stack(
                             children: [
                                Image.asset('assets/images/Rectangle 2171.png'),
                               Positioned(
                                 top: 0,
                                   bottom: 0,
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Icon(Icons.arrow_back_ios,color: Colors.white,),
                                       Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                     ],
                                   )
                               )
                             ],
                           ),
                         );
                      },
                    ),
                  )
                ],
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
