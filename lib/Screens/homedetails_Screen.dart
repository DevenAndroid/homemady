import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';


class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({Key? key}) : super(key: key);

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen>   with TickerProviderStateMixin{
  RxBool isSelect = false.obs;
 late TabController tabController;
  @override
  void initState() {
    super.initState();
    // vendorOrderListController.filter.value = "";
    // vendorOrderListController.vendorOrderListData();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Column(
           children: [
             Stack(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment
                         .start,
                     children: [
                       Image.asset(
                           'assets/images/Rectangle 23007.png'),
                       addHeight(20),
                       Text('Burger King with Pizza',
                         style: GoogleFonts.poppins(
                             fontWeight: FontWeight.w600,
                             fontSize: 16,
                             color: const Color(0xFF21283D)
                         ),),
                       addHeight(10),
                       Text('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                         style: GoogleFonts.poppins(
                             fontWeight: FontWeight.w300,
                             fontSize: 12,
                             color: const Color(0xFF364A4F)
                         ),),
                       addHeight(20),
                      const Divider(
                         color: Color(0xFFF2F2F2),
                         thickness: 2,
                         height: 1,
                       ),
                       addHeight(5),
                       Row(
                         children: [
                            Image.asset('assets/images/favImg.png',height: 18,),
                           addWidth(7),
                           Text('5.0',
                               style: GoogleFonts.poppins(
                                 fontSize: 16,
                                 color: const Color(0xFF1A2E33),
                                 fontWeight: FontWeight.w500,)),
                           addWidth(7),
                           Text('(4.8k reviews)',
                               style: GoogleFonts.poppins(
                                 fontSize: 12,
                                 color: const Color(0xFF4E5F64),
                                 fontWeight: FontWeight.w400,)),
                           const Spacer(),
                           IconButton(
                               onPressed: (){},
                               icon: const Icon(Icons.arrow_forward_ios,size: 13,))

                         ],
                       ),
                       addHeight(5),
                       const Divider(
                         color: Color(0xFFF2F2F2),
                         thickness: 2,
                         height: 1,
                       ),
                       addHeight(15),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Image.asset('assets/images/location-my.png',height: 20,color: const Color(0xFF6AC643),),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text('10.km',
                                   style: GoogleFonts.poppins(
                                     fontSize: 16,
                                     color: const Color(0xFF1A2E33),
                                     fontWeight: FontWeight.w600,)),
                               Text('Delivery Now',
                                   style: GoogleFonts.poppins(
                                     fontSize: 12,
                                     color: const Color(0xFF4E5F64),
                                     fontWeight: FontWeight.w400,)),

                             ],
                           ),
                           Container(
                             width: 1.5,
                             height: 30,
                             color: const Color(0xFFE7E7E7),
                           ),
                           Row(
                             children: [
                               Image.asset('assets/images/clockImg.png',height: 20,),
                               addWidth(7),
                               Text('25-40 Min',
                                   style: GoogleFonts.poppins(
                                     fontSize: 12,
                                     color: const Color(0xFF4E5F64),
                                     fontWeight: FontWeight.w400,)),
                             ],
                           ),
                           Container(
                             width: 1.5,
                             height: 30,
                             color: const Color(0xFFE7E7E7),
                           ),
                           Row(
                             children: [
                               Image.asset('assets/images/truckimg.png',height: 20,color: const Color(0xFF6AC643),),
                               addWidth(7),
                               Text('Delivery Only',
                                   style: GoogleFonts.poppins(
                                     fontSize: 12,
                                     color: const Color(0xFF4E5F64),
                                     fontWeight: FontWeight.w400,)),
                             ],
                           ),
                         ],
                       ),
                       addHeight(16),
                     ],
                   ),
                 ),
                 Positioned(
                     top: 210,
                     // bottom: 0,
                     left: 239,
                     right: 0,
                     //   bottom: 0,
                     child: Column(
                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                             height: 67,
                             decoration: const BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: Colors.white
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(3),
                               child: Image.asset(
                                   'assets/images/avtarImg.png'),
                             )
                         ),
                         addHeight(3),
                       ],
                     )
                 ),
                 Positioned(
                     top: 20,
                     // right: 0,
                   left: 10,
                     child: Column(
                       children: [
                         Container(
                             height: 30,
                             decoration: const BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: Colors.white
                             ),
                             child: Padding(
                               padding: const EdgeInsets
                                   .only(left: 10,
                                   right: 10,
                                   top: 3),
                               child: InkWell(
                                 onTap: () {
                                   Get.back();
                                 },
                                 child: const Icon(Icons.arrow_back,
                                   color: Colors.black),
                               ),
                             )
                         ),
                       ],
                     ),
                 ),
                 Positioned(
                     top: 20,
                     right: 14,
                     child: Obx(() {
                       return Row(
                         children: [
                           Container(
                               height: 30,
                               decoration: const BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Colors.white
                               ),
                               child: Padding(
                                 padding: const EdgeInsets
                                     .only(left: 10,
                                     right: 10,
                                     top: 3),
                                 child: InkWell(
                                   onTap: () {
                                   },
                                   child: const Icon(Icons.search,
                                     color: Color(
                                         0xFF54C523),),
                                 ),
                               )
                           ),
                           Container(
                               height: 30,
                               decoration: const BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Colors.white
                               ),
                               child:
                               Padding(
                                 padding: const EdgeInsets
                                     .only(left: 10,
                                     right: 10,
                                     top: 3),
                                 child: InkWell(
                                   onTap: () {
                                   },
                                   child: const Icon(Icons.share,
                                     color: Color(
                                         0xFF54C523),size: 20,),
                                 ),
                               )
                           ),
                           Container(
                               height: 30,
                               decoration: const BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Colors.white
                               ),
                               child: Padding(
                                 padding: const EdgeInsets
                                     .only(left: 10,
                                     right: 10,
                                     top: 3),
                                 child: InkWell(
                                   onTap: () {
                                     isSelect.value =
                                     !isSelect.value;
                                   },
                                   child: isSelect.value ==
                                       true
                                       ? const Icon(
                                     Icons.favorite,
                                     color: Color(0xFF54C523),)
                                       :
                                   const Icon(Icons.favorite_outline,
                                     color: Color(
                                         0xFF54C523),),
                                 ),
                               )
                           ),
                         ],
                       );
                     })
                 ),
                 Positioned(
                     top: 210,
                     // bottom: 0,
                     left: 10,
                     right: 15,
                     //   bottom: 0,
                     child: Row(
                       children:  [

                         InkWell(
                             onTap: (){
                               showGeneralDialog(
                                   context: context,
                                   barrierDismissible: true,
                                   barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                   barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                   pageBuilder: (BuildContext context,Animation first, Animation second){
                                     return  Stack(
                                       children: [
                                         Center(child: Image.asset('assets/images/dialogboximg.png')),
                                         Positioned(
                                           right: 18,
                                           top: 50,
                                           child: Container(
                                             height: 50,
                                             decoration: const BoxDecoration(
                                                 color: Colors.white,
                                                 shape: BoxShape.circle
                                             ),
                                             child:  IconButton(
                                                 onPressed: (){
                                                   Get.back();
                                                 },
                                                 icon: const Icon(Icons.clear)),
                                           ),)
                                       ],
                                     );
                                   }
                               );
                             },
                             child: Image.asset('assets/images/topChef.png',width: 40,)),
                         InkWell(
                             onTap: (){
                               showGeneralDialog(
                                   context: context,
                                   barrierDismissible: true,
                                   barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                   barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                   pageBuilder: (BuildContext context,Animation first, Animation second){
                                     return  Stack(
                                       children: [
                                         Center(child: Image.asset('assets/images/dialogboximg.png')),
                                         Positioned(
                                           right: 18,
                                           top: 50,
                                           child: Container(
                                             height: 50,
                                             decoration: const BoxDecoration(
                                                 color: Colors.white,
                                                 shape: BoxShape.circle
                                             ),
                                             child:  IconButton(
                                                 onPressed: (){
                                                   Get.back();
                                                 },
                                                 icon: const Icon(Icons.clear)),
                                           ),)
                                       ],
                                     );
                                   }
                               );
                             },
                             child: Image.asset('assets/images/topChef.png',width: 40,)),
                       ],
                     )
                 ),
               ],
             ),
             Card(
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
               elevation: 0,
               child: Container(
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
                 child: TabBar(
                   indicator: BoxDecoration(
                     borderRadius: BorderRadius.circular(100),
                     color: Colors.green
                   ),
                   // indicatorColor: const Color(0xFF7ED957),
                   // labelColor: const Color(0xff7ED957),
                   labelPadding: EdgeInsets.symmetric(horizontal: 30),
                   unselectedLabelColor: const Color(0xff616A75),
                   controller: tabController,
                   isScrollable: true,
                   tabs: const[
                     Tab(
                       text: 'A la carte',
                     ),
                     Tab(
                       text: 'Catering',
                     ),
                     Tab(
                       text: 'Meal Prep',
                     ),
                   ],
                 ),
               ),
             ),
             addHeight(10),
             Expanded(
               child: TabBarView(
                 physics: const BouncingScrollPhysics(),
                   controller: tabController, children: <Widget>[
                 SingleChildScrollView(
                   child: Column(
                     children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 3,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                               return Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                       boxShadow: [
                                           BoxShadow(
                                             color: const Color(0xFF37C666).withOpacity(0.10),
                                             offset: const Offset(.1, .1,
                                             ),
                                             blurRadius: 20.0,
                                             spreadRadius: 1.0,
                                           ),
                                         ],
                                     borderRadius: BorderRadius.circular(12)
                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.all(15.0),
                                     child: InkWell(
                                       onTap: (){
                                         Get.toNamed(MyRouters.myCartScreen);
                                       },
                                       child: Row(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: [
                                           Image.asset('assets/images/Rectangle 39762.png',height: 68,),
                                           addWidth(10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Special Burger',
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 14,
                                                          color: const Color(0xFF21283D)
                                                      ),),
                                                      addWidth(110),
                                                      Text('€6.99',
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 14,
                                                          color: const Color(0xFF70CC49)
                                                      ),),

                                                  ],
                                                ),
                                                addHeight(3),
                                                Text('Size: 200gm',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 10,
                                                      color: const Color(0xFF364A4F)
                                                  ),),
                                                addHeight(4),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text('spiciness',
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w300,
                                                              fontSize: 8,
                                                              color: const Color(0xFF1F2D30)
                                                          ),),
                                                        addWidth(4),
                                                        Text('Mildly Spicy',
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 8,
                                                              color: const Color(0xFF6CC844)
                                                          ),),
                                                      ],
                                                    ),
                                                    addWidth(30),
                                                    Row(
                                                      children: [
                                                        Text('spiciness',
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w300,
                                                              fontSize: 8,
                                                              color: const Color(0xFF1F2D30)
                                                          ),),
                                                        addWidth(4),
                                                        Text('Mildly Spicy',
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 8,
                                                              color: const Color(0xFF6CC844)
                                                          ),),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                addHeight(6),
                                                IntrinsicHeight(
                                                  child:
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap:
                                                            () {
                                                        },
                                                        child:
                                                        Container(
                                                          decoration: BoxDecoration(border: Border.all(color: const Color(0xFF72CD4A)), shape: BoxShape.circle),
                                                          alignment: Alignment.center,
                                                          child: const Padding(
                                                            padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                            child: Text(
                                                              '-',
                                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF72CD4A)),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment:
                                                        Alignment.center,
                                                        child:
                                                       const Padding(
                                                          padding: EdgeInsets.only(left: 14.0, right: 14.0),
                                                          child: Text(
                                                              '1'
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap:
                                                            () {

                                                        },
                                                        child:
                                                        Container(
                                                            decoration: BoxDecoration(border: Border.all(color: const Color(0xFF72CD4A)), shape: BoxShape.circle),
                                                          alignment: Alignment.center,
                                                          child: const Padding(
                                                            padding:  EdgeInsets.symmetric(horizontal: 8),
                                                            child: Text(
                                                              '+',
                                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Color(0xFF72CD4A)),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                addHeight(6),
                                               Container(
                                                 color: Color(0xFFE9E9E9),
                                                 width: 250,
                                                 height: 1,
                                               ),
                                                addHeight(4),
                                                Row(
                                                  children: [
                                                    Image.asset('assets/images/helpimg.png',height: 12,),
                                                    addWidth(4),
                                                    Text('Can cook more units by: 30th June 2023',
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w300,
                                                          fontSize: 10,
                                                          color: const Color(0xFF364A4F)
                                                      ),),
                                                  ],
                                                ),
                                                addHeight(4),
                                                Row(
                                                  children: [
                                                    Image.asset('assets/images/helpimg.png',height: 12,),
                                                    addWidth(4),
                                                    Text('Can cook more units by: 30th June 2023',
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w300,
                                                          fontSize: 10,
                                                          color: const Color(0xFF364A4F)
                                                      ),),
                                                  ],
                                                ),
                                              ],
                                            )
                                         ],
                                       ),
                                     ),
                                   ),
                                 ),
                               );
                            },
                        ),
                     ],
                   ),
                 ),
                 SingleChildScrollView(
                   child: Column(
                     children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 3,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                               return Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                       boxShadow: [
                                           BoxShadow(
                                             color: const Color(0xFF37C666).withOpacity(0.10),
                                             offset: const Offset(.1, .1,
                                             ),
                                             blurRadius: 20.0,
                                             spreadRadius: 1.0,
                                           ),
                                         ],
                                     borderRadius: BorderRadius.circular(12)
                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.all(15.0),
                                     child: Row(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         Image.asset('assets/images/Rectangle 39762.png',height: 68,),
                                         addWidth(10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('Special Burger',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14,
                                                        color: const Color(0xFF21283D)
                                                    ),),
                                                    addWidth(110),
                                                    Text('€6.99',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14,
                                                        color: const Color(0xFF70CC49)
                                                    ),),

                                                ],
                                              ),
                                              addHeight(3),
                                              Text('Size: 200gm',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10,
                                                    color: const Color(0xFF364A4F)
                                                ),),
                                              addHeight(4),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('spiciness',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 8,
                                                            color: const Color(0xFF1F2D30)
                                                        ),),
                                                      addWidth(4),
                                                      Text('Mildly Spicy',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 8,
                                                            color: const Color(0xFF6CC844)
                                                        ),),
                                                    ],
                                                  ),
                                                  addWidth(30),
                                                  Row(
                                                    children: [
                                                      Text('spiciness',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 8,
                                                            color: const Color(0xFF1F2D30)
                                                        ),),
                                                      addWidth(4),
                                                      Text('Mildly Spicy',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 8,
                                                            color: const Color(0xFF6CC844)
                                                        ),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              addHeight(6),
                                              IntrinsicHeight(
                                                child:
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap:
                                                          () {
                                                      },
                                                      child:
                                                      Container(
                                                        decoration: BoxDecoration(border: Border.all(color: const Color(0xFF72CD4A)), shape: BoxShape.circle),
                                                        alignment: Alignment.center,
                                                        child: const Padding(
                                                          padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                          child: Text(
                                                            '-',
                                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color:const Color(0xFF72CD4A)),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                      Alignment.center,
                                                      child:
                                                      const Padding(
                                                        padding: EdgeInsets.only(left: 14.0, right: 14.0),
                                                        child: Text(
                                                            '1'
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap:
                                                          () {

                                                      },
                                                      child:
                                                      Container(
                                                        decoration: BoxDecoration(border: Border.all(color: const Color(0xFF72CD4A)), shape: BoxShape.circle),
                                                        alignment: Alignment.center,
                                                        child: const Padding(
                                                          padding:  EdgeInsets.symmetric(horizontal: 8),
                                                          child: Text(
                                                            '+',
                                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF72CD4A)),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              addHeight(6),
                                             Container(
                                               color: Color(0xFFE9E9E9),
                                               width: 250,
                                               height: 1,
                                             ),
                                              addHeight(4),
                                              Row(
                                                children: [
                                                  Image.asset('assets/images/helpimg.png',height: 12,),
                                                  addWidth(4),
                                                  Text('Can cook more units by: 30th June 2023',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 10,
                                                        color: const Color(0xFF364A4F)
                                                    ),),
                                                ],
                                              ),
                                              addHeight(4),
                                              Row(
                                                children: [
                                                  Image.asset('assets/images/helpimg.png',height: 12,),
                                                  addWidth(4),
                                                  Text('Can cook more units by: 30th June 2023',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 10,
                                                        color: const Color(0xFF364A4F)
                                                    ),),
                                                ],
                                              ),
                                            ],
                                          )
                                       ],
                                     ),
                                   ),
                                 ),
                               );
                            },
                        ),
                     ],
                   ),
                 ),
                 SingleChildScrollView(
                   child: Column(
                     children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 3,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                               return Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                       boxShadow: [
                                           BoxShadow(
                                             color: const Color(0xFF37C666).withOpacity(0.10),
                                             offset: const Offset(.1, .1,
                                             ),
                                             blurRadius: 20.0,
                                             spreadRadius: 1.0,
                                           ),
                                         ],
                                     borderRadius: BorderRadius.circular(12)
                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.all(15.0),
                                     child: Row(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         Image.asset('assets/images/Rectangle 39762.png',height: 68,),
                                         addWidth(10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('Special Burger',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14,
                                                        color: const Color(0xFF21283D)
                                                    ),),
                                                    addWidth(110),
                                                    Text('€6.99',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14,
                                                        color: const Color(0xFF70CC49)
                                                    ),),

                                                ],
                                              ),
                                              addHeight(3),
                                              Text('Size: 200gm',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10,
                                                    color: const Color(0xFF364A4F)
                                                ),),
                                              addHeight(4),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('spiciness',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 8,
                                                            color: const Color(0xFF1F2D30)
                                                        ),),
                                                      addWidth(4),
                                                      Text('Mildly Spicy',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 8,
                                                            color: const Color(0xFF6CC844)
                                                        ),),
                                                    ],
                                                  ),
                                                  addWidth(30),
                                                  Row(
                                                    children: [
                                                      Text('spiciness',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 8,
                                                            color: const Color(0xFF1F2D30)
                                                        ),),
                                                      addWidth(4),
                                                      Text('Mildly Spicy',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 8,
                                                            color: const Color(0xFF6CC844)
                                                        ),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              addHeight(6),
                                              IntrinsicHeight(
                                                child:
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap:
                                                          () {
                                                      },
                                                      child:
                                                      Container(
                                                        decoration: BoxDecoration(border: Border.all(color: const Color(0xFF72CD4A)), shape: BoxShape.circle),
                                                        alignment: Alignment.center,
                                                        child: const Padding(
                                                          padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                          child: Text(
                                                            '-',
                                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF72CD4A)),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                      Alignment.center,
                                                      child:
                                                      const Padding(
                                                        padding: EdgeInsets.only(left: 14.0, right: 14.0),
                                                        child: Text(
                                                            '1'
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap:
                                                          () {

                                                      },
                                                      child:
                                                      Container(
                                                        decoration: BoxDecoration(border: Border.all(color: const Color(0xFF72CD4A)), shape: BoxShape.circle),
                                                        alignment: Alignment.center,
                                                        child: const Padding(
                                                          padding:  EdgeInsets.symmetric(horizontal: 8),
                                                          child: Text(
                                                            '+',
                                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Color(0xFF72CD4A)),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              addHeight(6),
                                             Container(
                                               color: Color(0xFFE9E9E9),
                                               width: 250,
                                               height: 1,
                                             ),
                                              addHeight(4),
                                              Row(
                                                children: [
                                                  Image.asset('assets/images/helpimg.png',height: 12,),
                                                  addWidth(4),
                                                  Text('Can cook more units by: 30th June 2023',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 10,
                                                        color: const Color(0xFF364A4F)
                                                    ),),
                                                ],
                                              ),
                                              addHeight(4),
                                              Row(
                                                children: [
                                                  Image.asset('assets/images/helpimg.png',height: 12,),
                                                  addWidth(4),
                                                  Text('Can cook more units by: 30th June 2023',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 10,
                                                        color: const Color(0xFF364A4F)
                                                    ),),
                                                ],
                                              ),
                                            ],
                                          )
                                       ],
                                     ),
                                   ),
                                 ),
                               );
                            },
                        ),
                     ],
                   ),
                 ),
               ]),
             )
           ],
         ),
       ),
    );
  }
}
