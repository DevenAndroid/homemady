import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/resources/add_text.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';

import '../controller/my_cart_controller.dart';
import '../repository/remove_cartitem_repo.dart';


class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final controller = Get.put(MyCartListController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      controller.getData();
      // Add Your Code here.
    });
  }
  RxBool isSelect = false.obs;
  RxBool isSelect1 = false.obs;
  RxBool isSelect2 = true.obs;
  RxBool isSelect3 = true.obs;
  RxBool isSelect4 = false.obs;
  RxBool isSelect5 = true.obs;
  RxBool isSelect6 = true.obs;
  RxBool isSelect7 = false.obs;
  RxBool isSelect8 = true.obs;
  RxBool isSelect9 = true.obs;
  @override
  Widget build(BuildContext context) {

    return Obx(() {
      return Scaffold(
        appBar: backAppBar(title: 'My Cart', context: context),
        body: controller.isDataLoading.value ? controller.model.value.data!.cartItems!.isNotEmpty ?
        SingleChildScrollView(
          child: Column(
            children: [
              addHeight(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.model.value.data!.cartItems!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(onTap: (){
                      print(controller.model.value.data!.cartItems![index].id.toString(),);
                      print(controller.model.value.data!.cartItems![index].productId.toString(),);
                    },
                      child: Column(
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
                                      onPressed: (context) {
                                        removeCartItemRepo(cart_item_id: controller.model.value.data!.cartItems![index].id.toString(),context: context).then((value) {
                                          if(value.status == true){
                                            showToast('Cart Removed Successfully');
                                            print(controller.model.value.data!.cartItems![index].id.toString());
                                            setState(() {
                                              controller.getData();
                                            });
                                          }
                                        });
                                      },
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
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                    imageUrl: controller.model.value.data!.cartItems![index].image.toString(),
                                    fit: BoxFit.cover,
                                    width: 65,
                                    height: 75,
                                    errorWidget: (_, __, ___) => Image.asset(
                                      'assets/images/Ellipse 67.png',
                                      width: 74,
                                      height: 82,
                                    ),
                                    placeholder: (_, __) =>
                                        const Center(child: CircularProgressIndicator()),
                                ),
                                  ),
                                      addWidth(10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text((controller.model.value.data!.cartItems![index].name!.isEmpty ? 'Test' : controller.model.value.data!.cartItems![index].name).toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: const Color(0xFF21283D)
                                            ),),
                                          addHeight(3),
                                          Row(
                                            children: [
                                              Text('${controller.model.value.data!.cartItems![index].cartItemQty.toString()} items',
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
                                              Text('${(controller.model.value.data!.cartItems![index].distance ?? '5').toString()} km',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: const Color(0xFF486769).withOpacity(0.70)
                                                ),),
                                            ],
                                          ),
                                          addHeight(5),
                                          Text('€ ${controller.model.value.data!.cartItems![index].price.toString()}',
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
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:6.0,top:15,right: 6),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,18,14,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text('Get 1 free delivery every 10 orders.',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff303D46)
                                ),),
                            ),
                          ],
                        ),
                      ),
                      addHeight(20),
                      // Wrap(
                      //   children: List.generate(10, (index){
                      //   return  Row(
                      //     children: [
                      //       InkWell(
                      //         onTap: (){
                      //           //isSelect1.value =! isSelect1.value;
                      //         },
                      //         child: Container(
                      //           height: 28,
                      //           width: 28,
                      //           padding: const EdgeInsets.symmetric(horizontal: 4),
                      //           decoration: isSelect1.value == false ?
                      //           BoxDecoration(
                      //             borderRadius: BorderRadius.circular(4.0),
                      //             color: Colors.white,
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.grey.shade300,
                      //                 offset: const Offset(.1, .1,
                      //                 ),
                      //                 blurRadius: 19.0,
                      //                 spreadRadius: 1.0,
                      //               ),
                      //             ],
                      //           ) : BoxDecoration(
                      //             borderRadius: BorderRadius.circular(4.0),
                      //             color: const Color(0xFF7ED957),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.grey.shade300,
                      //                 offset: const Offset(.1, .1,
                      //                 ),
                      //                 blurRadius: 19.0,
                      //                 spreadRadius: 1.0,
                      //               ),
                      //             ],
                      //           ),
                      //           child: Center(
                      //             child:   isSelect1.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //           ),
                      //         ),
                      //       ),
                      //       // addHeight(5),
                      //       /*const Text('Mo',style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF303C5E)
                      //           ),)*/
                      //     ],
                      //   );
                      // }),
                      // ),

                      Wrap(children: List.generate(10, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right:4,left: 4),
                          child: Container(
                              height: 30,
                              width: 30,
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              decoration:
                              BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.grey.shade200,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: const Offset(.1, .1,
                                    ),
                                    blurRadius: 19.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              )),
                        );
                      })),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20,),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Column(
                      //         children: [
                      //           InkWell(
                      //             onTap: (){
                      //               // isSelect.value =! isSelect.value;
                      //             },
                      //             child: Container(
                      //               height: 28,
                      //               width: 28,
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               decoration: isSelect.value == false ?
                      //               BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ) : BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: const Color(0xFF7ED957),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child:   isSelect.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //               ),
                      //             ),
                      //           ),
                      //          // addHeight(5),
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           InkWell(
                      //             onTap: (){
                      //               //isSelect1.value =! isSelect1.value;
                      //             },
                      //             child: Container(
                      //               height: 28,
                      //               width: 28,
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               decoration: isSelect1.value == false ?
                      //               BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ) : BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: const Color(0xFF7ED957),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child:   isSelect1.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //               ),
                      //             ),
                      //           ),
                      //          // addHeight(5),
                      //           /*const Text('Mo',style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF303C5E)
                      //           ),)*/
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           InkWell(
                      //             onTap: (){
                      //               // isSelect2.value =! isSelect2.value;
                      //             },
                      //             child: Container(
                      //               height: 28,
                      //               width: 28,
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               decoration: isSelect2.value == false ?
                      //               BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ) : BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: const Color(0xFF7ED957),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child:   isSelect2.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //               ),
                      //             ),
                      //           ),
                      //          // addHeight(5),
                      //          /* const Text('Tu',style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF303C5E)
                      //           ),)*/
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           InkWell(
                      //             onTap: (){
                      //               // isSelect3.value =! isSelect3.value;
                      //             },
                      //             child: Container(
                      //               height: 28,
                      //               width: 28,
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               decoration: isSelect3.value == false ?
                      //               BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ) : BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: const Color(0xFF7ED957),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child:   isSelect3.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //               ),
                      //             ),
                      //           ),
                      //           /*addHeight(5),
                      //           const Text('We',style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF303C5E)
                      //           ),)*/
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           InkWell(
                      //             onTap: (){
                      //               // isSelect4.value =! isSelect4.value;
                      //             },
                      //             child: Container(
                      //               height: 28,
                      //               width: 28,
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               decoration: isSelect4.value == false ?
                      //               BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               )
                      //                   : BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: const Color(0xFF7ED957),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child:   isSelect4.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //               ),
                      //             ),
                      //           ),
                      //          /* addHeight(5),
                      //           const Text('Th',style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF303C5E)
                      //           ),)*/
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           InkWell(
                      //             onTap: (){
                      //               isSelect5.value =! isSelect5.value;
                      //             },
                      //             child: Container(
                      //               height: 28,
                      //               width: 28,
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               decoration: isSelect5.value == true ?
                      //               BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ) : BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: const Color(0xFF7ED957),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child:   isSelect5.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //               ),
                      //             ),
                      //           ),
                      //          /* addHeight(5),
                      //           const Text('Fr',style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF303C5E)
                      //           ),)*/
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           InkWell(
                      //             onTap: (){
                      //               isSelect6.value =! isSelect6.value;
                      //             },
                      //             child: Container(
                      //               height: 28,
                      //               width: 28,
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               decoration: isSelect6.value == true ?
                      //               BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ) : BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: const Color(0xFF7ED957),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child:   isSelect6.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //               ),
                      //             ),
                      //           ),
                      //          /* addHeight(5),
                      //           const Text('Sa',style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF303C5E)
                      //           ),)*/
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           InkWell(
                      //             onTap: (){
                      //               isSelect7.value =! isSelect7.value;
                      //             },
                      //             child: Container(
                      //               height: 28,
                      //               width: 28,
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               decoration: isSelect7.value == true ?
                      //               BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ) : BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: const Color(0xFF7ED957),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child:   isSelect7.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //               ),
                      //             ),
                      //           ),
                      //           /*addHeight(5),
                      //           const Text('Su',style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF303C5E)
                      //           ),)*/
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           InkWell(
                      //             onTap: (){
                      //               isSelect8.value =! isSelect8.value;
                      //             },
                      //             child: Container(
                      //               height: 28,
                      //               width: 28,
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               decoration: isSelect8.value == true ?
                      //               BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ) : BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: const Color(0xFF7ED957),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child:   isSelect8.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //               ),
                      //             ),
                      //           ),
                      //           /*addHeight(5),
                      //           const Text('Mo',style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF303C5E)
                      //           ),)*/
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           InkWell(
                      //             onTap: (){
                      //               isSelect9.value =! isSelect9.value;
                      //             },
                      //             child: Container(
                      //               height: 28,
                      //               width: 28,
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               decoration: isSelect9.value == true ?
                      //               BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ) : BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: const Color(0xFF7ED957),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child:   isSelect9.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //               ),
                      //             ),
                      //           ),
                      //           /* addHeight(5),
                      //           const Text('Tu',style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF303C5E)
                      //           ),)*/
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // addHeight(20),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 15,),
                      //   child: Row(
                      //    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Column(
                      //         children: [
                      //           InkWell(
                      //             onTap: (){
                      //               isSelect7.value =! isSelect7.value;
                      //             },
                      //             child: Container(
                      //               height: 28,
                      //               width: 28,
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               decoration: isSelect7.value == true ?
                      //               BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ) : BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: const Color(0xFF7ED957),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child:   isSelect7.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //               ),
                      //             ),
                      //           ),
                      //           /*addHeight(5),
                      //           const Text('Su',style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF303C5E)
                      //           ),)*/
                      //         ],
                      //       ),
                      //       addWidth(20),
                      //       Column(
                      //         children: [
                      //           InkWell(
                      //             onTap: (){
                      //               isSelect8.value =! isSelect8.value;
                      //             },
                      //             child: Container(
                      //               height: 28,
                      //               width: 28,
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               decoration: isSelect8.value == true ?
                      //               BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ) : BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: const Color(0xFF7ED957),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child:   isSelect8.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //               ),
                      //             ),
                      //           ),
                      //           /*addHeight(5),
                      //           const Text('Mo',style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF303C5E)
                      //           ),)*/
                      //         ],
                      //       ),
                      //       addWidth(20),
                      //       Column(
                      //         children: [
                      //           InkWell(
                      //             onTap: (){
                      //               isSelect9.value =! isSelect9.value;
                      //             },
                      //             child: Container(
                      //               height: 28,
                      //               width: 28,
                      //               padding: const EdgeInsets.symmetric(horizontal: 4),
                      //               decoration: isSelect9.value == true ?
                      //               BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ) : BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(4.0),
                      //                 color: const Color(0xFF7ED957),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.shade300,
                      //                     offset: const Offset(.1, .1,
                      //                     ),
                      //                     blurRadius: 19.0,
                      //                     spreadRadius: 1.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child:   isSelect9.value == true ? const SizedBox() : Image.asset('assets/images/image_2023_07_19T09_51_38_771Z.png') ,
                      //               ),
                      //             ),
                      //           ),
                      //          /* addHeight(5),
                      //           const Text('Tu',style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF303C5E)
                      //           ),)*/
                      //         ],
                      //       ),
                      //
                      //     ],
                      //   ),
                      // ),
                      addHeight(20)
                    ],

                  )

                ),
              ),
              addHeight(10),
              Padding(
                padding: const EdgeInsets.only(left:6.0,top:15,right: 6),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,18,14,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Subtotal:',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff1A2E33)
                              ),),
                            Spacer(),
                            Text( '€ ${controller.model.value.data!.cartPaymentSummary!.subTotal.toString()}.00',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
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
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1A2E33)
                              ),),
                            Spacer(),
                            Text( '€ ${controller.model.value.data!.cartPaymentSummary!.taxAndFee.toString()}.00',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff486769)
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
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1A2E33)
                              ),),
                            Spacer(),
                            Text( '€ ${controller.model.value.data!.cartPaymentSummary!.deliveryCharge.toString()}.00',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff486769)
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
                                  color: const Color(0xff6BC744)
                              ),),
                            Spacer(),
                            Text( '€ ${controller.model.value.data!.cartPaymentSummary!.total.toString()}.00',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff6BC744)
                              ),),
                          ],
                        ),
                      ),
                      addHeight(20)
                    ],


                  ),
                ),
              ),

              addHeight(39),
              Padding(
                padding:  EdgeInsets.only(left: 8.0,right: 8.0),
                child: CommonButton(title: 'Checkout',onPressed: (){
                  Get.toNamed(MyRouters.checkOutScreen);
                },),
              ),

              addHeight(20),
            ],
          ),
        ):Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              SizedBox(height: 60,),
              Image.asset('assets/images/emptyCartImg.png'),
              SizedBox(height: 10,),
              Text("Cart is Empty",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black54,fontSize: 18),),
            ],
          ),
        ) :Center(child: CircularProgressIndicator()),
      );
    });

  }
}
