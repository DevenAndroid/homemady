import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../controller/homepage_controller.dart';
import '../model/my_cart_model.dart';

import '../controller/favorite_controller.dart';
import '../controller/my_cart_controller.dart';
import '../controller/vendor_single_store_controller.dart';
import '../repository/add_cart_repo.dart';
import '../repository/remove_cartitem_repo.dart';
import '../repository/wishlist_repo.dart';
import '../resources/add_text.dart';
import '../routers/routers.dart';
import '../widgets/dimenestion.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>  with TickerProviderStateMixin {
  RxBool isSelect1 = false.obs;
  RxBool isSelect = false.obs;
  late TabController tabController;
  final controller1 = FavoriteListController();

  final controller = Get.put(VendorSingleStoreController());
  final cartListController = Get.put(MyCartListController());
  final homeController = Get.put(HomePageController());

  final autoController = AutoScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller1.get();
    // controller.getData();
    tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

      return
        Scaffold(
        appBar: backAppBar(title: 'My Favorites', context: context),
        body: Obx((){
          return controller1.isDataLoading.value ?
          NestedScrollView(
              headerSliverBuilder: (_, __){
                return [
                  Obx(() {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AddSize.padding16, vertical: AddSize.padding10),
                        child: controller1.isDataLoading.value ?
                        Column(
                          children: [
                            addHeight(10),
                            Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.screenWidth * 0.02,
                                      vertical: AddSize.screenHeight * .007),
                                  child: TabBar(
                                    // indicatorColor: Color(0xff7ED957),
                                    physics: const BouncingScrollPhysics(),
                                    tabs:  [
                                      Tab(
                                        child: Text(
                                          "Cooks",
                                          textAlign: TextAlign.center,
                                          style:GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),

                                      Tab(
                                        child: Text(
                                          "Meals",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    ],
                                    unselectedLabelColor: const Color(0xFF262626),
                                    labelColor: Colors.white,
                                    labelStyle: const TextStyle(
                                        color: Color(0xFF1A2E33),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    unselectedLabelStyle: const TextStyle(
                                        color: Color(0xFF909090),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    controller: tabController,
                                    indicatorPadding: EdgeInsets.symmetric(horizontal: -5, vertical: -2),
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color:  const Color(0xff7ED957),
                                    ),
                                    indicatorColor: Colors.transparent,

                                    // indicatorSize: TabBarIndicatorSize.tab,
                                    // indicator: const BoxDecoration(
                                    //     border: Border(
                                    //         bottom: BorderSide(color: Color(0xFF7ED957),width: 5)
                                    //     )
                                    // ),
                                  ),
                                )),
                          ],
                        ):const SizedBox(),
                      ),
                    );
                  })
                ];
              },
              body:
              TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: tabController,
                children: [
                  Obx(() {
                    return
                      SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AddSize.padding16,
                              ),

                              child: controller1.model.value.data!.store!.isNotEmpty ?
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller1.model.value.data!.store!.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF37C666).withOpacity(
                                                      0.15),
                                                  offset: const Offset(.3, .3,
                                                  ),
                                                  blurRadius: 20.0,
                                                  spreadRadius: 1.0,
                                                ),
                                              ],
                                            ),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: (){
                                                      Get.toNamed(MyRouters.homeDetailsScreen, arguments: [
                                                        controller1.model.value.data!.store![index].id.toString()
                                                      ]);
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        CachedNetworkImage(
                                                          imageUrl:
                                                          controller1.model.value.data!.store![index].image.toString(),
                                                          fit: BoxFit.cover,
                                                         height: 150,
                                                          width: AddSize.screenWidth,
                                                          errorWidget: (_, __, ___) => Image.asset(
                                                            'assets/images/dummyPerson.png',
                                                            fit: BoxFit.cover,
                                                            height: 150,
                                                            width: AddSize.screenWidth,
                                                          ),
                                                          placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                                                        ),
                                                        addHeight(6),
                                                        Text(controller1.model.value.data!.store![index].name.toString(),
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 16,
                                                              color: const Color(0xFF21283D)
                                                          ),),
                                                        addHeight(6),
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/truckimg.png',
                                                              height: 22,
                                                              color: const Color(0xFF04666E),
                                                            ),
                                                            addWidth(10),
                                                            Text(
                                                              '${controller1.model.value.data!.store![index].collection.toString()} ',
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 12,
                                                                  color: const Color(0xFF606573)),
                                                            ),
                                                            Text(
                                                              '${controller1.model.value.data!.store![index].time ?? ''.toString()} mins',
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 12,
                                                                  color: const Color(0xFF606573)),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Positioned(
                                                //     top: 80,
                                                //     // bottom: 0,
                                                //     left: 20,
                                                //     right: 20,
                                                //     //   bottom: 0,
                                                //     child: Row(
                                                //       mainAxisAlignment: MainAxisAlignment
                                                //           .spaceBetween,
                                                //       children: const [
                                                //         Icon(Icons.arrow_back_ios,
                                                //           color: Colors.white,size: 20,),
                                                //         Icon(Icons.arrow_forward_ios,
                                                //           color: Colors.white,size: 20,)
                                                //       ],
                                                //     )
                                                // ),
                                                Positioned(
                                                    bottom: 10,
                                                    right: 20,
                                                    //   bottom: 0,
                                                    child: Column(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                            height: 48,
                                                            decoration: const BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                color: Colors.white
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(3),
                                                              child: Image.asset(
                                                                  'assets/images/dummyPerson.png'),
                                                            )
                                                        ),
                                                        addHeight(3),
                                                        Text(controller1.model.value.data!.store![index].cookName.toString().capitalizeFirst.toString(),
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12,
                                                              color: const Color(0xFF21283D)
                                                          ),),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .center,
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            const Icon(Icons.star,
                                                              color: Color(0xFFFFC529),
                                                              size: 14,),
                                                            addWidth(3),
                                                            Text((controller1.model.value.data!.store![index].rating ?? '3').toString(),
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 11,
                                                                  color: const Color(0xFF6A7080)
                                                              ),),
                                                            addWidth(3),
                                                            Text('(${controller1.model.value.data!.store![index].countReviewData ??'10'})'.toString(),
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 11,
                                                                  color: const Color(0xFF6A7080)
                                                              ),),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                ),
                                                Positioned(
                                                    top: 16,
                                                    right: 10,
                                                    child: InkWell(
                                                        onTap: (){
                                                          print("store  id..${homeController.model.value.data!.stores![index].id.toString()}");

                                                          wishlistRepo(id: controller1.model.value.data!.store![index].id.toString(),productId: ''
                                                          ).then((value){
                                                            if(value.status==true){
                                                              showToast(value.message);
                                                              controller1.get();
                                                            }
                                                          });
                                                        },
                                                        child:

                                                        Container(
                                                            height: 33,
                                                            decoration:
                                                            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                                            child: const Padding(
                                                                padding: EdgeInsets.only(left: 10, right: 10, top: 3),
                                                                child: Icon(
                                                                  Icons.favorite,
                                                                  color: Color(0xFF7ED957),

                                                                )

                                                            ))
                                                    )
                                                ),
                                                controller1.model.value.data!.store![index].award!.isNotEmpty ?
                                                Positioned(
                                                    top: 14,
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
                                                                          top: 30,
                                                                          child: Container(
                                                                              padding: EdgeInsets.all(10),
                                                                              height: 80,
                                                                              decoration: const BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  shape: BoxShape.circle
                                                                              ),
                                                                              child:  Icon(Icons.clear)
                                                                          ),)
                                                                      ],
                                                                    );
                                                                  }
                                                              );
                                                            },
                                                            child: CachedNetworkImage(
                                                              imageUrl:   controller1.model.value.data!.store![index].award![0].image.toString(),
                                                              //fit: BoxFit.cover,
                                                              height: 40,
                                                              width: 40,
                                                              errorWidget: (_, __, ___) => Image.asset(
                                                                'assets/images/topChef.png',
                                                                // fit: BoxFit.cover,
                                                                height: 40,
                                                                width: 40,
                                                              ),
                                                              placeholder: (_, __) =>
                                                              const Center(child: CircularProgressIndicator()),
                                                            )),
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
                                                                              padding: const EdgeInsets.all(10),
                                                                              height: 50,
                                                                              decoration: const BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  shape: BoxShape.circle
                                                                              ),
                                                                              child:  const Icon(Icons.clear)
                                                                          ),)
                                                                      ],
                                                                    );
                                                                  }
                                                              );
                                                            },
                                                            child: CachedNetworkImage(
                                                              imageUrl:   controller1.model.value.data!.store![index].award![0].image.toString(),
                                                              //fit: BoxFit.cover,
                                                              height: 40,
                                                              width: 40,
                                                              errorWidget: (_, __, ___) => Image.asset(
                                                                'assets/images/topChef.png',
                                                                // fit: BoxFit.cover,
                                                                height: 40,
                                                                width: 40,
                                                              ),
                                                              placeholder: (_, __) =>
                                                              const Center(child: CircularProgressIndicator()),
                                                            )),

                                                      ],
                                                    )
                                                ):  const SizedBox()
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15,)
                                      ],
                                    ),
                                  );
                                },
                              ) :

                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  children: [
                                    SizedBox(height: 60,),
                                    Image.asset('assets/images/Favaorites.png'),
                                    SizedBox(height: 10,),
                                    Text("No Favaorites",
                                      style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,color: Color(0xff000000),fontSize: 22),),
                                  ],
                                ),
                              )

                          ));
                  }),
                  Obx(() {
                    return
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AddSize.padding16,
                          ),
                          child: controller1.model.value.data!.product!.isNotEmpty ?
                          ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller1.model.value.data!.product!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              String productID = controller1.model.value.data!.product![index].id
                                  .toString().trim();
                              controller1.model.value.data!.product![index].productCount = int.tryParse((cartListController.model.value.data!.cartItems!.firstWhere((element) =>
                              element.productId.toString() == productID,orElse: ()=> CartItems()).cartItemQty ?? "").toString()) ?? 0;
                              final product = controller1.model.value.data!.product![index];

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
                                                      imageUrl: controller1.model.value.data!.product![index].image.toString(),
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
                                                            print("store  id..${controller1.model.value.data!.product![index].id.toString()}");

                                                            wishlistRepo(productId: controller1.model.value.data!.product![index].id.toString(),id: ''
                                                            ).then((value){
                                                              if(value.status==true){
                                                                showToast(value.message);
                                                                controller1.get();
                                                              }
                                                            });
                                                          },
                                                          child:

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
                                                            controller1.model.value.data!.product![index].name
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
                                                          '€ ${controller1.model.value.data!.product![index].price.toString()}',
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 15,
                                                              color: const Color(0xFF70CC49)),
                                                        ),
                                                      ],
                                                    ),
                                                    addHeight(3),

                                                    controller1.model.value.data!.product![index].qty == 0 ?
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          '${(controller1.model.value.data!.product![index].subTitle ?? '').toString().capitalizeFirst}',
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w500, fontSize: 11, color: const Color(0xFF364A4F)),
                                                        ),
                                                        Text(
                                                          'Out of Stock',
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w500, fontSize: 11, color: Colors.red),
                                                        ),
                                                      ],
                                                    ) :  Text(
                                                      '${(controller1.model.value.data!.product![index].subTitle ?? '').toString().capitalizeFirst}',
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w500, fontSize: 11, color: const Color(0xFF364A4F)),
                                                    ),

                                                    addHeight(3),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Size: ${(controller1.model.value.data!.product![index].sizeQuantity ?? '').toString()}',
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                                        ),
                                                       // const SizedBox(width: 10,),
                                                        Text(
                                                          controller1.model.value.data!.product![index].sizeId ?? ''.toString(),
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
                                                          child: Text(controller1.model.value.data!.product![index].spiciness ?? ''.toString(),
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
                                                            controller1.model.value.data!.product![index].allergens ?? ''.toString(),
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
                                                                    product_id: controller1
                                                                        .model.value.data!.product![index].id
                                                                        .toString(),
                                                                    qty: product.productCount -1,
                                                                    //controller.model.value.data!.latestProducts![index].buttonCount.value,
                                                                    context: context)
                                                                    .then((value1) {
                                                                  if (value1.status == true) {
                                                                    controller1.model.value.data!.product![index].value = true;
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
                                                              // if(product.productCount <
                                                              //     int.parse(controller1.model.value.data!.product![index].cookUnitDays.toString())){
                                                              //
                                                              //   addToCartRepo(
                                                              //       product_id: controller1
                                                              //           .model.value.data!.product![index].id
                                                              //           .toString(),
                                                              //       qty: product.productCount+1,
                                                              //       //controller.model.value.data!.latestProducts![index].buttonCount.value,
                                                              //       context: context)
                                                              //       .then((value1) {
                                                              //     if (value1.status == true) {
                                                              //       controller1.model.value.data!.product![index].value = true;
                                                              //       // controller.model.value.data!.latestProducts![index].buttonCount.value++;
                                                              //       showToast(value1.message.toString());
                                                              //       // controller.increaseQty();
                                                              //       cartListController.getData().then((value) {
                                                              //         setState(() {});
                                                              //       });
                                                              //     }
                                                              //   });
                                                              //
                                                              // }
                                                              // else{
                                                              //   showToast("You reached the maximum Limit of product");
                                                              //
                                                              // }
                                                              if( product.productCount <  controller1.model.value.data!.product![index].qty) {
                                                                controller1.model.value.data!.product![index].qty == 0 ?
                                                                showToast('Out of Stock') : addToCartRepo(
                                                                    product_id: controller1
                                                                        .model.value.data!.product![index].id
                                                                        .toString(),
                                                                    qty: product.productCount + 1,
                                                                    //controller.model.value.data!.latestProducts![index].buttonCount.value,
                                                                    context: context)
                                                                    .then((value1) {
                                                                  if (value1.status == true) {
                                                                    controller1.model.value.data!.product![index].value = true;
                                                                    // controller.model.value.data!.latestProducts![index].buttonCount.value++;
                                                                    showToast(value1.message.toString());
                                                                    // controller.increaseQty();
                                                                    cartListController.getData().then((value) {
                                                                      setState(() {});
                                                                    });
                                                                  }
                                                                });
                                                                // }
                                                              }
                                                              else{
                                                                // showToast('You reached the maximum Limit of product');
                                                                showToast('You have reached the product limit');
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
                                                  'Can cook more units by: ${controller1.model.value.data!.product![index].date.toString()}',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
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
                                          //       "How long it takes to cook:",
                                          //       style: GoogleFonts.poppins(
                                          //           fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                          //     ),
                                          //     Text(
                                          //       '${controller1.model.value.data!.product![index].cookUnitDays ?? '5'.toString()}',
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
                                                    fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                              ),
                                              controller1.model.value.data!.product![index].qty == 0 ?
                                              Text(
                                                '0 Units',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500, fontSize: 11, color: const Color(0xFF364A4F)),
                                              ):Text(
                                                '${controller1.model.value.data!.product![index].qty ?? '5'.toString()} Units',
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
                              : Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              children: [
                                SizedBox(height: 60,),
                                Image.asset('assets/images/Favaorites.png'),
                                SizedBox(height: 10,),
                                Text("No Favaorites",
                                  style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,color: const Color(0xff000000),fontSize: 22),),
                              ],
                            ),
                          )
                        ),
                      );
                  })

                ],
              )
          ):
          const Center(child: CircularProgressIndicator(color: Colors.green,));
        }),
          bottomNavigationBar:
          cartListController.isDataLoading.value && cartListController.model.value.data!.cartItems!.isNotEmpty
              ? addCartSection()
              : null,
      );
  }
}
