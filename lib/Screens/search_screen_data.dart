import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/filter_controller.dart';
import '../controller/homepage_controller.dart';
import '../controller/search_store_conbtroller.dart';
import '../resources/add_text.dart';
import '../routers/routers.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';

class SearchScreenData extends StatefulWidget {
  const SearchScreenData({Key? key}) : super(key: key);
  static var searchScreen = "/searchScreen";
  @override
  State<SearchScreenData> createState() => _SearchScreenDataState();
}

class _SearchScreenDataState extends State<SearchScreenData> {
  final controller = Get.put(HomePageController());
  final filterDataController = Get.put(FilterController());

  final searchController = Get.put(SearchStoreController());
  @override
  void initState() {
    super.initState();
    filterDataController.getFilterData().then((value){
      setState(() {});
    });
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   searchController.getSearchData();
    //   searchController.searchDataModel.value.data != null
    //       ? searchController.searchDataModel.value.data!.clear()
    //       : Container();
    // });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: const Color(0xffFFFFFF),
      appBar: backAppBar(title: "Stores", context: context),
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
              SizedBox(
                height: height * .07,
                child: TextField(
                  maxLines: 1,
                  controller: filterDataController.storeSearchController,
                  style: const TextStyle(fontSize: 17),
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {
                    filterDataController.getFilterData().then((value){
                      if (value.status == false) {
                        showToast("No data found");
                      }

                    });

                  },
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          filterDataController.getFilterData().then((value){
                            if (value.status == false) {
                              showToast("No data found");
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.search_rounded,
                          color: Color(0xff7ED957),
                          size: 30,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        // borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      fillColor: Colors.white,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: width * .04),
                      hintText: 'search store..',
                      hintStyle: TextStyle(
                          fontSize: AddSize.font14,
                          color: AppTheme.blackcolor,
                          fontWeight: FontWeight.w400)),
                ),
              ),

              filterDataController.filterModel.value.data != null && filterDataController.filterModel.value.data!.isNotEmpty
              // ? (searchController.searchDataModel.value.data != null && searchController.searchDataModel.value.data!.isNotEmpty)
                  ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                  itemCount: filterDataController.filterModel.value.data != null
                      ? filterDataController.filterModel.value.data!.length
                      : 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {

                        // Get.toNamed(StoreScreen
                        //     .singleStoreScreen);
                        // storeController
                        //     .storeId.value =
                        //     searchController.searchDataModel.value.data![index].id
                        //         .toString();
                      },
                      child:
                      Column(
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
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(MyRouters.homeDetailsScreen, arguments: [
                                          filterDataController.filterModel.value.data![index].id
                                              .toString()]);
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              imageUrl: filterDataController.filterModel.value.data![index].image
                                                  .toString(),
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
                                          // Image.asset(
                                          //     'assets/images/Rectangle 2171.png'),
                                          addHeight(6),
                                          Text(
                                            filterDataController.filterModel.value.data![index].name
                                                .toString()
                                                .capitalizeFirst!,
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
                                                'Delivery Only 25 mins',
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
                                   const Positioned(
                                      top: 80,
                                      // bottom: 0,
                                      left: 20,
                                      right: 20,
                                      //   bottom: 0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 20,
                                          )
                                        ],
                                      )),
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
                                                  shape: BoxShape.circle, color: Colors.white),
                                              child:
                                              SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(100),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                    filterDataController.isDataLoading ?
                                                    filterDataController.filterModel.value.data![index].profileImage.toString()
                                                        :
                                                    'assets/images/avtarImg.png',
                                                    // height: 40,
                                                    fit: BoxFit.cover,
                                                    // errorWidget: (-, --, ---)=>Image.asset('assets/images/avtarImg.png'),
                                                  ),

                                                ),
                                              ),
                                              // Padding(
                                              //   padding: const EdgeInsets.all(3),
                                              //   child: Image.asset('assets/images/avtarImg.png'),
                                              // )
                                          ),
                                          addHeight(3),
                                          Text(

                                            filterDataController.filterModel.value.data![index].cookName
                                                .toString(),
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
                                                (filterDataController.filterModel.value.data![index].distance??
                                                    '3')
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11,
                                                    color: const Color(0xFF6A7080)),
                                              ),
                                              addWidth(5),
                                              // Text(
                                              //   '(${(controller1.model.value.data!.store![index].countReviewData ?? '12').toString()})',
                                              //   style: GoogleFonts.poppins(
                                              //       fontWeight: FontWeight.w500,
                                              //       fontSize: 11,
                                              //       color: const Color(0xFF6A7080)),
                                              // ),
                                            ],
                                          )
                                        ],
                                      )),

                                  Positioned(
                                      top: 14,
                                      // bottom: 0,
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
                                                    barrierColor:
                                                    const Color(0xFF000000).withOpacity(0.58),
                                                    barrierLabel: MaterialLocalizations.of(context)
                                                        .modalBarrierDismissLabel,
                                                    pageBuilder: (BuildContext context, Animation first,
                                                        Animation second) {
                                                      return Stack(
                                                        children: [
                                                          Center(
                                                              child: Image.asset(
                                                                  'assets/images/dialogboximg.png')),
                                                          Positioned(
                                                            right: 18,
                                                            top: 30,
                                                            child: Container(
                                                                padding: EdgeInsets.all(10),
                                                                height: 80,
                                                                decoration: const BoxDecoration(
                                                                    color: Colors.white,
                                                                    shape: BoxShape.circle),
                                                                child: Icon(Icons.clear)),
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Image.asset(
                                                'assets/images/topChef.png',
                                                width: 50,
                                              )),
                                          InkWell(
                                              onTap: () {
                                                showGeneralDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    barrierColor:
                                                    const Color(0xFF000000).withOpacity(0.58),
                                                    barrierLabel: MaterialLocalizations.of(context)
                                                        .modalBarrierDismissLabel,
                                                    pageBuilder: (BuildContext context, Animation first,
                                                        Animation second) {
                                                      return Stack(
                                                        children: [
                                                          Center(
                                                              child: Image.asset(
                                                                  'assets/images/dialogboximg.png')),
                                                          Positioned(
                                                            right: 18,
                                                            top: 50,
                                                            child: Container(
                                                                padding: EdgeInsets.all(10),
                                                                height: 50,
                                                                decoration: const BoxDecoration(
                                                                    color: Colors.white,
                                                                    shape: BoxShape.circle),
                                                                child: Icon(Icons.clear)),
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Image.asset(
                                                'assets/images/topChef.png',
                                                width: 50,
                                              )),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    );
                  })
                  : Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    SizedBox(height: 60,),
                    Image.asset('assets/images/searchImage.png'),
                    SizedBox(height: 10,),
                    Text("Result Not Found",
                      style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,color: Color(0xff000000),fontSize: 22),),
                  ],
                ),
              ) ,

            ],
          ),
        ),
      ):Padding(
        padding: const EdgeInsets.all(45.0),
        child: Column(
          children: [
            SizedBox(height: 60,),
            FittedBox(child: Image.asset('assets/images/searchImage.png')),
            SizedBox(height: 10,),
            Text("Result Not Found",
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,color: const Color(0xff000000),fontSize: 22),),
          ],
        ),
      ),
    );
  }


}
