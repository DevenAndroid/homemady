import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/myorderScreens/activeScreen.dart';
import 'package:homemady/myorderScreens/cancelledScreen.dart';
import 'package:homemady/myorderScreens/completeScreen.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';

import '../controller/my_order_controller.dart';


class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>  with TickerProviderStateMixin{
  RxBool isSelect = false.obs;
  late TabController tabController;
  final controller = Get.put(MyOrderController());
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    controller.getData();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: 'My Orders', context: context),
      body: Column(
        children: [
           addHeight(20),
          Stack(
            children: [
              Positioned.fill(
                  bottom: 2,
                  child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom:
                          BorderSide(color: Color(0xFFD9D9D9), width: 1.0),
                        ),
                      ))),
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: const Color(0xff7ED957),
                physics: const BouncingScrollPhysics(),
                labelStyle: const TextStyle(
                    color: Color(0xff7ED957),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                controller: tabController,
                unselectedLabelColor: const Color(0xFF9B9B9B),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3.0,
                    color: Color(0xff7ED957),
                  ),
                ),
                tabs: const [
                  Tab(
                   text: '   Active   ',
                  ),
                  Tab(
                   text: '  Completed  ',
                  ),
                  Tab(
                   text: '  Cancelled  ',
                  ),

                ],
              ),
            ],
          ),
          addHeight(20),
          Expanded(
            child: TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: tabController,
                children: const[
                  ActiveScreen(),
                  CompleteScreen(),
                  CancelledScreen()
            ]),
          )
        ],
      ),
    );
  }
}
