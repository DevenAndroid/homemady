import 'dart:async';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/filter_controller.dart';
import '../controller/homepage_controller.dart';
import '../controller/my_cart_controller.dart';
import '../controller/user_profile_controller.dart';
import '../repository/add_cart_repo.dart';
import '../repository/remove_cartitem_repo.dart';
import '../repository/wishlist_repo.dart';
import '../resources/add_text.dart';
import '../routers/routers.dart';
import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';
import 'myAddressScreen.dart';
import '../model/my_cart_model.dart';

class SearchScreenData extends StatefulWidget {
  const SearchScreenData({Key? key}) : super(key: key);
  static var searchScreen = "/searchScreen";
  @override
  State<SearchScreenData> createState() => _SearchScreenDataState();
}

class _SearchScreenDataState extends State<SearchScreenData> {
  final controller = Get.put(HomePageController());
  final filterDataController = Get.put(FilterController());
  final profileController = Get.put(UserProfileController());
  final cartListController = Get.put(MyCartListController());

  Timer? timer;

  debounceSearch(){
    if(timer != null){
      timer!.cancel();
    }
    timer = Timer(const Duration(milliseconds: 200), () {
      filterDataController.getFilterData().then((value) {
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    super.initState();
    filterDataController.storeSearchController.clear();
    filterDataController.getFilterData().then((value){
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        // backgroundColor: const Color(0xffFFFFFF),
          appBar: AppBar(
            title: Row(
              children: [
                GestureDetector(onTap: () {
                  profileController.scaffoldKey.currentState!.openDrawer();
                }, child: Obx(() {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: profileController.isDataLoading.value
                          ? (profileController.model.value.data!.profileImage).toString()
                          : '',
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                      errorWidget: (_, __, ___) => Image.asset(
                        'assets/images/dummyPerson.png',
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                      placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                    ),
                  );
                })
                  // Image.asset('assets/images/avtarImg.png', height: 45,)
                ),
                addWidth(6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF636869),
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      addHeight(3),
                      GestureDetector(onTap: () {
                        Get.to(() => const MyAddressScreen(), arguments: 'home');
                      }, child: Obx(() {
                        return Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/images/location.png',
                              height: 13,
                            ),
                            addWidth(4),
                            Flexible(
                              child: Text(
                                profileController.address.value.toString(),
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF000000),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            addWidth(5),
                            Image.asset(
                              'assets/images/pencilImg.png',
                              height: 15,
                            ),
                          ],
                        );
                      })),
                    ],
                  ),
                ),
                Badge(
                  badgeStyle: const BadgeStyle(padding: EdgeInsets.all(7)),
                  badgeContent: Obx(() {
                    return Text(
                      cartListController.isDataLoading.value ? cartListController.sum.value.toString() : '0',
                      style: const TextStyle(color: Colors.white),
                    );
                  }),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(MyRouters.myCartScreen);
                    },
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFF7ED957)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/shoppingImg.png',
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 70,
          ),
        body:
        filterDataController.isDataLoading ?
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.padding10),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Hello',
                          style: GoogleFonts.poppins(
                              color: const Color(0xFF676767), fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                        Text(
                          profileController.model.value.data!.name.toString().capitalizeFirst.toString(),
                          style: GoogleFonts.poppins(
                              color: const Color(0xFF353535), fontWeight: FontWeight.w600, fontSize: 22),
                        ),
                      ],
                    ),
                  ],
                ),
                addHeight(20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
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
                              color: Colors.white),
                          child: CommonTextFieldWidget1(
                            hint: 'Search Your Food',
                            controller: filterDataController.storeSearchController,
                            prefix: InkWell(
                              onTap: () {
                                filterDataController.getFilterData().then((value){
                                  setState(() {});
                                });
                                //debounceSearch();
                              },
                              child: Icon(
                                Icons.search,
                                size: 19,
                                color: const Color(0xFF000000).withOpacity(0.56),
                              ),
                            ),
                            onChanged: (val) {
                               debounceSearch();
                             // filterDataController.getFilterData();
                            },
                          )),
                    ),
                    addWidth(10),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                            },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFF7ED957),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF37C666).withOpacity(0.30),
                              offset: const Offset(
                                .1,
                                .1,
                              ),
                              blurRadius: 20.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/filterImg.png',
                            height: 18,
                          ),
                        ),
                      ),
                    ),
                    addWidth(5),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
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
                            border: Border.all(color: const Color(0xFF7ED957))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/sort-descending.png',
                            height: 18,
                          ),
                        ),
                      ),
                    ),
                    addWidth(10),
                  ],
                ),
                addHeight(26),

                filterDataController.filterModel.value.data != null && filterDataController.filterModel.value.data!.isNotEmpty
                    ?  ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: filterDataController.filterModel.value.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String productID = filterDataController.filterModel.value.data![index].id
                        .toString().trim();
                    filterDataController.filterModel.value.data![index].productCount = int.tryParse((cartListController.model.value.data!.cartItems!.firstWhere((element) =>
                    element.productId.toString() == productID,orElse: ()=> CartItems()).cartItemQty ?? "").toString()) ?? 0;
                    final product = filterDataController.filterModel.value.data![index];

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
                                            imageUrl: filterDataController.filterModel.value.data![index].image.toString(),
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
                                            right: -2,

                                            child: GestureDetector(
                                                onTap: (){
                                                  print("store  id..${filterDataController.filterModel.value.data![index].id.toString()}");

                                                  wishlistRepo(productId: filterDataController.filterModel.value.data![index].id.toString(),id: ''
                                                  ).then((value){
                                                    if(value.status==true){
                                                      showToast(value.message);
                                                      filterDataController.getFilterData();
                                                    }
                                                  });
                                                },
                                                child: filterDataController.filterModel.value.data![index].wishlist! ?
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

                                                    )):Container(
                                                    height: 23,
                                                    decoration:
                                                    const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                                    child: const Padding(
                                                        padding: EdgeInsets.only(left: 10, right: 10, top: 3),
                                                        child: Icon(
                                                          Icons.favorite_outline,
                                                          color: Color(0xFF7ED957),
                                                          size: 16,

                                                        )

                                                    ))

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
                                                  filterDataController.filterModel.value.data![index].name
                                                      .toString()
                                                      .replaceAll('homemady product test1284sdf', 'Test').capitalizeFirst.toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 14,
                                                      color: const Color(0xFF21283D)),
                                                  maxLines: 2,
                                                ),
                                              ),
                                              // const Spacer(),
                                              Text(
                                                '€ ${filterDataController.filterModel.value.data![index].price.toString()}',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                    color: const Color(0xFF70CC49)),
                                              ),
                                            ],
                                          ),
                                          addHeight(3),
                                          Text(
                                            (filterDataController.filterModel.value.data![index].subTitle ?? '').toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                          ),
                                          addHeight(3),
                                          Row(
                                            children: [
                                              Text(
                                                'Size: ${(filterDataController.filterModel.value.data![index].sizeQuantity ?? '').toString()}',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                              ),
                                              // const SizedBox(width: 10,),
                                              Text(
                                                filterDataController.filterModel.value.data![index].sizeId ?? ''.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                              ),
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
                                                child: Text(filterDataController.filterModel.value.data![index].spiciness ?? ''.toString(),
                                                  //  controller1.model.value.data!.product![index],'
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
                                                  filterDataController.filterModel.value.data![index].allergens ?? ''.toString(),
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
                                                          product_id: filterDataController.filterModel.value.data![index].id
                                                              .toString(),
                                                          qty: product.productCount -1,
                                                          //controller.model.value.data!.latestProducts![index].buttonCount.value,
                                                          context: context)
                                                          .then((value1) {
                                                        if (value1.status == true) {
                                                          filterDataController.filterModel.value.data![index].value = true;
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
                                                    if(product.productCount <
                                                        int.parse(filterDataController.filterModel.value.data![index].cookUnitDays.toString())){

                                                      addToCartRepo(
                                                          product_id: filterDataController.filterModel.value.data![index].id
                                                              .toString(),
                                                          qty: product.productCount+1,
                                                          //controller.model.value.data!.latestProducts![index].buttonCount.value,
                                                          context: context)
                                                          .then((value1) {
                                                        if (value1.status == true) {
                                                          filterDataController.filterModel.value.data![index].value = true;
                                                          // controller.model.value.data!.latestProducts![index].buttonCount.value++;
                                                          showToast(value1.message.toString());
                                                          // controller.increaseQty();
                                                          cartListController.getData().then((value) {
                                                            setState(() {});
                                                          });
                                                        }
                                                      });

                                                    }
                                                    else{
                                                      showToast("You reached the maximum Limit of product");

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
                                      '${filterDataController.filterModel.value.data![index].cookUnitDays ?? '5'.toString()} Units',
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
                )
                    :
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 60,),
                      Image.asset('assets/images/searchImage.png'),
                      const SizedBox(height: 10,),
                      Text("Result Not Found",
                        style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,color: const Color(0xff000000),fontSize: 22),),
                    ],
                  ),
                ) ,

              ],
            ),
          ),
        ): const Center(child: CircularProgressIndicator(color: Colors.green,),),
        bottomNavigationBar:
        cartListController.isDataLoading.value && cartListController.model.value.data!.cartItems!.isNotEmpty
            ? addCartSection()
            : null,

      ),
    );
  }


}
