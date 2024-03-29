import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/Screens/login_screen.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/location_controller.dart';
import '../controller/my_cart_controller.dart';
import '../controller/user_profile_controller.dart';
import '../controller/vendor_single_store_controller.dart';
import '../model/my_cart_model.dart';
import '../model/vendor_store_single_model.dart';
import '../repository/add_cart_repo.dart';
import '../repository/remove_cartitem_repo.dart';
import '../repository/vendor_store_single_repo.dart';
import '../repository/wishlist_repo.dart';
import '../resources/add_text.dart';
import '../widgets/app_theme.dart';

class CarteScreen extends StatefulWidget {
  const CarteScreen({super.key, required this.filterId});
  final String filterId;

  @override
  State<CarteScreen> createState() => _CarteScreenState();
}

class _CarteScreenState extends State<CarteScreen> {
  final controller = Get.put(VendorSingleStoreController());
  final cartListController = Get.put(MyCartListController());
  bool apiLoaded = false;
  final locationController = Get.put(LocationController());

  VendorStoreSingleModel model = VendorStoreSingleModel();
  final profileController = Get.put(UserProfileController());

  Future getData() async {
    isUserlogin
        ? await singleStoreData(
            id: controller.storeId,
            filterId: widget.filterId,
            latitude: profileController.model.value.data!.latitude,
            longitude: profileController.model.value.data!.longitude,
          )
        : await singleStoreData(
                id: controller.storeId,
                filterId: widget.filterId,
                latitude: locationController.lat.value,
                longitude: locationController.long.value)
            .then((value1) {
            apiLoaded = true;
            model = value1;
            setState(() {});
          });
  }

  @override
  void initState() {
    super.initState();
    getData();
    isUserLoggedIn();
  }

  bool isUserlogin = false;

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user_info') != null) {
      isUserlogin = true;
    } else {
      isUserlogin = false;
    }
    return isUserlogin;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await getData();
      },
      child: apiLoaded && model.data != null
          ? model.data!.latestProducts!.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: model.data!.latestProducts!.length,
                  itemBuilder: (context, index) {
                    String productID = model.data!.latestProducts![index].id.toString().trim();

                    if (isUserlogin == true) {
                      model.data!.latestProducts![index].productCount = int.tryParse((cartListController
                                      .model.value.data!.cartItems!
                                      .firstWhere((element) => element.productId.toString() == productID,
                                          orElse: () => CartItems())
                                      .cartItemQty ??
                                  "")
                              .toString()) ??
                          0;
                    }

                    final product = model.data!.latestProducts![index];
                    return Column(
                      children: [
                        model.data!.latestProducts![index].qty != 0
                            ? Container(
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
                                    //   model.data!.latestProducts![index].id.toString(),
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
                                                child: CachedNetworkImage(
                                                  imageUrl: model.data!.latestProducts![index].image.toString(),
                                                  fit: BoxFit.cover,
                                                  height: 110,
                                                  width: 75,
                                                  errorWidget: (_, __, ___) => Image.asset(
                                                    'assets/images/Rectangle 23007.png',
                                                    fit: BoxFit.cover,
                                                    height: 80,
                                                    width: 60,
                                                  ),
                                                  placeholder: (_, __) =>
                                                      const Center(child: CircularProgressIndicator()),
                                                ),
                                              ),
                                              Positioned(
                                                  top: 5,
                                                  right: -4,
                                                  child: InkWell(
                                                    onTap: () {
                                                      wishlistRepo(
                                                              productId:
                                                                  model.data!.latestProducts![index].id.toString(),
                                                              id: '')
                                                          .then((value) {
                                                        if (value.status == true) {
                                                          showToast(value.message);
                                                          if (isUserlogin) {
                                                            controller.getData(
                                                                profileController.model.value.data!.latitude,
                                                                profileController.model.value.data!.longitude);
                                                          } else {
                                                            controller.getData(locationController.lat.value,
                                                                locationController.long.value);
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child: model.data!.latestProducts![index].wishlist
                                                        ? Container(
                                                            height: 23,
                                                            decoration: const BoxDecoration(
                                                                shape: BoxShape.circle, color: Colors.white),
                                                            child: const Padding(
                                                                padding: EdgeInsets.only(left: 10, right: 10, top: 3),
                                                                child: Icon(
                                                                  Icons.favorite,
                                                                  color: Color(0xFF7ED957),
                                                                  size: 16,
                                                                )))
                                                        : Container(
                                                            height: 20,
                                                            decoration: const BoxDecoration(
                                                                shape: BoxShape.circle, color: Colors.white),
                                                            child: const Padding(
                                                                padding: EdgeInsets.only(left: 10, right: 10, top: 3),
                                                                child: Icon(
                                                                  Icons.favorite_outline,
                                                                  color: Color(0xFF54C523),
                                                                  size: 16,
                                                                  // color: Color(0xFF7ED957),
                                                                  // color: Colors.red,
                                                                ))),
                                                  )),
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
                                                        model.data!.latestProducts![index].name
                                                            .toString()
                                                            .replaceAll('homemady product test1284sdf', 'Test')
                                                            .capitalizeFirst
                                                            .toString(),
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 14,
                                                            color: const Color(0xFF21283D)),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    // const Spacer(),
                                                    Text(
                                                      '€ ${model.data!.latestProducts![index].price.toString()}',
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 15,
                                                          color: const Color(0xFF70CC49)),
                                                    ),
                                                  ],
                                                ),
                                                addHeight(3),
                                                model.data!.latestProducts![index].qty == 0
                                                    ? Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              '${(model.data!.latestProducts![index].subTitle ?? '').toString().capitalizeFirst}',
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 11,
                                                                  color: const Color(0xFF364A4F)),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Out of Stock',
                                                            style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 11,
                                                                color: Colors.red),
                                                          ),
                                                        ],
                                                      )
                                                    : Text(
                                                        '${(model.data!.latestProducts![index].subTitle ?? '').toString().capitalizeFirst}',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 11,
                                                            color: const Color(0xFF364A4F)),
                                                      ),
                                                addHeight(3),
                                                Text(
                                                  'Size: ${(model.data!.latestProducts![index].sizeQuantity ?? '').toString()} ${model.data!.latestProducts![index].sizeId ?? ''}',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 11,
                                                      color: const Color(0xFF364A4F)),
                                                ),
                                                addHeight(3),
                                                Row(
                                                  children: [
                                                    Text(
                                                        '${int.parse(model.data!.storeDetails!.time.toString()) + 10} - '
                                                        ''
                                                        '${int.parse(model.data!.storeDetails!.time.toString()) + 15} mins  -',
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          color: Color(0xFF4E5F64),
                                                          fontWeight: FontWeight.w400,
                                                        )),
                                                    addWidth(6),
                                                    Text("${model.data!.storeDetails!.distance.toString()} Km",
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 13,
                                                          color: const Color(0xFF4E5F64),
                                                          fontWeight: FontWeight.w400,
                                                        )),
                                                  ],
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
                                                        model.data!.latestProducts![index].spiciness.toString(),
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                        model.data!.latestProducts![index].allergen!
                                                            .map((e) => e.title.toString().capitalize!)
                                                            .join(", "),
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
                                                            String gg = (cartListController.model.value.data!.cartItems!
                                                                        .firstWhere(
                                                                            (element) =>
                                                                                element.productId.toString() ==
                                                                                productID,
                                                                            orElse: () => CartItems())
                                                                        .id ??
                                                                    "")
                                                                .toString();
                                                            if (gg.isEmpty) return;
                                                            removeCartItemRepo(cart_item_id: gg, context: context)
                                                                .then((value) {
                                                              if (value.status == true) {
                                                                cartListController.getData().then((value) {
                                                                  setState(() {});
                                                                });
                                                              }
                                                            });
                                                          } else {
                                                            addToCartRepo(
                                                                    product_id: model.data!.latestProducts![index].id
                                                                        .toString(),
                                                                    qty: product.productCount - 1,
                                                                    //model.data!.latestProducts![index].buttonCount.value,
                                                                    context: context)
                                                                .then((value1) {
                                                              if (value1.status == true) {
                                                                model.data!.latestProducts![index].value = true;
                                                                // model.data!.latestProducts![index].buttonCount.value--;
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
                                                              // model.data!.latestProducts![index].buttonCount.value
                                                              //     .toString(),
                                                              ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          if (isUserlogin == true) {
                                                            if (product.productCount <
                                                                model.data!.latestProducts![index].qty) {
                                                              model.data!.latestProducts![index].qty == 0
                                                                  ? showToast('Out of Stock')
                                                                  : addToCartRepo(
                                                                          product_id: model
                                                                              .data!.latestProducts![index].id
                                                                              .toString(),
                                                                          qty: product.productCount + 1,
                                                                          //model.data!.latestProducts![index].buttonCount.value,
                                                                          context: context)
                                                                      .then((value1) {
                                                                      if (value1.status == true) {
                                                                        model.data!.latestProducts![index].value = true;
                                                                        // model.data!.latestProducts![index].buttonCount.value++;
                                                                        showToast(value1.message.toString());
                                                                        // controller.increaseQty();
                                                                        cartListController.getData().then((value) {
                                                                          setState(() {});
                                                                        });
                                                                      }
                                                                    });
                                                              // }
                                                            } else {
                                                              showToast('You have reached the product limit');
                                                              //showToast('Out of stock');
                                                            }
                                                          } else {
                                                            Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => LoginScreen()),
                                                            );
                                                          }
                                                          // buttonCount.value++;
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
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 16,
                                                                  color: Colors.white),
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
                                        margin: const EdgeInsets.only(left: 82),
                                        color: const Color(0xFFE9E9E9),
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
                                              'Can cook more units by: ${model.data!.latestProducts![index].date.toString()}',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 11,
                                                  color: const Color(0xFF364A4F)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // addHeight(4),
                                      // Row(
                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                      //   children: [
                                      //     addWidth(80),
                                      //     Image.asset(
                                      //       'assets/images/helpimg.png',
                                      //       height: 13,
                                      //     ),
                                      //     addWidth(4),
                                      //     Text(
                                      //       'How long it takes to cook: ',
                                      //       style: GoogleFonts.poppins(
                                      //           fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                      //     ),
                                      //     Text(
                                      //       '${model.data!.latestProducts![index].cookUnitDays ?? '5'.toString()} ',
                                      //       style: GoogleFonts.poppins(
                                      //           fontWeight: FontWeight.w500, fontSize: 11, color: const Color(0xFF364A4F)),
                                      //     ),
                                      //   ],
                                      // ),
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
                                                fontWeight: FontWeight.w300,
                                                fontSize: 11,
                                                color: const Color(0xFF364A4F)),
                                          ),
                                          Expanded(
                                              child: model.data!.latestProducts![index].qty == 0
                                                  ? Text(
                                                      '0 Units',
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 11,
                                                          color: const Color(0xFF364A4F)),
                                                    )
                                                  : Text(
                                                      '${model.data!.latestProducts![index].qty ?? ''.toString()} Units',
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 11,
                                                          color: const Color(0xFF364A4F)),
                                                    )),
                                        ],
                                      ),
                                      addHeight(4),
                                      if (model.data!.latestProducts![index].special_offer == true)
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
                                              'Special Offer',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 11,
                                                  color: const Color(0xFF364A4F)),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        addHeight(10)
                      ],
                    );
                  },
                )
              : const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Center(
                        child: Text(
                      'No Meals available',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black),
                    )),
                  ),
                )
          : SingleChildScrollView(
              child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * .4,
                  child: const CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  )),
            ),
    );
  }
}
