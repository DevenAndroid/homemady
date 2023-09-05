import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/resources/add_text.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/app_theme.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';

import '../controller/my_cart_controller.dart';
import '../repository/remove_cartitem_repo.dart';
import '../repository/tip_repo.dart';
import '../repository/update_cart_repo.dart';
import '../widgets/dimenestion.dart';
import '../widgets/editprofiletextfiled.dart';


class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final controller = Get.put(MyCartListController());
  final TextEditingController tipController=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  RxBool customTip = false.obs;
  RxString selectedChip = "".obs;
  final List<String> tips = ["1", "2", "5", "Custom"];
  String getColor = '0xFF#F1F1F1';
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
      var height= MediaQuery.of(context).size.height;
      var width= MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(title: 'My Cart', context: context),
        body: controller.isDataLoading.value ? controller.model.value.data!.cartItems!.isNotEmpty ?
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:

            Column(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Expanded(
                                          child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Row(
                                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text((controller.model.value.data!.cartItems![index].name!.isEmpty ? 'Test' : controller.model.value.data!.cartItems![index].name).toString().capitalizeFirst.toString(),
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 16,
                                                          color: const Color(0xFF21283D)
                                                      ),),
                                                  ),
                                                   SizedBox(width: width * .25,),
                                                  IntrinsicHeight(
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            if(controller
                                                                .model.value
                                                                .data!
                                                                .cartItems![index]
                                                                .cartItemQty == 1){
                                                              removeCartItemRepo(cart_item_id: controller
                                                                  .model.value
                                                                  .data!
                                                                  .cartItems![index]
                                                                  .id
                                                                  .toString(),context: context).then((value) {
                                                                if(value.status == true){
                                                                  controller.getData().then((value) {
                                                                    setState(() {});
                                                                  });
                                                                }
                                                              });
                                                            }
                                                            else {
                                                              updateCartRepo(
                                                                  controller
                                                                      .model.value
                                                                      .data!
                                                                      .cartItems![index]
                                                                      .id
                                                                      .toString(),
                                                                  int.parse(
                                                                      (controller
                                                                          .model
                                                                          .value
                                                                          .data!
                                                                          .cartItems![index]
                                                                          .cartItemQty ??
                                                                          "")
                                                                          .toString()) -
                                                                      1, context)
                                                                  .then((value1) {
                                                                if (value1.status == true) {
                                                                  showToast(value1.message.toString());
                                                                  controller.getData();
                                                                }
                                                                else {
                                                                  showToast(value1.message);
                                                                }
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
                                                            child: Text(controller
                                                                .model.value.data!.cartItems![index].cartItemQty.toString()
                                                              // controller.model.value.data!.latestProducts![index].buttonCount.value
                                                              //     .toString(),
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            // buttonCount.value++;
                                                            updateCartRepo(
                                                                controller
                                                                    .model.value
                                                                    .data!
                                                                    .cartItems![index]
                                                                    .id
                                                                    .toString(),
                                                                int.parse(
                                                                    (controller
                                                                        .model
                                                                        .value
                                                                        .data!
                                                                        .cartItems![index]
                                                                        .cartItemQty ??
                                                                        "")
                                                                        .toString()) +
                                                                    1, context)
                                                                .then((value1) {
                                                              if (value1.status == true) {
                                                                showToast(value1.message.toString());
                                                                controller.getData().then((value) {
                                                                  setState(() {});
                                                                });
                                                              }
                                                            });
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
                                              // addHeight(3),
                                              Text(controller.model.value.data!.cartItems![index].subTitle.toString().capitalizeFirst.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: const Color(0xFF486769).withOpacity(0.70)
                                                ),),
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
                                          ),
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
                        addHeight(10),
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
                                height: 22,
                                width:  22,
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                decoration:
                                BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: const Color(0xFFF1F1F1)

                                ),

                              child: Theme(
                                data: ThemeData(
                                  unselectedWidgetColor: Colors.transparent
                                ),
                                child: Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2)
                                  ),
                                  value: index < int.parse(controller.model.value.data!.cartPaymentSummary!.orderCount.toString())+1,
                                  checkColor: Colors.white,
                                  activeColor: const Color(0xff7ED957),
                                  onChanged: (value){
                                  },

                                ),
                              ),
                            ),
                          );
                        })),
                        SizedBox(
                          height: height * .01,
                        ),
                        addHeight(20),

                      ],

                    )

                  ),
                ),
                addHeight(10),

                Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * .03,
                        vertical: height * .02,
                      ),
                      child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tip your delivery partner",
                                style: TextStyle(
                                    color: const Color(0xff423E5E),
                                    fontSize: AddSize.font10 * 1.7,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: height * .01,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      "Thank your delivery partner by leaving them a tip 100% of the tip will go your delivery partner.",
                                      style: TextStyle(
                                          color:
                                          AppTheme.blackcolor,
                                          fontSize: AddSize.font14,
                                          fontWeight:
                                          FontWeight.w300)),
                                ),
                                controller
                                    .model
                                    .value
                                    .data!
                                    .cartPaymentSummary!
                                    .tipAmount !=
                                    0
                                    ? Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "€${controller.model.value.data!.cartPaymentSummary!.tipAmount}",
                                        style: TextStyle(
                                            color: AppTheme
                                                .blackcolor,
                                            fontSize: AddSize
                                                .font14,
                                            fontWeight:
                                            FontWeight
                                                .w500)),
                                    TextButton(
                                        onPressed: () {
                                          removeTip(
                                              context:
                                              context)
                                              .then((value) {
                                            showToast(value
                                                .message
                                                .toString());
                                            if (value
                                                .status ==
                                                true) {
                                              controller
                                                  .getData();
                                              selectedChip
                                                  .value = "";
                                            }
                                          });
                                        },
                                        child: Text("Clear",
                                            style: TextStyle(
                                                color: Color(0xff7ED957),
                                                fontSize:
                                                AddSize
                                                    .font14,
                                                fontWeight:
                                                FontWeight
                                                    .w500)))
                                  ],
                                )
                                    : const SizedBox()
                              ],
                            ),
                            SizedBox(
                              height: height * .01,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                tips.length,
                                    (index) => chipList(tips[index]),
                              ),
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            if (customTip.value)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: AddSize.width100 * 2.5,
                                    child:
                                    EditProfileTextFieldWidget(
                                      keyboardType:
                                      TextInputType.number,
                                      hint: "€ Enter tip amount",
                                      controller: tipController,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                            'Tip is required')
                                      ]),
                                      suffix: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            color:  Color(0xff7ED957),
                                          )),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          orderTip(
                                              tipAmount:
                                              tipController
                                                  .text,
                                              context: context)
                                              .then((value) {
                                            showToast(
                                                value.message);
                                            if (value.status ==
                                                true) {
                                              controller
                                                  .getData();
                                              tipController.clear();
                                              customTip.value = false;
                                            }
                                          });
                                        }
                                      },
                                      child: Text("Add",
                                          style: TextStyle(
                                              color:  Color(0xff7ED957),
                                              fontSize:
                                              AddSize.font16,
                                              fontWeight:
                                              FontWeight.w500)))
                                ],
                              )
                          ],
                        );
                      }),
                    )),

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
                              Text( '€ ${controller.model.value.data!.cartPaymentSummary!.subTotal.toString()}',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff486769)
                                ),),
                            ],
                          ),
                        ),
                        controller
                            .model
                            .value
                            .data!
                            .cartPaymentSummary!
                            .tipAmount ==
                            0
                            ? const SizedBox():
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,10,14,0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Tip for Delivery Partner:',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1A2E33)
                                ),),
                              Spacer(),
                              Text(

                                '€ ${controller.model.value.data!.cartPaymentSummary!.tipAmount.toString()}',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff486769)
                                ),),
                            ],
                          ),
                        ),
                        controller.model.value.data!.cartPaymentSummary!.minOrderCharge !=0 ?
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,10,14,0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Small Order fee:',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1A2E33)
                                ),),
                              Spacer(),
                              Text( '€ ${controller.model.value.data!.cartPaymentSummary!.minOrderCharge.toString()}',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff486769)
                                ),),
                            ],
                          ),
                        ):SizedBox(),
                        controller.model.value.data!.cartPaymentSummary!.serviceCharge != 0 ?
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,10,14,0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Service charge:',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1A2E33)
                                ),),
                              Spacer(),
                              Text(

                                '€ ${controller.model.value.data!.cartPaymentSummary!.serviceCharge.toString()}',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff486769)
                                ),),
                            ],
                          ),
                        ): SizedBox(),
                        controller.model.value.data!.cartPaymentSummary!.deliveryCharge != 0 ?
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
                              Text( '€ ${controller.model.value.data!.cartPaymentSummary!.deliveryCharge.toString()}',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff486769)
                                ),),
                            ],
                          ),
                        ):SizedBox(),
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
                              Text( '€ ${controller.model.value.data!.cartPaymentSummary!.total.toString()}',
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
                    Get.toNamed(MyRouters.checkOutScreen,);
                  },),
                ),

                addHeight(20),
              ],
            )
          ),
        ):
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              SizedBox(height: 60,),
              Image.asset('assets/images/emptyCartImg.png'),
              SizedBox(height: 10,),
              const Text("No Product",style: TextStyle(fontWeight: FontWeight.w700,color: Color(0xff000000),fontSize: 22),),
            ],
          ),
        ) :Center(child: CircularProgressIndicator()),
      );
    });

  }
  chipList(
      title,
      ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return GestureDetector(
        onTap: () {},
        child: ChoiceChip(
          padding: EdgeInsets.symmetric(
              horizontal: width * .01, vertical: height * .01),
          backgroundColor: AppTheme.backgroundcolor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: title != selectedChip.value
                      ? Colors.grey.shade300
                      : const Color(0xff7ED957))),
          label: Text(title == "Custom" ? "$title" : "€$title",
              style: TextStyle(
                  color: title != selectedChip.value
                      ? Colors.grey.shade600
                      : Colors.white,
                  fontSize: AddSize.font14,
                  fontWeight: FontWeight.w500)),
          selected: title == selectedChip.value,
          selectedColor: const Color(0xff7ED957),
          onSelected: (value) {
            selectedChip.value = title;
            if (title == "Custom") {
              customTip.value = true;
              tipController.text = "";
              print(tipController.text);
            } else {
              customTip.value = false;
              tipController.text = title;
              print(tipController.text);
            }
            tipController.text != ""
                ? orderTip(tipAmount: tipController.text, context: context)
                .then((value) {
              showToast(value.message);
              if (value.status == true) {
                controller.getData();
              }
            })
                : null;
            setState(() {});
          },
        ),
      );
    });
  }
}
