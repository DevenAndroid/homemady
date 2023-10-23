import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/Screens/search_screen_data.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';
import '../controller/category_controller.dart';
import '../controller/fillter_product_category_controller.dart';
import '../controller/homepage_controller.dart';
import '../controller/my_address_controller.dart';
import '../controller/my_cart_controller.dart';
import '../controller/search_store_conbtroller.dart';
import '../controller/time_slot_controller.dart';
import '../controller/user_profile_controller.dart';
import '../controller/vendor_single_store_controller.dart';
import '../repository/wishlist_repo.dart';
import '../resources/add_text.dart';

class FilterProductScreen extends StatefulWidget {
  final String filterId;
  const FilterProductScreen({Key? key, required this.filterId}) : super(key: key);
  // static var filterProductScreen="/filterProductScreen";

  @override
  State<FilterProductScreen> createState() => _FilterProductScreenState();
}

class _FilterProductScreenState extends State<FilterProductScreen> {
  final categoryController = Get.put(CategoryController());
  final homeController = Get.put(HomePageController());
  final profileController = Get.put(UserProfileController());
  final myCartController = Get.put(MyCartListController());
  final searchController = Get.put(SearchStoreController());
  final timeSlotController = Get.put(TimeSlotController());
  final myAddressController = Get.put(MyAddressController());
  final controller = Get.put(VendorSingleStoreController());
  final cartListController = Get.put(MyCartListController());
  final filterProductCategoryController = Get.put(FilterProductCategoryController());

  String dateInput11 = "";
  RxBool isValue = false.obs;
  String? selectedCategory;
  int currentIndex = -1;
  List productCategory = ['Sustainable Packaging', 'Top Chefs', 'Rating', 'Distance', 'Quickest Delivery', 'Recommended'];

  final RxBool _isValue1 = false.obs;
  final RxBool _isValue2 = false.obs;
  bool? isChoosedFilterOption = false;

  final scrollController = ScrollController();
  final scrollController1 = ScrollController();
  RxBool isSelect = false.obs;
  RxBool selectIcon = false.obs;
  int currentDrawer = 0;
  RxInt count = 0.obs;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedDate = 'Deliver Now';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      filterProductCategoryController.getFilterCategoryData(distance: widget.filterId);
      myCartController.getData();
      categoryController.getCategoryData();
      timeSlotController.getTimeSlotData();
      myAddressController.getData();

      int currnetIndex = -1;
      _decrement();
      _increment();
    });
  }


  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      searchController.page.value = searchController.page.value + 1;
      searchController.getSearchData();
    } else {
      if (kDebugMode) {
        print("Dont call");
      }
    }
  }

// filter product category wise
  void _scrollListener1() {
    if (scrollController1.position.pixels == scrollController1.position.maxScrollExtent) {
      // filterProductCategoryController.page.value = filterProductCategoryController.page.value + 1;
      //filterProductCategoryController.getFilterCategoryData();
    } else {
      if (kDebugMode) {
        print("Not calling");
      }
    }
  }

  void _increment() {
    setState(() {
      count++;
    });
  }

  void _decrement() {
    setState(() {
      count--;
    });
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: backAppBar(title: 'Search Cooks', context: context),
        body: Obx(() {
          return SafeArea(
            child: filterProductCategoryController.isDataLoading.value ? filterProductCategoryController.filterDataModel.value.data != null
                ?
            SingleChildScrollView(
                  // physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14, top: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                          controller: searchController.searchController1,
                                          prefix: InkWell(
                                            onTap: () {
                                              if (selectedDate != "Deliver Now") {
                                                Get.toNamed(SearchScreenData.searchScreen, arguments: [selectedDate]);
                                              } else {
                                                showToast("Please pick a date");
                                              }
                                            },
                                            child: Icon(
                                              Icons.search,
                                              size: 19,
                                              color: const Color(0xFF000000).withOpacity(0.56),
                                            ),
                                          ),
                                          onChanged: (val) {
                                            isValue.value = true;
                                            searchController.getSearchData();
                                            // Get.toNamed(SearchScreenData.searchScreen);
                                          },
                                        )),
                                  ),
                                  addWidth(10),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      //_showDialogCategory();
                                      // showUploadWindow(categoryController.categoryModel.value.data!.category!);
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
                                      // _showSimpleDialog1();
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

                              addWidth(30),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      // height: 140,
                                      child:
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: filterProductCategoryController.filterDataModel.value.data!.length,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color(0xFF37C666).withOpacity(0.15),
                                                        offset: const Offset(
                                                          .3,
                                                          .3,
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
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Get.toNamed(MyRouters.homeDetailsScreen, arguments: [
                                                              filterProductCategoryController.filterDataModel.value.data![index].id.toString()
                                                            ]);
                                                          },
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(8),
                                                                child: CachedNetworkImage(
                                                                  imageUrl: filterProductCategoryController.filterDataModel.value.data![index].image.toString(),
                                                                  fit: BoxFit.cover,
                                                                  height: 150,
                                                                  width: AddSize.screenWidth,
                                                                  errorWidget: (_, __, ___) => Image.asset(
                                                                    'assets/images/Rectangle 23007.png',
                                                                    fit: BoxFit.cover,
                                                                    height: 150,
                                                                    width: AddSize.screenWidth,
                                                                  ),
                                                                  placeholder: (_, __) =>
                                                                  const Center(child: CircularProgressIndicator()),
                                                                ),
                                                              ),
                                                              /*ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child: Image.asset(
                                                      'assets/images/Rectangle 23007.png',fit: BoxFit.cover,
                                                      height: 140,width: AddSize.screenWidth,
                                                    ),
                                                  ),*/
                                                              addHeight(6),
                                                              Text(
                                                                filterProductCategoryController.filterDataModel.value.data![index].name.toString().capitalizeFirst.toString(),
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 16,
                                                                    color: const Color(0xFF21283D)),
                                                              ),
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
                                                                    '${filterProductCategoryController.filterDataModel.value.data![index].collection.toString()} ',
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 12,
                                                                        color: const Color(0xFF606573)),
                                                                  ),
                                                                  filterProductCategoryController.filterDataModel.value.data![index].collection == 'Collection Only' ||
                                                                      filterProductCategoryController.filterDataModel.value.data![index].collection == 'Both Delivery & Collection' ?
                                                                  const SizedBox() :
                                                                  Text(
                                                                    '${filterProductCategoryController.filterDataModel.value.data![index].time ?? ''.toString()} - ${filterProductCategoryController.filterDataModel.value.data![index].time1 ?? ''.toString()} mins',
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 12,
                                                                        color: const Color(0xFF606573)),
                                                                  ),
                                                                  const SizedBox(width: 4,),
                                                                  filterProductCategoryController.filterDataModel.value.data![index].collection == 'Collection Only' ?
                                                                  const SizedBox() :
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(bottom: 5),
                                                                    child: Text(
                                                                      '.',
                                                                      style: GoogleFonts.poppins(
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: 12,
                                                                          color: const Color(0xFF606573)),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(width: 4,),
                                                                  Text(
                                                                    "${filterProductCategoryController.filterDataModel.value.data![index].distance.toString()} km",
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


                                                      if(filterProductCategoryController.filterDataModel.value.data![index].award != null)
                                                      filterProductCategoryController.filterDataModel.value.data![index].award!.isNotEmpty || filterProductCategoryController.filterDataModel.value.data![index].sustainablePackagingStatus == true?
                                                      Positioned(
                                                          top: 14,
                                                          // bottom: 0,
                                                          left: 10,
                                                          right: 15,
                                                          //   bottom: 0,
                                                          child: Row(
                                                            children: [
                                                              Row(
                                                                children:  [
                                                                  ...List.generate(filterProductCategoryController.filterDataModel.value.data![index].award!.length, (index1){
                                                                    return  InkWell(
                                                                      onTap: (){
                                                                        showGeneralDialog(
                                                                            context: context,
                                                                            barrierDismissible: true,
                                                                            barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                                            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                                            pageBuilder: (BuildContext context,Animation first, Animation second){
                                                                              return  Stack(
                                                                                children: [
                                                                                  Center(child: CachedNetworkImage(
                                                                                    imageUrl:     filterProductCategoryController.filterDataModel.value.data![index].award![index1].image.toString(),
                                                                                    //fit: BoxFit.cover,
                                                                                    height: height * .7,
                                                                                    width: width * .7,
                                                                                    errorWidget: (_, __, ___) => Image.asset(
                                                                                      'assets/images/topChef.png',
                                                                                      // fit: BoxFit.cover,
                                                                                      height: 40,
                                                                                      width: 40,
                                                                                    ),
                                                                                    placeholder: (_, __) =>
                                                                                    const Center(child: CircularProgressIndicator()),
                                                                                  )),
                                                                                  Positioned(
                                                                                    right: 22,
                                                                                    top: 100,
                                                                                    child: GestureDetector(
                                                                                      onTap:(){
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Container(
                                                                                          padding: const EdgeInsets.all(10),
                                                                                          height: 50,
                                                                                          decoration: const BoxDecoration(
                                                                                              color: Colors.white,
                                                                                              shape: BoxShape.circle
                                                                                          ),
                                                                                          child:  const Icon(Icons.clear)
                                                                                      ),
                                                                                    ),)
                                                                                ],
                                                                              );
                                                                            }
                                                                        );
                                                                      },
                                                                      child:    CachedNetworkImage(
                                                                        imageUrl:     filterProductCategoryController.filterDataModel.value.data![index].award![index1].image.toString(),
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
                                                                      ),);
                                                                  })
                                                                  // InkWell(
                                                                  //     onTap: (){
                                                                  //       showGeneralDialog(
                                                                  //           context: context,
                                                                  //           barrierDismissible: true,
                                                                  //           barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                                  //           barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                                  //           pageBuilder: (BuildContext context,Animation first, Animation second){
                                                                  //             return  Stack(
                                                                  //               children: [
                                                                  //                 Center(child: CachedNetworkImage(
                                                                  //                   imageUrl:     homeController.model.value.data!.stores![index].award![index].image.toString(),
                                                                  //                   //fit: BoxFit.cover,
                                                                  //                   height: height * .7,
                                                                  //                   width: width * .7,
                                                                  //                   errorWidget: (_, __, ___) => Image.asset(
                                                                  //                     'assets/images/topChef.png',
                                                                  //                     // fit: BoxFit.cover,
                                                                  //                     height: height * .3,
                                                                  //                     width: width * .4,
                                                                  //                   ),
                                                                  //                   placeholder: (_, __) =>
                                                                  //                   const Center(child: CircularProgressIndicator()),
                                                                  //                 )),
                                                                  //                 Positioned(
                                                                  //                   right: 20,
                                                                  //                   top: 100,
                                                                  //                   child: GestureDetector(
                                                                  //                     onTap: (){
                                                                  //                       Get.back();
                                                                  //                     },
                                                                  //                     child: Container(
                                                                  //                         padding: const EdgeInsets.all(10),
                                                                  //                         height: 80,
                                                                  //                         decoration: const BoxDecoration(
                                                                  //                             color: Colors.white,
                                                                  //                             shape: BoxShape.circle
                                                                  //                         ),
                                                                  //                         child:  const Icon(Icons.clear)
                                                                  //                     ),
                                                                  //                   ),)
                                                                  //               ],
                                                                  //             );
                                                                  //           }
                                                                  //       );
                                                                  //     },
                                                                  //     child:    CachedNetworkImage(
                                                                  //       imageUrl:     homeController.model.value.data!.stores![index].award![0].image.toString(),
                                                                  //       //fit: BoxFit.cover,
                                                                  //       height: 40,
                                                                  //       width: 40,
                                                                  //       errorWidget: (_, __, ___) => Image.asset(
                                                                  //         'assets/images/topChef.png',
                                                                  //         // fit: BoxFit.cover,
                                                                  //         height: 40,
                                                                  //         width: 40,
                                                                  //       ),
                                                                  //       placeholder: (_, __) =>
                                                                  //       const Center(child: CircularProgressIndicator()),
                                                                  //     ),
                                                                  // ),


                                                                ],
                                                              ),
                                                              if(filterProductCategoryController.filterDataModel.value.data![index].sustainablePackagingStatus == true)
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
                                                                              Center(
                                                                                child: Image.asset(
                                                                                  'assets/images/leavesIcon.png',
                                                                                  // fit: BoxFit.cover,
                                                                                  height: height * .3,
                                                                                  // width: width * .4,
                                                                                ),),
                                                                              Positioned(
                                                                                right: 20,
                                                                                top: 100,
                                                                                child: GestureDetector(
                                                                                  onTap: (){
                                                                                    Get.back();
                                                                                  },
                                                                                  child: Container(
                                                                                      padding: const EdgeInsets.all(10),
                                                                                      height: 50,
                                                                                      decoration: const BoxDecoration(
                                                                                          color: Colors.white,
                                                                                          shape: BoxShape.circle
                                                                                      ),
                                                                                      child:  const Icon(Icons.clear)
                                                                                  ),
                                                                                ),)
                                                                            ],
                                                                          );
                                                                        }
                                                                    );
                                                                  },
                                                                  child: Image.asset(
                                                                    'assets/images/leavesIcon.png',
                                                                    // fit: BoxFit.cover,
                                                                    height: 35,
                                                                    width: 35,
                                                                  ),
                                                                )
                                                            ],
                                                          )
                                                      ) : const SizedBox(),

                                                      Positioned(
                                                          bottom: 10,
                                                          right: 20,
                                                          //   bottom: 0,
                                                          child: Column(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                  height: 55,
                                                                  // width: 30,
                                                                  decoration: const BoxDecoration(
                                                                      shape: BoxShape.circle, color: Colors.white),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(4),
                                                                    child:
                                                                    // Image.asset('assets/images/avtarImg.png'),

                                                                    SizedBox(
                                                                      height: 50,
                                                                      width: 50,
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(50),
                                                                        child: CachedNetworkImage(
                                                                          imageUrl: filterProductCategoryController.isDataLoading.value
                                                                              ? filterProductCategoryController.filterDataModel.value.data![index]
                                                                              .profileImage
                                                                              .toString()
                                                                              : 'assets/images/avtarImg.png',
                                                                          // height: 40,
                                                                          fit: BoxFit.cover,
                                                                          errorWidget: (_, __, ___) => Image.asset(
                                                                            'assets/images/dummyPerson.png',
                                                                            fit: BoxFit.cover,
                                                                            // height: 20,
                                                                            // width: 20,
                                                                          ),
                                                                          placeholder: (_, __) =>
                                                                          const Center(child: CircularProgressIndicator()),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )),
                                                              addHeight(3),
                                                              if(filterProductCategoryController.filterDataModel.value.data![index].cookName != null)
                                                              Text(
                                                                (filterProductCategoryController.filterDataModel.value.data![index].cookName!.isEmpty
                                                                    ? 'Test'
                                                                    : filterProductCategoryController.filterDataModel.value.data![index].cookName)
                                                                    .toString().capitalizeFirst.toString(),
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 12,
                                                                    color: const Color(0xFF21283D)),
                                                              ),
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  const Icon(
                                                                    Icons.star,
                                                                    color: Color(0xFFFFC529),
                                                                    size: 14,
                                                                  ),
                                                                  addWidth(3),
                                                                  Text(
                                                                    filterProductCategoryController.filterDataModel.value.data![index].rating
                                                                        .toString(),
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 11,
                                                                        color: const Color(0xFF6A7080)),
                                                                  ),
                                                                  Text(
                                                                    '(${(filterProductCategoryController.filterDataModel.value.data![index].countReviewData).toString()})',
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 11,
                                                                        color: const Color(0xFF6A7080)),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          )),
                                                      Positioned(
                                                          top: 16,
                                                          right: 10,
                                                          child: InkWell(
                                                              onTap: () {

                                                                wishlistRepo(
                                                                    id: filterProductCategoryController.filterDataModel.value.data![index].id
                                                                        .toString(),
                                                                    productId: '')
                                                                    .then((value) {
                                                                  if (value.status == true) {
                                                                    showToast(value.message);
                                                                    filterProductCategoryController.getFilterCategoryData(distance: widget.filterId);
                                                                  }
                                                                });
                                                              },
                                                              child: filterProductCategoryController.filterDataModel.value.data![index].wishlist!
                                                                  ? Container(
                                                                  height: 33,
                                                                  decoration: const BoxDecoration(
                                                                      shape: BoxShape.circle, color: Colors.white),
                                                                  child: const Padding(
                                                                      padding:
                                                                      EdgeInsets.only(left: 10, right: 10, top: 3),
                                                                      child: Icon(
                                                                        Icons.favorite,
                                                                        color: Color(0xFF7ED957),
                                                                      )))
                                                                  : Container(
                                                                  height: 33,
                                                                  decoration: const BoxDecoration(
                                                                      shape: BoxShape.circle, color: Colors.white),
                                                                  child: const Padding(
                                                                      padding:
                                                                      EdgeInsets.only(left: 10, right: 10, top: 3),
                                                                      child: Icon(
                                                                        Icons.favorite_outline,
                                                                        color: Color(0xFF7ED957),
                                                                      ))))),
                                                      // homeController.model.value.data!.stores![index].award!.isNotEmpty ?
                                                      // Positioned(
                                                      //     top: 14,
                                                      //     // bottom: 0,
                                                      //     left: 10,
                                                      //     right: 15,
                                                      //     //   bottom: 0,
                                                      //     child: Row(
                                                      //       children:  [
                                                      //         ...List.generate(homeController.model.value.data!.stores![index].award!.length, (index1){
                                                      //           return  InkWell(
                                                      //             onTap: (){
                                                      //               showGeneralDialog(
                                                      //                   context: context,
                                                      //                   barrierDismissible: true,
                                                      //                   barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                      //                   barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                      //                   pageBuilder: (BuildContext context,Animation first, Animation second){
                                                      //                     return  Stack(
                                                      //                       children: [
                                                      //                         Center(child: CachedNetworkImage(
                                                      //                           imageUrl:     homeController.model.value.data!.stores![index].award![index1].image.toString(),
                                                      //                           //fit: BoxFit.cover,
                                                      //                           height: height * .7,
                                                      //                           width: width * .7,
                                                      //                           errorWidget: (_, __, ___) => Image.asset(
                                                      //                             'assets/images/topChef.png',
                                                      //                             // fit: BoxFit.cover,
                                                      //                             height: 40,
                                                      //                             width: 40,
                                                      //                           ),
                                                      //                           placeholder: (_, __) =>
                                                      //                           const Center(child: CircularProgressIndicator()),
                                                      //                         )),
                                                      //                         Positioned(
                                                      //                           right: 22,
                                                      //                           top: 100,
                                                      //                           child: GestureDetector(
                                                      //                             onTap:(){
                                                      //                               Get.back();
                                                      //                             },
                                                      //                             child: Container(
                                                      //                                 padding: const EdgeInsets.all(10),
                                                      //                                 height: 50,
                                                      //                                 decoration: const BoxDecoration(
                                                      //                                     color: Colors.white,
                                                      //                                     shape: BoxShape.circle
                                                      //                                 ),
                                                      //                                 child:  const Icon(Icons.clear)
                                                      //                             ),
                                                      //                           ),)
                                                      //                       ],
                                                      //                     );
                                                      //                   }
                                                      //               );
                                                      //             },
                                                      //             child:    CachedNetworkImage(
                                                      //               imageUrl:     homeController.model.value.data!.stores![index].award![index1].image.toString(),
                                                      //               //fit: BoxFit.cover,
                                                      //               height: 40,
                                                      //               width: 40,
                                                      //               errorWidget: (_, __, ___) => Image.asset(
                                                      //                 'assets/images/topChef.png',
                                                      //                 // fit: BoxFit.cover,
                                                      //                 height: 40,
                                                      //                 width: 40,
                                                      //               ),
                                                      //               placeholder: (_, __) =>
                                                      //               const Center(child: CircularProgressIndicator()),
                                                      //             ),);
                                                      //         })
                                                      //         // InkWell(
                                                      //         //     onTap: (){
                                                      //         //       showGeneralDialog(
                                                      //         //           context: context,
                                                      //         //           barrierDismissible: true,
                                                      //         //           barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                      //         //           barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                      //         //           pageBuilder: (BuildContext context,Animation first, Animation second){
                                                      //         //             return  Stack(
                                                      //         //               children: [
                                                      //         //                 Center(child: CachedNetworkImage(
                                                      //         //                   imageUrl:     homeController.model.value.data!.stores![index].award![index].image.toString(),
                                                      //         //                   //fit: BoxFit.cover,
                                                      //         //                   height: height * .7,
                                                      //         //                   width: width * .7,
                                                      //         //                   errorWidget: (_, __, ___) => Image.asset(
                                                      //         //                     'assets/images/topChef.png',
                                                      //         //                     // fit: BoxFit.cover,
                                                      //         //                     height: height * .3,
                                                      //         //                     width: width * .4,
                                                      //         //                   ),
                                                      //         //                   placeholder: (_, __) =>
                                                      //         //                   const Center(child: CircularProgressIndicator()),
                                                      //         //                 )),
                                                      //         //                 Positioned(
                                                      //         //                   right: 20,
                                                      //         //                   top: 100,
                                                      //         //                   child: GestureDetector(
                                                      //         //                     onTap: (){
                                                      //         //                       Get.back();
                                                      //         //                     },
                                                      //         //                     child: Container(
                                                      //         //                         padding: const EdgeInsets.all(10),
                                                      //         //                         height: 80,
                                                      //         //                         decoration: const BoxDecoration(
                                                      //         //                             color: Colors.white,
                                                      //         //                             shape: BoxShape.circle
                                                      //         //                         ),
                                                      //         //                         child:  const Icon(Icons.clear)
                                                      //         //                     ),
                                                      //         //                   ),)
                                                      //         //               ],
                                                      //         //             );
                                                      //         //           }
                                                      //         //       );
                                                      //         //     },
                                                      //         //     child:    CachedNetworkImage(
                                                      //         //       imageUrl:     homeController.model.value.data!.stores![index].award![0].image.toString(),
                                                      //         //       //fit: BoxFit.cover,
                                                      //         //       height: 40,
                                                      //         //       width: 40,
                                                      //         //       errorWidget: (_, __, ___) => Image.asset(
                                                      //         //         'assets/images/topChef.png',
                                                      //         //         // fit: BoxFit.cover,
                                                      //         //         height: 40,
                                                      //         //         width: 40,
                                                      //         //       ),
                                                      //         //       placeholder: (_, __) =>
                                                      //         //       const Center(child: CircularProgressIndicator()),
                                                      //         //     ),
                                                      //         // ),
                                                      //
                                                      //
                                                      //       ],
                                                      //     )
                                                      // ) : const SizedBox(),
                                                      //
                                                      // homeController.model.value.data!.stores![index].sustainablePackagingStatus!  ?
                                                      // Positioned(
                                                      //   top: 14,
                                                      //   // bottom: 0,
                                                      //   left:   homeController.model.value.data!.stores![index].award!.isNotEmpty  ? 100 : 15,
                                                      //   //right: 15,
                                                      //   child: InkWell(
                                                      //     onTap: (){
                                                      //       showGeneralDialog(
                                                      //           context: context,
                                                      //           barrierDismissible: true,
                                                      //           barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                      //           barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                      //           pageBuilder: (BuildContext context,Animation first, Animation second){
                                                      //             return  Stack(
                                                      //               children: [
                                                      //                 Center(
                                                      //                   child: Image.asset(
                                                      //                   'assets/images/leavesIcon.png',
                                                      //                   // fit: BoxFit.cover,
                                                      //                   height: height * .3,
                                                      //                   // width: width * .4,
                                                      //                 ),),
                                                      //                 Positioned(
                                                      //                   right: 20,
                                                      //                   top: 100,
                                                      //                   child: GestureDetector(
                                                      //                     onTap: (){
                                                      //                       Get.back();
                                                      //                     },
                                                      //                     child: Container(
                                                      //                         padding: const EdgeInsets.all(10),
                                                      //                         height: 50,
                                                      //                         decoration: const BoxDecoration(
                                                      //                             color: Colors.white,
                                                      //                             shape: BoxShape.circle
                                                      //                         ),
                                                      //                         child:  const Icon(Icons.clear)
                                                      //                     ),
                                                      //                   ),)
                                                      //               ],
                                                      //             );
                                                      //           }
                                                      //       );
                                                      //     },
                                                      //     child: Image.asset(
                                                      //     'assets/images/leavesIcon.png',
                                                      //     // fit: BoxFit.cover,
                                                      //     height: 35,
                                                      //     width: 35,
                                                      //      ),
                                                      //   ),
                                                      // ) : const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              )
                                            ],
                                          );
                                        },
                                      )
                                      // ListView.builder(
                                      //   physics: const BouncingScrollPhysics(),
                                      //   itemCount: filterProductCategoryController.filterDataModel.value.data!.length,
                                      //   shrinkWrap: true,
                                      //   itemBuilder: (context, index) {
                                      //
                                      //     String productID = filterProductCategoryController.filterDataModel.value.data![index].id
                                      //         .toString().trim();
                                      //     filterProductCategoryController.filterDataModel.value.data![index].productCount = int.tryParse((cartListController.model.value.data!.cartItems!.firstWhere((element) =>
                                      //     element.productId.toString() == productID,orElse: ()=> CartItems()).cartItemQty ?? "").toString()) ?? 0;
                                      //     final product = filterProductCategoryController.filterDataModel.value.data![index];
                                      //
                                      //     return Column(
                                      //       children: [
                                      //         Container(
                                      //           padding: const EdgeInsets.all(14),
                                      //           decoration: BoxDecoration(
                                      //               color: Colors.white,
                                      //               boxShadow: [
                                      //                 BoxShadow(
                                      //                   color: const Color(0xFF37C666).withOpacity(0.10),
                                      //                   offset: const Offset(
                                      //                     .1,
                                      //                     .1,
                                      //                   ),
                                      //                   blurRadius: 20.0,
                                      //                   spreadRadius: 1.0,
                                      //                 ),
                                      //               ],
                                      //               borderRadius: BorderRadius.circular(12)),
                                      //           child: InkWell(
                                      //             onTap: () {
                                      //               // print(
                                      //               //   controller.model.value.data!.latestProducts![index].id.toString(),
                                      //               // );
                                      //               // Get.toNamed(MyRouters.myCartScreen);
                                      //             },
                                      //             child: Column(
                                      //               crossAxisAlignment: CrossAxisAlignment.start,
                                      //               children: [
                                      //                 Row(
                                      //                   mainAxisAlignment: MainAxisAlignment.start,
                                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                                      //                   children: [
                                      //                     Stack(
                                      //
                                      //                       children: [
                                      //
                                      //                         ClipRRect(
                                      //                           borderRadius: BorderRadius.circular(10),
                                      //                           child:
                                      //                           CachedNetworkImage(
                                      //                             imageUrl: filterProductCategoryController.filterDataModel.value.data![index].image.toString(),
                                      //                             fit: BoxFit.cover,
                                      //                             height: 110,
                                      //                             width: 75,
                                      //                             errorWidget: (_, __, ___) => Image.asset(
                                      //                               'assets/images/Rectangle 23007.png',
                                      //                               fit: BoxFit.cover,
                                      //                               height: 80,
                                      //                               width: 60,
                                      //                             ),
                                      //                             placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                                      //                           ),
                                      //                         ),
                                      //                         Positioned(
                                      //                             top: 5,
                                      //                             right:-4,
                                      //
                                      //                             child: InkWell(
                                      //                               onTap: (){
                                      //                                 print("Product  id..${filterProductCategoryController.filterDataModel.value.data![index].id.toString()}");
                                      //
                                      //                                 wishlistRepo(productId: filterProductCategoryController.filterDataModel.value.data![index].id.toString(),id: ''
                                      //                                 ).then((value){
                                      //                                   if(value.status==true){
                                      //                                     showToast(value.message);
                                      //                                     controller.getData();
                                      //                                   }
                                      //                                 });
                                      //                               },
                                      //                               child:
                                      //                               filterProductCategoryController.filterDataModel.value.data![index].wishlist! ?
                                      //                               Container(
                                      //                                   height: 23,
                                      //                                   decoration:
                                      //                                   const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                      //                                   child: const Padding(
                                      //                                       padding: EdgeInsets.only(left: 10, right: 10, top: 3),
                                      //                                       child: Icon(
                                      //                                         Icons.favorite,
                                      //                                         color: Color(0xFF7ED957),
                                      //                                         size: 16,
                                      //
                                      //                                       )
                                      //
                                      //                                   )):
                                      //                               Container(
                                      //                                   height: 20,
                                      //                                   decoration:
                                      //                                   const BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                                      //                                   child: const Padding(
                                      //                                       padding: EdgeInsets.only(left: 10, right: 10, top: 3),
                                      //                                       child: Icon(
                                      //                                         Icons.favorite_outline,
                                      //                                         color: Color(0xFF54C523),
                                      //                                         size: 16,
                                      //                                         // color: Color(0xFF7ED957),
                                      //                                         // color: Colors.red,
                                      //                                       )
                                      //
                                      //                                   )),
                                      //                             )
                                      //                         ),
                                      //                       ],
                                      //                     ),
                                      //                     addWidth(10),
                                      //                     Expanded(
                                      //                       child: Column(
                                      //                         crossAxisAlignment: CrossAxisAlignment.start,
                                      //                         children: [
                                      //                           Row(
                                      //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //                             children: [
                                      //                               Expanded(
                                      //                                 child: Text(
                                      //                                   filterProductCategoryController.filterDataModel.value.data![index].name
                                      //                                       .toString()
                                      //                                       .replaceAll('homemady product test1284sdf', 'Test').capitalizeFirst.toString(),
                                      //                                   style: GoogleFonts.poppins(
                                      //                                       fontWeight: FontWeight.w700,
                                      //                                       fontSize: 14,
                                      //                                       color: const Color(0xFF21283D)),
                                      //                                   maxLines: 2,
                                      //                                 ),
                                      //                               ),
                                      //                               // const Spacer(),
                                      //                               Text(
                                      //                                 '€ ${filterProductCategoryController.filterDataModel.value.data![index].price.toString()}',
                                      //                                 style: GoogleFonts.poppins(
                                      //                                     fontWeight: FontWeight.w700,
                                      //                                     fontSize: 15,
                                      //                                     color: const Color(0xFF70CC49)),
                                      //                               ),
                                      //                             ],
                                      //                           ),
                                      //                           addHeight(3),
                                      //                           filterProductCategoryController.filterDataModel.value.data![index].exclude == true ?
                                      //                           Row(
                                      //                             children: [
                                      //                               Text(
                                      //                                 ' ${(filterProductCategoryController.filterDataModel.value.data![index].subTitle ?? '').toString().capitalizeFirst}',
                                      //                                 style: GoogleFonts.poppins(
                                      //                                     fontWeight: FontWeight.w500, fontSize: 11, color: const Color(0xFF364A4F)),
                                      //                               ),
                                      //                               Text(
                                      //                                 'Out of Stock',
                                      //                                 style: GoogleFonts.poppins(
                                      //                                     fontWeight: FontWeight.w500, fontSize: 11, color: Colors.red),
                                      //                               ),
                                      //                             ],
                                      //                           ): Text(
                                      //                             ' ${(filterProductCategoryController.filterDataModel.value.data![index].subTitle ?? '').toString().capitalizeFirst}',
                                      //                             style: GoogleFonts.poppins(
                                      //                                 fontWeight: FontWeight.w500, fontSize: 11, color: const Color(0xFF364A4F)),
                                      //                           ),
                                      //                           addHeight(3),
                                      //                           Row(
                                      //                             children: [
                                      //                               Text(
                                      //                                 'Size: ${(filterProductCategoryController.filterDataModel.value.data![index].sizeQuantity ?? '').toString().capitalizeFirst}',
                                      //                                 style: GoogleFonts.poppins(
                                      //                                     fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                      //                               ),
                                      //                               const SizedBox(width: 3),
                                      //                               Text(
                                      //                                 filterProductCategoryController.filterDataModel.value.data![index].sizeId ?? ''.toString(),
                                      //                                 style: GoogleFonts.poppins(
                                      //                                     fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                      //                               ),
                                      //                             ],
                                      //                           ),
                                      //                           addHeight(3),
                                      //                           Row(
                                      //                             children: [
                                      //                               Text(
                                      //                                 'Spiciness :',
                                      //                                 style: GoogleFonts.poppins(
                                      //                                     fontWeight: FontWeight.w500,
                                      //                                     fontSize: 10,
                                      //                                     color: const Color(0xFF1F2D30)),
                                      //                               ),
                                      //                               addWidth(4),
                                      //                               Expanded(
                                      //                                 child: Text(
                                      //                                     filterProductCategoryController.filterDataModel.value.data![index].spiciness ?? ''.toString(),
                                      //                                   style: GoogleFonts.poppins(
                                      //                                       fontWeight: FontWeight.w500,
                                      //                                       fontSize: 10,
                                      //                                       color: const Color(0xFF6CC844)),
                                      //                                 ),
                                      //                               ),
                                      //                             ],
                                      //                           ),
                                      //                           addHeight(4),
                                      //                           Row(
                                      //                             children: [
                                      //                               Text(
                                      //                                 'Allergens :',
                                      //                                 style: GoogleFonts.poppins(
                                      //                                     fontWeight: FontWeight.w500,
                                      //                                     fontSize: 10,
                                      //                                     color: const Color(0xFF1F2D30)),
                                      //                               ),
                                      //                               addWidth(4),
                                      //                               Expanded(
                                      //                                 child: Text(
                                      //                                     filterProductCategoryController.filterDataModel.value.data![index].allergens ?? ''.toString(),
                                      //                                   style: GoogleFonts.poppins(
                                      //                                       fontWeight: FontWeight.w500,
                                      //                                       fontSize: 10,
                                      //                                       color: const Color(0xFF6CC844)),
                                      //                                 ),
                                      //                               ),
                                      //                             ],
                                      //                           ),
                                      //                           addHeight(4),
                                      //                           IntrinsicHeight(
                                      //                             child: Row(
                                      //                               children: [
                                      //                                 InkWell(
                                      //                                   onTap: () {
                                      //                                     if (cartListController.model.value.data!.cartItems!
                                      //                                         .map((e) => e.productId.toString())
                                      //                                         .toList()
                                      //                                         .contains(productID) &&
                                      //                                         product.productCount == 1) {
                                      //                                       print("sssssssssssssssssssssssss");
                                      //                                       print("sssssssssssssssssssssssss${cartListController.model.value.data!.cartItems!
                                      //                                           .map((e) => e.productId.toString())
                                      //                                           .toList()}");
                                      //                                       String gg = (cartListController.model.value.data!.cartItems!.firstWhere((element) =>
                                      //                                       element.productId.toString() == productID,orElse: ()=> CartItems()).id ?? "").toString();
                                      //                                       if(gg.isEmpty)return;
                                      //                                       removeCartItemRepo(cart_item_id: gg,context: context).then((value) {
                                      //                                         if(value.status == true){
                                      //                                           cartListController.getData().then((value) {
                                      //                                             setState(() {});
                                      //                                           });
                                      //                                         }
                                      //                                       });
                                      //                                     } else {
                                      //                                       addToCartRepo(
                                      //                                           product_id: filterProductCategoryController.filterDataModel.value.data![index].id
                                      //                                               .toString(),
                                      //                                           qty: product.productCount -1,
                                      //                                           //controller.model.value.data!.latestProducts![index].buttonCount.value,
                                      //                                           context: context)
                                      //                                           .then((value1) {
                                      //                                         if (value1.status == true) {
                                      //                                           filterProductCategoryController.filterDataModel.value.data![index].value = true;
                                      //                                           // controller.model.value.data!.latestProducts![index].buttonCount.value--;
                                      //                                           showToast(value1.message.toString());
                                      //                                           // controller.decreaseQty();
                                      //                                           cartListController.getData();
                                      //                                         }
                                      //                                       });
                                      //                                       cartListController.getData().then((value) {
                                      //                                         setState(() {});
                                      //                                       });
                                      //                                     }
                                      //                                   },
                                      //                                   child: Container(
                                      //                                     decoration: BoxDecoration(
                                      //                                         border: Border.all(color: const Color(0xFF72CD4A)),
                                      //                                         shape: BoxShape.circle),
                                      //                                     alignment: Alignment.center,
                                      //                                     child: const Padding(
                                      //                                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      //                                       child: Text(
                                      //                                         '-',
                                      //                                         style: TextStyle(
                                      //                                             fontWeight: FontWeight.w600,
                                      //                                             fontSize: 16,
                                      //                                             color: Color(0xFF72CD4A)),
                                      //                                         textAlign: TextAlign.center,
                                      //                                       ),
                                      //                                     ),
                                      //                                   ),
                                      //                                 ),
                                      //                                 Container(
                                      //                                   alignment: Alignment.center,
                                      //                                   child: Padding(
                                      //                                     padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                                      //                                     child: Text(product.productCount.toString()
                                      //                                       // controller.model.value.data!.latestProducts![index].buttonCount.value
                                      //                                       //     .toString(),
                                      //                                     ),
                                      //                                   ),
                                      //                                 ),
                                      //                                 InkWell(
                                      //                                   onTap: () {
                                      //                                     // buttonCount.value++;
                                      //                                     if( product.productCount < int.parse(filterProductCategoryController.filterDataModel.value.data![index].qty.toString())){
                                      //                                       filterProductCategoryController.filterDataModel.value.data![index].exclude == true ? const SizedBox() :
                                      //                                       addToCartRepo(
                                      //                                           product_id: filterProductCategoryController.filterDataModel.value.data![index].id
                                      //                                               .toString(),
                                      //                                           qty: product.productCount+1,
                                      //                                           //controller.model.value.data!.latestProducts![index].buttonCount.value,
                                      //                                           context: context)
                                      //                                           .then((value1) {
                                      //                                         if (value1.status == true) {
                                      //                                           filterProductCategoryController.filterDataModel.value.data![index].value = true;
                                      //                                           // controller.model.value.data!.latestProducts![index].buttonCount.value++;
                                      //                                           showToast(value1.message.toString());
                                      //                                           // controller.increaseQty();
                                      //                                           cartListController.getData().then((value) {
                                      //                                             setState(() {});
                                      //                                           });
                                      //                                         }
                                      //                                       });
                                      //                                     }
                                      //                                     else{
                                      //                                       showToast('You reached the maximum Limit of product');
                                      //                                     }
                                      //                                   },
                                      //                                   child: Container(
                                      //                                     decoration: BoxDecoration(
                                      //                                         color: const Color(0xFF72CD4A),
                                      //                                         border: Border.all(color: const Color(0xFF72CD4A)),
                                      //                                         shape: BoxShape.circle),
                                      //                                     alignment: Alignment.center,
                                      //                                     child: const Padding(
                                      //                                       padding: EdgeInsets.symmetric(horizontal: 8),
                                      //                                       child: Text(
                                      //                                         '+',
                                      //                                         style: TextStyle(
                                      //                                             fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
                                      //                                         textAlign: TextAlign.center,
                                      //                                       ),
                                      //                                     ),
                                      //                                   ),
                                      //                                 ),
                                      //                               ],
                                      //                             ),
                                      //                           ),
                                      //                         ],
                                      //                       ),
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //                 addHeight(5),
                                      //                 Container(
                                      //                   margin: EdgeInsets.only(left: 82),
                                      //                   color: Color(0xFFE9E9E9),
                                      //                   width: AddSize.screenWidth,
                                      //                   height: 1,
                                      //                 ),
                                      //                 addHeight(7),
                                      //                 Row(
                                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                                      //                   mainAxisAlignment: MainAxisAlignment.start,
                                      //                   children: [
                                      //                     addWidth(80),
                                      //                     Image.asset(
                                      //                       'assets/images/helpimg.png',
                                      //                       height: 13,
                                      //                     ),
                                      //                     addWidth(4),
                                      //                     Expanded(
                                      //                       child: Text(
                                      //                         'Can cook more units by: 30th June 2023',
                                      //                         style: GoogleFonts.poppins(
                                      //                             fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                      //                       ),
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //                 // addHeight(4),
                                      //                 // Row(
                                      //                 //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //                 //   mainAxisAlignment: MainAxisAlignment.start,
                                      //                 //   children: [
                                      //                 //     addWidth(80),
                                      //                 //     Image.asset(
                                      //                 //       'assets/images/helpimg.png',
                                      //                 //       height: 13,
                                      //                 //     ),
                                      //                 //     addWidth(4),
                                      //                 //     Text(
                                      //                 //       'How long it takes to cook: ',
                                      //                 //       style: GoogleFonts.poppins(
                                      //                 //           fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                      //                 //     ),
                                      //                 //     Text(
                                      //                 //       '${filterProductCategoryController.filterDataModel.value.data![index].cookUnitDays ?? '5'.toString()}',
                                      //                 //       style: GoogleFonts.poppins(
                                      //                 //           fontWeight: FontWeight.w500, fontSize: 11, color: const Color(0xFF364A4F)),
                                      //                 //     ),
                                      //                 //   ],
                                      //                 // ),
                                      //                 addHeight(4),
                                      //                 Row(
                                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                                      //                   mainAxisAlignment: MainAxisAlignment.start,
                                      //                   children: [
                                      //                     addWidth(80),
                                      //                     Image.asset(
                                      //                       'assets/images/helpimg.png',
                                      //                       height: 13,
                                      //                     ),
                                      //                     addWidth(4),
                                      //                     Text(
                                      //                       'Available Stock: ',
                                      //                       style: GoogleFonts.poppins(
                                      //                           fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                      //                     ),
                                      //                     filterProductCategoryController.filterDataModel.value.data![index].exclude == true ?
                                      //                     Text(
                                      //                       '0 Units',
                                      //                       style: GoogleFonts.poppins(
                                      //                           fontWeight: FontWeight.w500, fontSize: 11, color: const Color(0xFF364A4F)),
                                      //                     ):Text(
                                      //                       '${filterProductCategoryController.filterDataModel.value.data![index].qty ?? '5'.toString()} Units',
                                      //                       style: GoogleFonts.poppins(
                                      //                           fontWeight: FontWeight.w500, fontSize: 11, color: const Color(0xFF364A4F)),
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         addHeight(10)
                                      //       ],
                                      //     );
                                      //   },
                                      // ),
                                    ),
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      ],
                    )) :  const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Center(child: Text('No Cooks available',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black),)),
            ): const Center(child: CircularProgressIndicator())
           ,
          );
        }),
        bottomNavigationBar:
    myCartController.isDataLoading.value && myCartController.model.value.data!.cartItems!.isNotEmpty
        ? addCartSection()
        : null,
    );
  }

  showUploadWindow(List category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              right: 35,
              top: 37,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 80,
                  decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                  child: GestureDetector(
                    child: const Icon(Icons.clear),
                    onTap: () {
                      Get.back();
                    },
                  )),
            ),
            Dialog(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AddSize.padding16,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          "Cuisine:",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: const Color(0xFF425159),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Chinese',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                color: const Color(0xFF425159),
                              ),
                            ),
                            Obx(() {
                              return Checkbox(
                                  side: const BorderSide(color: Colors.black, width: 2),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                                  value: _isValue1.value,
                                  onChanged: (value) {
                                    setState(() {
                                      _isValue1.value = value!;
                                    });
                                  });
                            })
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Vegetarian',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                color: const Color(0xFF425159),
                              ),
                            ),
                            Obx(() {
                              return Checkbox(
                                  side: const BorderSide(color: Colors.black, width: 2),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                                  value: _isValue2.value,
                                  onChanged: (value) {
                                    setState(() {
                                      _isValue2.value = value!;
                                    });
                                  });
                            })
                          ],
                        ),
                        Text(
                          "Dietary:",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: const Color(0xFF425159),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: category.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext, index) {
                              return InkWell(
                                // onTap: () {
                                //   homeController.filterCategoryId.value =
                                //       categoryController.categoryModel.value.data!.category![index].id.toString();
                                //   print("Filter Category Id is.  ${homeController.filterCategoryId}");
                                //   // Get.toNamed(MyRouters.homeDetailsScreen);
                                // },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          category[index].name.toString(),
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: const Color(0xFF425159),
                                          ),
                                        ),
                                        // Obx(() {
                                        //   return Checkbox(
                                        //       side: const BorderSide(color: Colors.black, width: 2),
                                        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                                        //       value: categoryController
                                        //           .categoryModel.value.data!.category![index].isChecked.value,
                                        //       onChanged: (value) {
                                        //         setState(() {
                                        //           categoryController
                                        //               .categoryModel.value.data!.category![index].isChecked.value =
                                        //           !categoryController
                                        //               .categoryModel.value.data!.category![index].isChecked.value;
                                        //           if (categoryController
                                        //               .categoryModel.value.data!.category![index].isChecked.value ==
                                        //               true) {
                                        //             categoryController.categoryModel.value.data!.selectedContacts!.add(
                                        //                 categoryController.categoryModel.value.data!.category![index]);
                                        //             // kk.value = index;
                                        //             print(index);
                                        //           } else if (categoryController
                                        //               .categoryModel.value.data!.category![index].isChecked.value ==
                                        //               false) {
                                        //             categoryController.categoryModel.value.data!.selectedContacts!
                                        //                 .removeWhere((element) =>
                                        //             element.id ==
                                        //                 categoryController
                                        //                     .categoryModel.value.data!.category![index].id);
                                        //           }
                                        //         });
                                        //       });
                                        // })
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),

                        Center(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  child: const Text("Filter"),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              )),
                        )

                        // SizedBox(height: 15,),
                      ]),
                    ),
                  )),
            ),
          ],
        );
      },
    );
  }

// filter category product
  Future<void> _showSimpleDialog1() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            children: [
              Positioned(
                right: 35,
                top: 170,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 80,
                    decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                    child: GestureDetector(
                      child: const Icon(Icons.clear),
                      onTap: () {
                        Get.back();
                      },
                    )),
              ),
              Dialog(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Sort By:",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: productCategory.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext, index) {
                            return InkWell(
                              onTap: () {
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      productCategory[index],
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18,
                                        color: const Color(0xFF425159),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 7,
                      ),
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                child: const Text("Filter"),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            )),
                      )

                      // SizedBox(height: 15,),
                    ]),
                  ),
                ),
              ),
            ],
          );
        });
  }

}
