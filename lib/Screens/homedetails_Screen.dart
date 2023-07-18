import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/singlecookDetails/carte.dart';
import 'package:homemady/singlecookDetails/cartingScreen.dart';
import 'package:homemady/singlecookDetails/mealPrepScreen.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:share_plus/share_plus.dart';

import '../controller/my_cart_controller.dart';
import '../controller/vendor_single_store_controller.dart';
import '../model/My_Cart_Model.dart';
import '../model/vendor_store_single_model.dart';
import '../resources/add_text.dart';
import '../widgets/app_theme.dart';


class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({Key? key}) : super(key: key);

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen>
    with TickerProviderStateMixin {
  final controller = Get.put(VendorSingleStoreController());
  final myCartController = Get.put(MyCartListController());
  Rx<CartItems> model = CartItems().obs;


  final
  RxBool isSelect = false.obs;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    controller.getData();
    // vendorOrderListController.filter.value = "";
    // vendorOrderListController.vendorOrderListData();
    tabController = TabController(length: 3, vsync: this);
  }

  final autoController = AutoScrollController();

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Obx(() {
        return Scaffold(
            body: controller.isDataLoading.value ?
            VerticalScrollableTabView(
              physics: BouncingScrollPhysics(),
              autoScrollController: autoController,
              // scrollbarThumbVisibility: true,
              tabController: tabController,
              listItemData: const [
                carteScreen(),
                carteingScreen(),
                mealPrepScreen()
              ],
              verticalScrollPosition: VerticalScrollPosition.begin,
              eachItemChild: (object, index) => object,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: controller.model.value.data!.storeDetails!.storeImage.toString(),
                                    fit: BoxFit.cover,
                                    errorWidget: (_, __, ___) => Image.asset(
                                      'assets/images/Rectangle 23007.png',

                                    ),
                                    placeholder: (_, __) =>
                                        Center(child: CircularProgressIndicator()),
                                  ),
                                  addHeight(20),
                                   Text(controller.model.value.data!.storeDetails!.name.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Color(0xFF21283D)
                                    ),),
                                  addHeight(10),
                                   Text(
                                    controller.model.value.data!.storeDetails!.description.toString(),
                                    style: const TextStyle(
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
                                  addHeight(15),
                                  GestureDetector(
                                    onTap: (){
                                      Get.toNamed(MyRouters.reviewScreen);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/favImg.png', height: 18,),
                                        addWidth(7),
                                         Text(controller.model.value.data!.storeDetails!.avgRating.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF1A2E33),
                                              fontWeight: FontWeight.w700,)),
                                        addWidth(7),
                                         Text('(${controller.model.value.data!.storeDetails!.reviewCount.toString()}k reviews)',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF4E5F64),
                                              fontWeight: FontWeight.w400,)),
                                        const Spacer(),
                                        InkWell(
                                            onTap: (){},
                                            child: const Icon(
                                              Icons.arrow_forward_ios, size: 13,
                                              color: Color(0xFF000000),))

                                      ],
                                    ),
                                  ),
                                  addHeight(15),
                                  const Divider(
                                    color: Color(0xFFF2F2F2),
                                    thickness: 2,
                                    height: 1,
                                  ),
                                  addHeight(15),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset('assets/images/locationImg.png',
                                        height: 20,
                                        color: const Color(0xFF6AC643),),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Text(controller.model.value.data!.storeDetails!.deliveryType.toString().replaceAll('Delivery Now', ''),
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
                                          Image.asset(
                                            'assets/images/clockImg.png',
                                            height: 24,),
                                          addWidth(7),
                                           Text(controller.model.value.data!.storeDetails!.deliveryTime.toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF4E5F64),
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
                                          Image.asset(
                                            'assets/images/truckimg.png',
                                            height: 24,
                                            color: const Color(0xFF6AC643),),
                                          addWidth(7),
                                          const Text('Delivery Only',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF4E5F64),
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
                                top: AddSize.screenHeight*.29,
                                right: 26,
                                child: Column(
                                  children: [
                                    Container(
                                        height: 67,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: CachedNetworkImage(
                                            imageUrl: controller.model.value.data!.storeDetails!.profileImage.toString(),
                                            fit: BoxFit.cover,
                                            errorWidget: (_, __, ___) => Image.asset(
                                              'assets/images/Ellipse 67.png',
                                            ),
                                            placeholder: (_, __) =>
                                                Center(child: CircularProgressIndicator()),
                                          ),
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
                              child: Container(
                                  height: 35,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14),
                                    child: InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: const Icon(Icons.arrow_back,
                                          color: Colors.black),
                                    ),
                                  )
                              ),
                            ),
                            Positioned(
                                top: 20,
                                right: 14,
                                child: Row(
                                  children: [
                                    Container(
                                        height: 35,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14),
                                          child: Center(
                                            child: InkWell(
                                              onTap: () {
                                                _showSimpleDialog3(context);
                                              },
                                              child: const Icon(Icons.search,
                                                color: Color(
                                                    0xFF54C523),),
                                            ),
                                          ),
                                        )
                                    ),
                                    Container(
                                        height: 35,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white
                                        ),
                                        child:
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14),
                                          child: Center(
                                            child: InkWell(
                                              onTap: () async {
                                                await Share.share('HomeMady ');
                                              },
                                              child: const Icon(
                                                Icons.share_outlined,
                                                color: Color(
                                                    0xFF54C523), size: 20,),
                                            ),
                                          ),
                                        )
                                    ),
                                    Container(
                                        height: 35,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14),
                                          child: Center(
                                            child: Obx(() {
                                              return InkWell(
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
                                              );
                                            }),
                                          ),
                                        )
                                    ),
                                  ],
                                )
                            ),
                            Positioned(
                                top: 200,
                                left: 10,
                                right: 15,
                                //   bottom: 0,
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          showGeneralDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              barrierColor: const Color(
                                                  0xFF000000).withOpacity(0.58),
                                              barrierLabel: MaterialLocalizations
                                                  .of(context)
                                                  .modalBarrierDismissLabel,
                                              pageBuilder: (BuildContext context,
                                                  Animation first,
                                                  Animation second) {
                                                return Stack(
                                                  children: [
                                                    Center(child: Image.asset(
                                                        'assets/images/dialogboximg.png')),
                                                    Positioned(
                                                      right: 18,
                                                      top: 30,
                                                      child: Container(
                                                          padding: EdgeInsets.all(
                                                              10),
                                                          height: 80,
                                                          decoration: const BoxDecoration(
                                                              color: Colors.white,
                                                              shape: BoxShape
                                                                  .circle
                                                          ),
                                                          child:GestureDetector(child: Icon(Icons.clear),onTap: (){
                                                            Get.back();
                                                          },)
                                                      ),)
                                                  ],
                                                );
                                              }
                                          );
                                        },
                                        child: Image.asset(
                                          'assets/images/topChef.png',
                                          width: 50,)),
                                    InkWell(
                                        onTap: () {
                                          showGeneralDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              barrierColor: const Color(
                                                  0xFF000000).withOpacity(0.58),
                                              barrierLabel: MaterialLocalizations
                                                  .of(context)
                                                  .modalBarrierDismissLabel,
                                              pageBuilder: (BuildContext context,
                                                  Animation first,
                                                  Animation second) {
                                                return Stack(
                                                  children: [
                                                    Center(child: Image.asset(
                                                        'assets/images/dialogboximg.png')),
                                                    Positioned(
                                                      right: 18,
                                                      top: 30,
                                                      child: Container(
                                                          padding: EdgeInsets.all(
                                                              10),
                                                          height: 80,
                                                          decoration: const BoxDecoration(
                                                              color: Colors.white,
                                                              shape: BoxShape
                                                                  .circle
                                                          ),
                                                          child:GestureDetector(child: Icon(Icons.clear),onTap: (){
                                                            Get.back();
                                                          },)
                                                      ),)
                                                  ],
                                                );
                                              }
                                          );
                                        },
                                        child: Image.asset(
                                          'assets/images/topChef.png',
                                          width: 50,)),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                SliverAppBar(
                    pinned: true,
                    floating: true,
                    toolbarHeight: 0,
                    backgroundColor: Colors.white,
                    elevation: 1,
                    bottom: TabBar(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      onTap: (value) {
                        autoController
                            .scrollToIndex(
                            value, preferPosition: AutoScrollPosition.begin);
                      },
                      isScrollable: false,
                      unselectedLabelColor: const Color(0xFF1A2E33),
                      labelColor:   Colors.white,
                      indicatorColor: Colors.transparent,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xFF7ED957),

                      ),
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
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    )),
              ],
            ) : Center(child: CircularProgressIndicator()),
          bottomNavigationBar: myCartController.isDataLoading.value &&
              myCartController.model.value.data!.cartItems!.isNotEmpty ?
          addCartSection() : null,
        );
      }),
    );
  }
  Future<void> _showSimpleDialog3(BuildContext context) async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        barrierColor: const Color(0x01000000),
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
            ),
            insetPadding: const EdgeInsets.only(bottom: 0,top: 0),
            child: ListView.builder(
              itemCount: controller.model.value.data!.latestProducts!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
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
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child:  CachedNetworkImage(
                                          imageUrl: controller.model.value.data!.latestProducts![index].image.toString(),
                                          fit: BoxFit.cover,
                                          errorWidget: (_, __, ___) => Image.asset(
                                            'assets/images/error_image.png',
                                          ),
                                          placeholder: (_, __) =>
                                              Center(child: CircularProgressIndicator()),
                                        ),
                                    ),
                                    addWidth(10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.model.value.data!.latestProducts![index].name.toString(),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: const Color(0xFF21283D)
                                          ),),
                                        addHeight(3),
                                        Text('Size: 200gm',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 11,
                                              color: const Color(0xFF364A4F)
                                          ),),
                                        addHeight(3),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text('spiciness :',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10,
                                                      color: const Color(0xFF1F2D30)
                                                  ),),
                                                addWidth(4),
                                                Text('Mildly Spicy',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10,
                                                      color: const Color(0xFF6CC844)
                                                  ),),
                                              ],
                                            ),
                                            addWidth(10),
                                            Row(
                                              children: [
                                                Text('Allergens :',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10,
                                                      color: const Color(0xFF1F2D30)
                                                  ),),
                                                addWidth(4),
                                                Text('Crustaceans',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10,
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
                                                  decoration: BoxDecoration(color: const Color(0xFF72CD4A),border: Border.all(color: const Color(0xFF72CD4A)), shape: BoxShape.circle),
                                                  alignment: Alignment.center,
                                                  child: const Padding(
                                                    padding:  EdgeInsets.symmetric(horizontal: 8),
                                                    child: Text(
                                                      '+',
                                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Colors.white),
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
                                  ],
                                ),
                                addHeight(5),
                                Container(
                                  margin: EdgeInsets.only(left: 75),
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
                                    Image.asset('assets/images/helpimg.png',height: 13,),
                                    addWidth(4),
                                    Text('Can cook more units by: 30th June 2023',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 11,
                                          color: const Color(0xFF364A4F)
                                      ),),
                                  ],
                                ),
                                addHeight(4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    addWidth(80),
                                    Image.asset('assets/images/helpimg.png',height: 13,),
                                    addWidth(4),
                                    Text('Available stock: ',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 11,
                                          color: const Color(0xFF364A4F)
                                      ),),
                                    Text(' 3 units',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                          color: const Color(0xFF364A4F)
                                      ),),
                                  ],
                                ),


                              ],
                            ),
                          ),
                          Positioned(
                            top: 14,
                            right: 20,
                            child:  Text('€6.99',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: const Color(0xFF70CC49)
                              ),),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },),
          );
        }
    );
  }
}
