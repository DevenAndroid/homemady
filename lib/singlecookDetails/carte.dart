import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/dimenestion.dart';

import '../controller/my_cart_controller.dart';
import '../controller/vendor_single_store_controller.dart';
import '../model/my_cart_model.dart';
import '../repository/add_cart_repo.dart';
import '../repository/remove_cartitem_repo.dart';
import '../repository/wishlist_repo.dart';
import '../resources/add_text.dart';
import '../widgets/app_theme.dart';

class CarteScreen extends StatefulWidget {
 final String? data;
  const CarteScreen({Key? key, this.data}) : super(key: key);
  static var carteScreenPage = "/carteScreenPage";

  @override
  State<CarteScreen> createState() => _CarteScreenState();
}

class _CarteScreenState extends State<CarteScreen> {
  final controller = Get.put(VendorSingleStoreController());
  final cartListController = Get.put(MyCartListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  if(widget.data == null)return;
  }
  @override
  Widget build(BuildContext context) {
    return
      controller.isDataLoading.value && controller.model.value.data != null ? controller.model.value.data!.latestProducts!.isNotEmpty ?
      Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(13.0),
          child:

          ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.model.value.data!.latestProducts!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              String productID = controller.model.value.data!.latestProducts![index].id
                  .toString().trim();
              controller.model.value.data!.latestProducts![index].productCount = int.tryParse((cartListController.model.value.data!.cartItems!.firstWhere((element) =>
              element.productId.toString() == productID,orElse: ()=> CartItems()).cartItemQty ?? "").toString()) ?? 0;
              final product = controller.model.value.data!.latestProducts![index];

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF37C666).withOpacity(0.10),
                            offset: const Offset(
                              .1,
                              .1,
                            ),
                            blurRadius: 20.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                      onTap: () {
                        // print(
                        //   controller.model.value.data!.latestProducts![index].id.toString(),
                        // );
                        // Get.toNamed(MyRouters.myCartScreen);
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(

                                children: [

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child:
                                    CachedNetworkImage(
                                      imageUrl: controller.model.value.data!.latestProducts![index].image.toString(),
                                      fit: BoxFit.cover,
                                      height: 110,
                                      width: 75,
                                      errorWidget: (_, __, ___) => Image.asset(
                                        'assets/images/Rectangle 23007.png',
                                        fit: BoxFit.cover,
                                        height: 80,
                                        width: 60,
                                      ),
                                      placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                                    ),
                                  ),
                                  Positioned(
                                      top: 5,
                                      right:-4,

                                      child:
                                      InkWell(
                                        onTap: (){
                                           print("store  id..${controller.model.value.data!.latestProducts![index].id.toString()}");

                                           wishlistRepo(productId: controller.model.value.data!.latestProducts![index].id.toString(),id: ''
                                           ).then((value){
                                             if(value.status==true){
                                               showToast(value.message);
                                               controller.getData();
                                             }
                                           });
                                        },
                                        child:
                                        controller.model.value.data!.latestProducts![index].wishlist ?
                                        Container(
                                            height: 23,
                                            decoration:
                                            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                            child: const Padding(
                                                padding: EdgeInsets.only(left: 10, right: 10, top: 3),
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Color(0xFF7ED957),
                                                  size: 16,

                                                )

                                            )):
                                        Container(
                                            height: 20,
                                            decoration:
                                            const BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                                            child: const Padding(
                                                padding: EdgeInsets.only(left: 10, right: 10, top: 3),
                                                child: Icon(
                                                  Icons.favorite_outline,
                                                  color: Color(0xFF54C523),
                                                  size: 16,
                                                  // color: Color(0xFF7ED957),
                                                  // color: Colors.red,
                                                )

                                            )),
                                      )
                                  ),
                                ],
                              ),
                              addWidth(10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            controller.model.value.data!.latestProducts![index].name
                                                .toString()
                                                .replaceAll('homemady product test1284sdf', 'Test'),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: const Color(0xFF21283D)),
                                            maxLines: 2,
                                          ),
                                        ),
                                        // const Spacer(),
                                        Text(
                                          '€ ${controller.model.value.data!.latestProducts![index].price.toString()}',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              color: const Color(0xFF70CC49)),
                                        ),
                                      ],
                                    ),
                                    addHeight(3),
                                    Text(
                                      '${(controller.model.value.data!.latestProducts![index].subTitle ?? '').toString()}',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500, fontSize: 11, color: const Color(0xFF364A4F)),
                                    ),
                                    addHeight(3),
                                    Text(
                                      'Size: ${(controller.model.value.data!.latestProducts![index].sizeQuantity ?? '').toString()} ' +
                                          (controller.model.value.data!.latestProducts![index].sizeId ?? '').toString(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                    ),
                                    addHeight(3),
                                    Row(
                                      children: [
                                        Text(
                                          'Spiciness :',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                              color: const Color(0xFF1F2D30)),
                                        ),
                                        addWidth(4),
                                        Expanded(
                                          child: Text(
                                            controller.model.value.data!.latestProducts![index].spiciness.toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10,
                                                color: const Color(0xFF6CC844)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    addHeight(4),
                                    Row(
                                      children: [
                                        Text(
                                          'Allergens :',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                              color: const Color(0xFF1F2D30)),
                                        ),
                                        addWidth(4),
                                        Expanded(
                                          child: Text(
                                            controller.model.value.data!.latestProducts![index].allergens.toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10,
                                                color: const Color(0xFF6CC844)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    addHeight(4),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (cartListController.model.value.data!.cartItems!
                                                  .map((e) => e.productId.toString())
                                                  .toList()
                                                  .contains(productID) &&
                                                  product.productCount == 1) {
                                                print("sssssssssssssssssssssssss");
                                                print("sssssssssssssssssssssssss${cartListController.model.value.data!.cartItems!
                                                    .map((e) => e.productId.toString())
                                                    .toList()}");
                                                String gg = (cartListController.model.value.data!.cartItems!.firstWhere((element) =>
                                                element.productId.toString() == productID,orElse: ()=> CartItems()).id ?? "").toString();
                                                if(gg.isEmpty)return;
                                                removeCartItemRepo(cart_item_id: gg,context: context).then((value) {
                                                  if(value.status == true){
                                                    cartListController.getData().then((value) {
                                                      setState(() {});
                                                    });
                                                  }
                                                });
                                              } else {
                                                addToCartRepo(
                                                    product_id: controller
                                                        .model.value.data!.latestProducts![index].id
                                                        .toString(),
                                                    qty: product.productCount -1,
                                                    //controller.model.value.data!.latestProducts![index].buttonCount.value,
                                                    context: context)
                                                    .then((value1) {
                                                  if (value1.status == true) {
                                                    controller.model.value.data!.latestProducts![index].value = true;
                                                    // controller.model.value.data!.latestProducts![index].buttonCount.value--;
                                                    showToast(value1.message.toString());
                                                    // controller.decreaseQty();
                                                    cartListController.getData();
                                                  }
                                                });
                                                cartListController.getData().then((value) {
                                                  setState(() {});
                                                });
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: const Color(0xFF72CD4A)),
                                                  shape: BoxShape.circle),
                                              alignment: Alignment.center,
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                child: Text(
                                                  '-',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16,
                                                      color: Color(0xFF72CD4A)),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                                              child: Text(product.productCount.toString()
                                                // controller.model.value.data!.latestProducts![index].buttonCount.value
                                                //     .toString(),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // buttonCount.value++;
                                              if( product.productCount <  int.parse(controller.model.value.data!.latestProducts![index].cookUnitDays)){
                                                addToCartRepo(
                                                    product_id: controller
                                                        .model.value.data!.latestProducts![index].id
                                                        .toString(),
                                                    qty: product.productCount+1,
                                                    //controller.model.value.data!.latestProducts![index].buttonCount.value,
                                                    context: context)
                                                    .then((value1) {
                                                  if (value1.status == true) {
                                                    controller.model.value.data!.latestProducts![index].value = true;
                                                    // controller.model.value.data!.latestProducts![index].buttonCount.value++;
                                                    showToast(value1.message.toString());
                                                    // controller.increaseQty();
                                                    cartListController.getData().then((value) {
                                                      setState(() {});
                                                    });
                                                  }
                                                });
                                              }else{
                                                showToast('You reached the maximum Limit of product');
                                              }

                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFF72CD4A),
                                                  border: Border.all(color: const Color(0xFF72CD4A)),
                                                  shape: BoxShape.circle),
                                              alignment: Alignment.center,
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: Text(
                                                  '+',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          addHeight(5),
                          Container(
                            margin: EdgeInsets.only(left: 82),
                            color: Color(0xFFE9E9E9),
                            width: AddSize.screenWidth,
                            height: 1,
                          ),
                          addHeight(7),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              addWidth(80),
                              Image.asset(
                                'assets/images/helpimg.png',
                                height: 13,
                              ),
                              addWidth(4),
                              Expanded(
                                child: Text(
                                  'Can cook more units by: 30th June 2023',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                ),
                              ),
                            ],
                          ),
                          addHeight(4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              addWidth(80),
                              Image.asset(
                                'assets/images/helpimg.png',
                                height: 13,
                              ),
                              addWidth(4),
                              Text(
                                'Available stock: ',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                              ),
                              Text(
                                '${controller.model.value.data!.latestProducts![index].cookUnitDays ?? '5'.toString()} Units',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500, fontSize: 11, color: const Color(0xFF364A4F)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  addHeight(10)
                ],
              );
            },
          ),
        ),
      ],
    ): const Padding(
      padding: EdgeInsets.only(top: 80),
      child: Center(child: Text('No Meals available',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black),)),
    ):   const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor,));
  }
}
