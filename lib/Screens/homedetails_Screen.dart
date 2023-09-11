import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
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
import '../repository/vendor_store_single_repo.dart';
import '../repository/wishlist_repo.dart';
import '../resources/add_text.dart';
import '../widgets/app_theme.dart';

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({Key? key}) : super(key: key);

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> with TickerProviderStateMixin {
  final controller = Get.put(VendorSingleStoreController());
  final myCartController = Get.put(MyCartListController());
  Rx<CartItems> model = CartItems().obs;
  int tabIndex = 0;

  final RxBool isSelect = false.obs;
  late TabController tabControllerGG;
  String? referralLink;
  BranchContentMetaData metadata = BranchContentMetaData();
  BranchUniversalObject? buo;
  BranchLinkProperties lp = BranchLinkProperties();
  BranchEvent? eventStandard;
  BranchEvent? eventCustom;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();
  StreamController<String> controllerUrl = StreamController<String>();
  void onShare(code) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(code, subject: "link", sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
  getDataSubscription() {
    generateLink(
        BranchUniversalObject(
            canonicalIdentifier: 'flutter/branch',
            canonicalUrl: '',
            title: '',
            contentDescription: '',
            contentMetadata: BranchContentMetaData()..addCustomMetadata('referralCode', 47),
            keywords: ['Plugin', 'Branch', 'Flutter'],
            publiclyIndex: true,
            locallyIndex: true,
            expirationDateInMilliSec: DateTime.now().add(const Duration(days: 365)).millisecondsSinceEpoch),
        BranchLinkProperties(
            channel: 'facebook',
            feature: 'sharing',
            stage: 'new share',
            campaign: 'campaign',
            tags: ['one', 'two', 'three']));
    // Get.toNamed(ThankuScreen.thanku);
    print("1111111111111");
    setState(() {});
  }
  void initDeepLinkData() {
    metadata = BranchContentMetaData()
      ..addCustomMetadata('referralCode', 47)
    //--optional Custom Metadata
      ..contentSchema = BranchContentSchema.COMMERCE_PRODUCT
      ..price = 50.99
      ..currencyType = BranchCurrencyType.BRL
      ..quantity = 50
      ..sku = 'sku'
      ..productName = 'productName'
      ..productBrand = 'productBrand'
      ..productCategory = BranchProductCategory.ELECTRONICS
      ..productVariant = 'productVariant'
      ..condition = BranchCondition.NEW
      ..rating = 100
      ..ratingAverage = 50
      ..ratingMax = 100
      ..ratingCount = 2
      ..setAddress(street: 'street', city: 'city', region: 'ES', country: 'Brazil', postalCode: '99999-987')
      ..setLocation(31.4521685, -114.7352207);

    buo = BranchUniversalObject(
        canonicalIdentifier: 'flutter/branch',
        canonicalUrl: '',
        title: '',
        contentDescription: '',
        contentMetadata: metadata,
        keywords: ['Plugin', 'Branch', 'Flutter'],
        publiclyIndex: true,
        locallyIndex: true,
        expirationDateInMilliSec: DateTime.now().add(const Duration(days: 365)).millisecondsSinceEpoch);

    lp = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        stage: 'new share',
        campaign: 'campaign',
        tags: ['one', 'two', 'three'])
      ..addControlParam('\$uri_redirect_mode', '1');
  }
  void generateLink(BranchUniversalObject? buo, BranchLinkProperties lp) async {
    BranchResponse response = await FlutterBranchSdk.getShortUrl(buo: buo!, linkProperties: lp);
    if (response.success) {
      controllerUrl.sink.add('${response.result}');
      referralLink = response.result;
      setState(() {});
      print("referralLink $referralLink");
      print("ProductId ${Get.arguments[0]}");
    } else {
      controllerUrl.sink.add('Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }
  @override
  void initState() {
    getDataSubscription();
    initDeepLinkData();
    super.initState();
    tabControllerGG = TabController(length: 3, vsync: this);
    print(tabControllerGG);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getData();
      controller.getStoreKeywordListData();
    });
  }

  final autoController = AutoScrollController();

  @override
  void dispose() {
    print(tabControllerGG);
    tabControllerGG.dispose();
    autoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // var storeId="2";
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Obx(() {
        return Scaffold(

          body: controller.isDataLoading.value && controller.model.value.data != null
              ?
          VerticalScrollableTabView(
                  physics: const BouncingScrollPhysics(),
                  autoScrollController: autoController,
                  // scrollbarThumbVisibility: true,
                  tabController: TabController(length: 3, vsync: this),
                  listItemData:  const [
                    CarteScreen(data: "4"),
                    //  CarteScreen(data: "3"),
                    // CarteScreen(data: "2"),
                    // //carteingScreen(),
                    // mealPrepScreen()
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if(controller.model.value.data?.storeDetails != null)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl: controller.model.value.data!.storeDetails!.storeImage.toString(),
                                          fit: BoxFit.cover,
                                          height: 240,
                                          width: AddSize.screenWidth,
                                          errorWidget: (_, __, ___) => Image.asset(
                                            'assets/images/Rectangle 23007.png',
                                            height: 240,
                                            width: AddSize.screenWidth,
                                          ),
                                          placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                                        ),
                                      ),
                                      addHeight(20),
                                      if(controller.model.value.data?.storeDetails != null)
                                      Text(
                                        controller.model.value.data!.storeDetails!.name.toString().capitalizeFirst.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xFF21283D)),
                                      ),
                                      addHeight(10),
                                      if(controller.model.value.data?.storeDetails != null)
                                      Text(
                                        controller.model.value.data!.storeDetails!.description.toString().capitalizeFirst.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300, fontSize: 12, color: const Color(0xFF364A4F)),
                                      ),
                                      addHeight(20),
                                      const Divider(
                                        color: Color(0xFFF2F2F2),
                                        thickness: 2,
                                        height: 1,
                                      ),
                                      addHeight(15),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(MyRouters.reviewScreen);
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(
                                              'assets/images/favImg.png',
                                              height: 18,
                                            ),
                                            addWidth(7),
                                            if(controller.model.value.data?.storeDetails != null)
                                            Text(controller.model.value.data!.storeDetails!.avgRating.toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF1A2E33),
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            addWidth(7),
                                            if(controller.model.value.data?.storeDetails != null)
                                            Text(
                                                '(${controller.model.value.data!.storeDetails!.reviewCount.toString()} reviews)',
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF4E5F64),
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            const Spacer(),
                                            InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 13,
                                                  color: Color(0xFF000000),
                                                ))
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
                                          Image.asset(
                                            'assets/images/locationImg.png',
                                            height: 20,
                                            color: const Color(0xFF6AC643),
                                          ),
                                          const SizedBox(width: 10,),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                if(controller.model.value.data?.storeDetails != null)
                                                Text("${controller.model.value.data!.storeDetails!.distance.toString()} Km",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: const Color(0xFF1A2E33),
                                                      fontWeight: FontWeight.w600,
                                                    )),
                                                Text('Delivery Now',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: const Color(0xFF4E5F64),
                                                      fontWeight: FontWeight.w400,
                                                    )),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            width: 1.5,
                                            height: 30,
                                            color: const Color(0xFFE7E7E7),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/clockImg.png',
                                                  height: 24,
                                                ),
                                                addWidth(7),
                                                // if(controller.model.value.data!.storeDetails!.time != null)
                                                Expanded(
                                                  child: Text(
                                                       '${controller.model.value.data!.storeDetails!.time.toString()}'
                                                           '-${controller.model.value.data!.storeDetails!.time.toString()} mins',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xFF4E5F64),
                                                        fontWeight: FontWeight.w400,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 1.5,
                                            height: 30,
                                            color: const Color(0xFFE7E7E7),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/truckimg.png',
                                                  height: 24,
                                                  color: const Color(0xFF6AC643),
                                                ),
                                                addWidth(7),
                                                const Expanded(
                                                  child: Text('Delivery Only',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xFF4E5F64),
                                                        fontWeight: FontWeight.w400,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      addHeight(16),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    top: AddSize.screenHeight * .28,
                                    right: 26,
                                    child: Column(
                                      children: [
                                        if(controller.model.value.data?.storeDetails != null)
                                        Container(
                                            height: 67,
                                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      controller.model.value.data!.storeDetails!.profileImage.toString(),
                                                  fit: BoxFit.cover,
                                                  height: 55,
                                                  width: 55,
                                                  errorWidget: (_, __, ___) => Image.asset(
                                                    'assets/images/dummyPerson.png',
                                                  ),
                                                  placeholder: (_, __) => Center(child: CircularProgressIndicator()),
                                                ),
                                              ),
                                            )
                                            // Padding(
                                            //   padding: const EdgeInsets.all(3),
                                            //   child: CachedNetworkImage(
                                            //     imageUrl: controller.model.value.data!.storeDetails!.profileImage.toString(),
                                            //     fit: BoxFit.cover,
                                            //     errorWidget: (_, __, ___) => Image.asset(
                                            //       'assets/images/Ellipse 67.png',
                                            //     ),
                                            //     placeholder: (_, __) =>
                                            //         Center(child: CircularProgressIndicator()),
                                            //   ),
                                            // )
                                            ),
                                        addHeight(3),
                                      ],
                                    )),
                                Positioned(
                                  top: 20,
                                  // right: 0,
                                  left: 10,
                                  child: Container(
                                      height: 35,
                                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 14),
                                        child: InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: const Icon(Icons.arrow_back, color: Colors.black),
                                        ),
                                      )),
                                ),
                                Positioned(
                                    top: 20,
                                    right: 14,
                                    child: Row(
                                      children: [
                                        Container(
                                            height: 35,
                                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 14),
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.toNamed(MyRouters.homePageScreen);
                                                  },
                                                  child: const Icon(
                                                    Icons.search,
                                                    color: Color(0xFF54C523),
                                                  ),
                                                ),
                                              ),
                                            )),
                                        Container(
                                            height: 35,
                                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 14),
                                              child: Center(
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    //await Share.share('HomeMady ');
                                                    onShare(referralLink);
                                                  },
                                                  child: const Icon(
                                                    Icons.share_outlined,
                                                    color: Color(0xFF54C523),
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            )),
                                          if(controller.model.value.data != null)
                                        InkWell(
                                          onTap: (){
                                            print("store  id..${controller.model.value.data!.storeDetails!.id.toString()}");

                                            wishlistRepo(productId: '',id: controller.model.value.data!.storeDetails!.id.toString()
                                            ).then((value){
                                              if(value.status==true){
                                                showToast(value.message);
                                                controller.getData();
                                              }
                                            });
                                          },
                                          child:
                                          controller.model.value.data!.storeDetails!.wishlist! ?
                                          Container(
                                              height: 35,
                                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 14),
                                                child: Center(
                                                  child:
                                                    Icon(
                                                        Icons.favorite,
                                                        color: Color(0xFF54C523),
                                                      ),

                                                ),
                                              )):
                                          Container(
                                              height: 35,
                                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 14),
                                                child: Center(
                                                  child: Icon(
                                                      Icons.favorite_outline,
                                                      color: Color(0xFF54C523),
                                                    ),

                                                ),
                                              )),
                                        ),
                                      ],
                                    )),
                               // badge or award image
                               controller.model.value.data != null && controller.model.value.data!.storeDetails!.award!.isNotEmpty ?
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
                                                  barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                  barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                  pageBuilder: (BuildContext context, Animation first, Animation second) {
                                                    return Stack(
                                                      children: [
                                                        Center(child: Image.asset('assets/images/dialogboximg.png')),
                                                        Positioned(
                                                          right: 18,
                                                          top: 30,
                                                          child: Container(
                                                              padding: const EdgeInsets.all(10),
                                                              height: 80,
                                                              decoration: const BoxDecoration(
                                                                  color: Colors.white, shape: BoxShape.circle),
                                                              child: GestureDetector(
                                                                child: const Icon(Icons.clear),
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                              )),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl:    controller.model.value.data!.storeDetails!.award![0].image.toString(),
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
                                            ),),
                                        InkWell(
                                            onTap: () {
                                              showGeneralDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                  barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                  pageBuilder: (BuildContext context, Animation first, Animation second) {
                                                    return Stack(
                                                      children: [
                                                        Center(child: Image.asset('assets/images/dialogboximg.png')),
                                                        Positioned(
                                                          right: 18,
                                                          top: 30,
                                                          child: Container(
                                                              padding: EdgeInsets.all(10),
                                                              height: 80,
                                                              decoration: const BoxDecoration(
                                                                  color: Colors.white, shape: BoxShape.circle),
                                                              child: GestureDetector(
                                                                child: Icon(Icons.clear),
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                              )),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl:    controller.model.value.data!.storeDetails!.award![0].image.toString(),
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
                                    )) : const SizedBox() ,
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
                            print(value);
                            if(value == 0){
                              controller.filterId.value="2";
                              controller.getData();
                            }
                            if(value == 1){
                              controller.filterId.value="3";
                              controller.getData();
                            }
                            if(value == 2){
                              controller.filterId.value="4";
                              controller.getData();
                            }

                            //
                            // autoController.scrollToIndex(value, preferPosition: AutoScrollPosition.begin);
                          },
                          isScrollable: false,
                          unselectedLabelColor: const Color(0xFF1A2E33),
                          labelColor: Colors.white,
                          indicatorColor: Colors.transparent,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFF7ED957),
                          ),
                          tabs: const [
                            Tab(
                              text: 'A\' la carte',
                            ),
                            Tab(
                              text: 'Catering',
                            ),
                            Tab(
                              text: 'Meal Prep',
                            ),
                          ],
                          controller: tabControllerGG,
                          indicatorSize: TabBarIndicatorSize.tab,
                        )),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
          bottomNavigationBar:
              myCartController.isDataLoading.value && myCartController.model.value.data!.cartItems!.isNotEmpty
                  ? addCartSection()
                  : null,
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
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            insetPadding: const EdgeInsets.only(bottom: 0, top: 0),
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
                                    offset: const Offset(
                                      .1,
                                      .1,
                                    ),
                                    blurRadius: 20.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: CachedNetworkImage(
                                        imageUrl: controller.model.value.data!.latestProducts![index].image.toString(),
                                        fit: BoxFit.cover,
                                        errorWidget: (_, __, ___) => Image.asset(
                                          'assets/images/error_image.png',
                                        ),
                                        placeholder: (_, __) => Center(child: CircularProgressIndicator()),
                                      ),
                                    ),
                                    addWidth(10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.model.value.data!.latestProducts![index].name.toString(),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700, fontSize: 14, color: const Color(0xFF21283D)),
                                        ),
                                        addHeight(3),
                                        Text(
                                          'Size: 200gm',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                        ),
                                        addHeight(3),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'spiciness :',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10,
                                                      color: const Color(0xFF1F2D30)),
                                                ),
                                                addWidth(4),
                                                Text(
                                                  controller.model.value.data!.latestProducts![index].spiciness.toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10,
                                                      color: const Color(0xFF6CC844)),
                                                ),
                                              ],
                                            ),
                                            addWidth(10),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Allergens :',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 10,
                                                        color: const Color(0xFF1F2D30)),
                                                  ),
                                                ),
                                                addWidth(4),
                                                Text(
                                                  'Crustaceans',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10,
                                                      color: const Color(0xFF6CC844)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        addHeight(6),
                                        IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {},
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
                                                child: const Padding(
                                                  padding: EdgeInsets.only(left: 14.0, right: 14.0),
                                                  child: Text('0'),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
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
                                    Image.asset(
                                      'assets/images/helpimg.png',
                                      height: 13,
                                    ),
                                    addWidth(4),
                                    Text(
                                      'Can cook more units by: 30th June 2023',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
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
                                      ' 3 units',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500, fontSize: 11, color: const Color(0xFF364A4F)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 14,
                            right: 20,
                            child: Text(
                              '€6.99',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700, fontSize: 15, color: const Color(0xFF70CC49)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
