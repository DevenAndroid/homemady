import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';


class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> with TickerProviderStateMixin{
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    // vendorOrderListController.filter.value = "";
    // vendorOrderListController.vendorOrderListData();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: 'Order Details', context: context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            addHeight(15),
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
               child: Padding(
                 padding: const EdgeInsets.all(18.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Image.asset('assets/images/order_details.png',height: 18,),
                     addWidth(15),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Order ID: 8520255',style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                           fontSize: 15,
                           color: Color(0xFF7ED957)
                         ),),
                         Text('Monday, 2 June, 2021',style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                           fontSize: 11,
                           color: const Color(0xFF303C5E)
                         ),),

                       ],
                     ),
                     Spacer(),
                     Container(
                       height: 25,
                       width: 100,
                       decoration:  BoxDecoration(
                           borderRadius: BorderRadius.circular(6),
                           color: Color(0xFF7ED957)
                       ),
                       child: Center(
                         child: Text('Successful',
                           style: GoogleFonts.poppins(
                             color: const Color(0xFFFFFFFF),
                             fontSize: 12,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ),
            addHeight(15),
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
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/Rectangle 39702.png',height: 76,),
                            addWidth(15),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Panna Onion Pasta',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: const Color(0xFF1A2E33)
                                  ),),
                                addHeight(1),
                                Text('Quantity: 2',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: const Color(0xFF486769)
                                  ),),
                                addHeight(3),
                                Text('€12.99',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: const Color(0xFF70CC49)
                                  ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                     const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12,),
                        child: Divider(
                          color: Color(0xFFF2F2F2),
                          height: 1,
                          thickness: 1.2,
                        ),
                      ),

                    ],
                  );
              },),
            ),
            addHeight(15),
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
              child: Stack(
                children: [
                  Positioned.fill(
                      bottom: 2,
                      child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                              BorderSide(color: Color(0xFFD9D9D9), width: 1.0),
                            ),
                          ))),
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    physics: const BouncingScrollPhysics(),
                    labelColor: Color(0xFF1A2E33),
                    labelStyle: GoogleFonts.poppins(
                        color:  Color(0xFF1A2E33),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    controller: tabController,
                    unselectedLabelColor: const Color(0xFF909090),
                    indicator:  const  UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 5.0,
                        color: Color(0xFF7ED957),
                      ),
                    ),
                    tabs: const[
                      Tab(
                         text: 'Driver  Detail',
                      ),
                      Tab(
                        text: 'Home Cook Detail',
                      )
                    ],
                  ),
                ],
              ),
            ),
        Expanded(
          child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: tabController, children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5,top: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(  'Driver Name',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff486769)
                                      ),
                                    ),
                                   const SizedBox(
                                      height: 1,
                                    ),
                                    Text(  'Rajesh Sharma ',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff1A2E33)
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                  backgroundColor: Color(0xffFE7E73),
                                  child: Image.asset(
                                    'assets/images/user_account_profile.png',
                                    height: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5,top: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(  'Driver Number',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff486769)
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    Text(  '+91 9876454321',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff1A2E33)
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                  backgroundColor: const Color(0xff71E189),
                                  child: Image.asset(
                                    'assets/images/telephone_icon.png',
                                    height: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5,top: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(  'Delivery Address',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff486769)
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    Text(  'Douglas, Cork, T16 XN73, uk',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff1A2E33)
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                  backgroundColor: const Color(0xFF7ED957),
                                  child: Image.asset(
                                    'assets/images/location_icon.png',
                                    height: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15,30,14,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Payment',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff1A2E33)
                            ),),
                          Spacer(),
                          Container(
                            height: 25,
                            width: 52,
                            decoration: BoxDecoration(
                              color: Color(0xFF7ED957),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                'COD',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15,10,14,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Subtotal:',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff1A2E33)
                            ),),
                          Spacer(),
                          Text( '€7.99',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff486769)
                            ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15,10,14,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Tax and fee:',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1A2E33)
                            ),),
                          Spacer(),
                          Text( '€5.00',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff486769)
                            ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15,10,14,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Delivery:',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff1A2E33)
                            ),),
                          Spacer(),
                          Text( '€7.99',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff486769)
                            ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15,10,14,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Packing fee:',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1A2E33)
                            ),),
                          Spacer(),
                          Text( '€5.00',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff486769)
                            ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15,10,14,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Total:',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff7ED957)
                            ),),
                          Spacer(),
                          Text( '€17.99',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff7ED957)
                            ),),
                        ],
                      ),
                    ),
                    addHeight(20)
                  ],

                ),
              ),
            ),
            ],)),
            addHeight(15),
          ],
        ),
      ),
    );
  }
}
