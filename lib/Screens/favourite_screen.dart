import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';

import '../controller/favorite_controller.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  RxBool isSelect1 = false.obs;
  RxBool isSelect = false.obs;
  final controller = FavoriteListController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.get();
  }
  @override
  Widget build(BuildContext context) {
    return
      Obx(() {
      return
        Scaffold(
        appBar: backAppBar(title: 'My Favorites', context: context),
        body:
            SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              isSelect1.value = !isSelect1.value;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15.0,
                                  horizontal: 8.0),
                              decoration: isSelect1.value == true ? BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF717171), width: 1),
                                  borderRadius: BorderRadius.circular(4)
                              ) : BoxDecoration(
                                  color: const Color(0xFF7ED957),
                                  borderRadius: BorderRadius.circular(4)
                              ) ,
                              child: Center(
                                  child: isSelect1.value == true ?
                                  const Text('Cooks',
                                    style: TextStyle(
                                      color: Color(0xFF717171),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),)  :
                                  const Text('Cooks',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),)

                              ),
                            ),
                          )
                      ),
                      addWidth(26),
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              isSelect1.value = !isSelect1.value;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15.0,
                                  horizontal: 8.0),
                              decoration: isSelect1.value == true ? BoxDecoration(
                                  color: const Color(0xFF7ED957),
                                  borderRadius: BorderRadius.circular(4))
                                  : BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF717171), width: 1),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                  child: isSelect1.value == true ?
                                  const Text('Meals',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),) :   const Text('Meals',
                                    style: TextStyle(
                                      color: Color(0xFF717171),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ),
                          )
                      ),
                    ],
                  ),
                  addHeight(20),
                  isSelect1.value == true ?
                  controller.isDataLoading.value ?
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.model.value.data!.store!.length,
                    physics: const BouncingScrollPhysics(),
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
                                        Get.toNamed(MyRouters.homeDetailsScreen);
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Image.asset(
                                              'assets/images/Rectangle 2171.png'),
                                          addHeight(6),
                                          Text(controller.model.value.data!.store![index].name.toString(),
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
                                                color: const Color(0xFF04666E),),
                                              addWidth(10),
                                              Text('Delivery Only 25 mins',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: const Color(0xFF606573)
                                                ),),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 80,
                                      // bottom: 0,
                                      left: 20,
                                      right: 20,
                                      //   bottom: 0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: const [
                                          Icon(Icons.arrow_back_ios,
                                            color: Colors.white,size: 20,),
                                          Icon(Icons.arrow_forward_ios,
                                            color: Colors.white,size: 20,)
                                        ],
                                      )
                                  ),
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
                                                    'assets/images/avtarImg.png'),
                                              )
                                          ),
                                          addHeight(3),
                                          Text(controller.model.value.data!.store![index].cookName.toString(),
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
                                              Text((controller.model.value.data!.store![index].rating ?? '3').toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11,
                                                    color: const Color(0xFF6A7080)
                                                ),),
                                              addWidth(5),
                                              Text('(${(controller.model.value.data!.store![index].countReviewData ?? '12').toString()})',
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
                                      // bottom: 0,
                                      // left: 290,
                                      right: 10,
                                      //   bottom: 0,

                                      child: Column(
                                        children: [
                                          Obx(() {
                                            return Container(
                                                height: 33,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(left: 10,
                                                      right: 10,
                                                      top: 3),
                                                  child: InkWell(
                                                    onTap: () {
                                                      isSelect.value = !isSelect.value;
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
                                                  ),
                                                )
                                            );
                                          }),
                                        ],
                                      )
                                  ),
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
                                              child: Image.asset('assets/images/topChef.png',width: 50,)),
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
                                                                padding: EdgeInsets.all(10),
                                                                height: 50,
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
                                              child: Image.asset('assets/images/topChef.png',width: 50,)),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,)
                        ],
                      );
                    },
                  ):
                  const Center(child: CircularProgressIndicator()) :

                  controller.isDataLoading.value ?
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.model.value.data!.store!.length,
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
                                          Get.toNamed(MyRouters.homeDetailsScreen);
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Image.asset(
                                                'assets/images/Rectangle 2171.png'),
                                            addHeight(6),
                                            Text(controller.model.value.data!.store![index].name.toString(),
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
                                                  color: const Color(0xFF04666E),),
                                                addWidth(10),
                                                Text('Delivery Only 25 mins',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: const Color(0xFF606573)
                                                  ),),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 80,
                                        // bottom: 0,
                                        left: 20,
                                        right: 20,
                                        //   bottom: 0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: const [
                                            Icon(Icons.arrow_back_ios,
                                              color: Colors.white,size: 20,),
                                            Icon(Icons.arrow_forward_ios,
                                              color: Colors.white,size: 20,)
                                          ],
                                        )
                                    ),
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
                                                      'assets/images/avtarImg.png'),
                                                )
                                            ),
                                            addHeight(3),
                                            Text(controller.model.value.data!.store![index].cookName.toString(),
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
                                                Text((controller.model.value.data!.store![index].rating ?? '3').toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 11,
                                                      color: const Color(0xFF6A7080)
                                                  ),),
                                                addWidth(3),
                                                Text((controller.model.value.data!.store![index].countReviewData ?? '10').toString(),
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
                                        // bottom: 0,
                                        // left: 290,
                                        right: 10,
                                        //   bottom: 0,

                                        child: Column(
                                          children: [
                                            Obx(() {
                                              return Container(
                                                  height: 33,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .only(left: 10,
                                                        right: 10,
                                                        top: 3),
                                                    child: InkWell(
                                                      onTap: () {
                                                        isSelect.value = !isSelect.value;
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
                                                    ),
                                                  )
                                              );
                                            }),
                                          ],
                                        )
                                    ),
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
                                                child: Image.asset('assets/images/topChef.png',width: 50,)),
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
                                                                  padding: EdgeInsets.all(10),
                                                                  height: 50,
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
                                                child: Image.asset('assets/images/topChef.png',width: 50,)),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15,)
                          ],
                        ),
                      );
                    },
                  ):
                  const Center(child: CircularProgressIndicator())
                ],
              ),
            ),
          ),
      //  }):const Center(child: CircularProgressIndicator()),
      );
    });
  }
}
