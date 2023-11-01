import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/subscription_list_controller.dart';
import '../routers/routers.dart';
import '../widgets/dimenestion.dart';

class ThankYouScreen2 extends StatefulWidget {
  const ThankYouScreen2({Key? key}) : super(key: key);
  static var thankYouScreen2 = '/thankYouScreen2';
  @override
  State<ThankYouScreen2> createState() => _ThankYouScreen2State();
}

class _ThankYouScreen2State extends State<ThankYouScreen2> {

  final controller = Get.put(SubscriptionListController());

  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.padding16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AddSize.size45,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Image(
                    height: AddSize.size300,
                    width: double.maxFinite,
                    image:  const AssetImage('assets/images/thn.png'),
                    fit: BoxFit.contain,
                    opacity: const AlwaysStoppedAnimation(.80),
                  ),
                ),
                // Lottie.network(
                //     'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),
                SizedBox(
                  height: AddSize.size30,
                ),
                Text('Thank You!',
                  style: GoogleFonts.ramaraja(
                    fontSize: 65,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF423E5E),
                  ),
                ),

                controller.model.value.data![0].status == "Active" ?
                Text('You are already subscribed',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF5E6F71),
                  ),
                ):
                Text('Your Subscription Plan Purchased\n Successfully',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF5E6F71),
                  ),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                // Text(
                //   "Admin will verify and update you by\ncall or email".tr,
                //   textAlign: TextAlign.center,
                //   style: Theme.of(context).textTheme.headline5!.copyWith(
                //       fontWeight: FontWeight.w300,
                //       fontSize: AddSize.font14,
                //       color: Color(0xff596774)),
                // ),
                SizedBox(
                  height: AddSize.size10,
                ),
              ],
            ),
          )),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AddSize.padding16, vertical: AddSize.size40),
        child: ElevatedButton(
            onPressed: () {
              Get.offAllNamed(MyRouters.bottomNavbar);
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.maxFinite, 60),
                backgroundColor: const Color(0xff7ED957),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AddSize.size10)),
                textStyle: TextStyle(
                    fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
            child: Text(
              "Go To Home",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22),
            )),
      ),
    );
  }
}
