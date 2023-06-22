import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:intl/intl.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  RxBool isSelect = false.obs;
  int currentDrawer = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController dateOfBirthController = TextEditingController();
    return Scaffold(
      key: _scaffoldKey,
      drawer:Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 230,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                   gradient: LinearGradient(
                     colors: [
                       Color(0xFF7ED957),
                       Color(0xFF68C541),
                     ],
                   )
                ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/Ellipse 67.png',
                          height: 100,
                        ),
                        Text('Williams Jones',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w600,)),
                        Text('williamsjones@gmail.com',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w400,)),
                      ],
                    ),
                  )),
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              leading: Image.asset(
                'assets/images/note-2.png',
                height: 20,
              ),
              title:  Text('My Orders',
                  style: GoogleFonts.poppins(
                fontSize: 15,
                color: const Color(0xFF4F535E),
                fontWeight: FontWeight.w400,)),
              onTap: () {
                setState(() {
                  currentDrawer = 0;
                  Get.back();
                });
              },
            ),
           const Divider(
              height: 5,
              color: Color(0xffEFEFEF),
              thickness: 1,
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              leading: Image.asset(
                'assets/images/personImg.png',
                height: 20,
              ),
              title:  Text('My profile',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,)),
              onTap: () {
                setState(() {
                  currentDrawer = 1;
                  // Get.to(VendorOrderList());
                });
              },
            ),
           const Divider(
              height: 5,
              color: Color(0xffEFEFEF),
              thickness: 1,
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              leading: Image.asset(
                'assets/images/notification-img.png',
                height: 20,
              ),
              title:  Text('Notification',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,)),
              onTap: () {
                setState(() {
                  currentDrawer = 2;
                  // Get.to(VendorProductScreen());
                });
              },
            ),
            const Divider(
              height: 5,
              color: Color(0xffEFEFEF),
              thickness: 1,
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              leading: Image.asset(
                'assets/images/location-my.png',
                height: 20,
              ),
              title:  Text('My Address',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,)),
              onTap: () {
                setState(() {
                  currentDrawer = 3;
                  // Get.to(VendorDiscountScreen());
                });
              },
            ),
            const Divider(
              height: 5,
              color: Color(0xffEFEFEF),
              thickness: 1,
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              leading: Image.asset(
                'assets/images/notebook_reference.png',
                height: 20,
              ),
              title:  Text('Refer and Earn',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,)),
              onTap: () {
                setState(() {
                  currentDrawer = 4;
                  // Get.to(VendorNotificationScreen());
                });
              },
            ),
            const Divider(
              height: 5,
              color: Color(0xffEFEFEF),
              thickness: 1,
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              leading: Image.asset(
                'assets/images/bx_wallet.png',
                height: 20,
              ),
              title:  Text('My Wallet',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,)),
              onTap: () {
                setState(() {
                  currentDrawer = 5;
                  // Get.to(VendorAnalysticsScreen());
                });
              },
            ),
            const Divider(
              height: 5,
              color: Color(0xffEFEFEF),
              thickness: 1,
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              leading: Image.asset(
                'assets/images/metro-security.png',
                height: 20,
              ),
              title:  Text('Privacy Policy',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,)),
              onTap: () {
                setState(() {
                  currentDrawer = 6;
                  // Get.to(VendorHelpCenterScreen());
                });
              },
            ),
            const Divider(
              height: 5,
              color: Color(0xffEFEFEF),
              thickness: 1,
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              leading: Image.asset(
                'assets/images/chatchatting.png',
                height: 20,
              ),
              title:  Text('Message',
                    style: GoogleFonts.poppins(
                fontSize: 15,
                color: const Color(0xFF4F535E),
                fontWeight: FontWeight.w400,)),
              onTap: () {
                setState(() {
                  currentDrawer = 7;
                  // Get.to(SettingScreenVendor());
                });
              },
            ),
            const Divider(
              height: 5,
              color: Color(0xffEFEFEF),
              thickness: 1,
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              leading: Image.asset(
                'assets/images/logout.png',
                height: 16,
              ),
              title:  Text('Logout',
                    style: GoogleFonts.poppins(
                fontSize: 15,
                color: const Color(0xFF4F535E),
                fontWeight: FontWeight.w400,)),
              onTap: () {
                setState(() {
                  currentDrawer = 7;
                  // Get.to(SettingScreenVendor());
                });
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Image.asset('assets/images/avtarImg.png', height: 45,),
                    addWidth(6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address', style: GoogleFonts.poppins(
                          color: const Color(0xFF636869),
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),),
                        addHeight(3),
                        Row(
                          children: [
                            Image.asset('assets/images/location.png',
                              height: 13,),
                            addWidth(4),
                            Text('News Work City', style: GoogleFonts.poppins(
                              color: const Color(0xFF000000),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),),
                            addWidth(4),
                            Image.asset('assets/images/pencilImg.png',
                              height: 13,),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      child: Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF7ED957)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/shoppingImg.png',
                            height: 30,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.only(left: 19, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Hello',
                          style: GoogleFonts.poppins(
                              color: const Color(0xFF676767),
                              fontWeight: FontWeight.w300,
                              fontSize: 16
                          ),
                        ),
                        Text('Alexandra',
                          style: GoogleFonts.poppins(
                              color: const Color(0xFF353535),
                              fontWeight: FontWeight.w600,
                              fontSize: 22
                          ),
                        ),
                      ],
                    ),
                    addHeight(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: AddSize.screenWidth*.60,
                          height: 42,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: const Offset(.1, .1,
                                    ),
                                    blurRadius: 20.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                                color: Colors.white
                            ),
                            child: TextFormField(
                              onChanged: (value){
                                _showSimpleDialog2(context);
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior
                                    .never,
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(8),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                fillColor: Colors.black,
                                //focusColor: Colors.black,
                                labelText: 'Search',
                                labelStyle: const TextStyle(
                                    color: Color(0xFFABB1BA)),
                                prefixIcon: const Icon(Icons.search_rounded,
                                  color: Color(0xFFABB1BA), size: 18,),

                              ),
                              //suffix: Icon(Icons.search),
                              //hint: 'search',
                              // prefix: Icon(Icons.camera_alt_outlined),
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            _showSimpleDialog();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF7ED957)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/filterImg.png', height: 18,),
                            ),
                          ),
                        ),
                        addWidth(5),
                        InkWell(
                          onTap: () {
                            _showSimpleDialog1();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color(0xFF7ED957)
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/sort-descending.png',
                                height: 18,),

                            ),
                          ),
                        ),
                        addWidth(22)
                      ],
                    ),
                    addHeight(26),
                    SizedBox(
                      height: 144,
                      child: ListView.builder(
                        itemCount: 3,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                child: Image.asset('assets/images/slider.png'),
                              ),
                              addWidth(20)
                            ],
                          );
                        },
                      ),
                    ),
                    addHeight(14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {

                          },
                          child: Container(
                            height: 44,
                            width: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: const Color(0xFF7ED957)
                                )
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/images/clockImg.png', height: 18,),
                                ),
                                Text('Delivery Now',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF7ED957),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        addWidth(10),
                        InkWell(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                        primary: Color(0xFF7ED957),
                                        // header background color
                                        onPrimary: Colors.white,
                                        // header text color
                                        onSurface: Color(0xFF7ED957),// body text color
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: const Color(0xFF7ED957), // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },

                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime.now(),);

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd')
                                  .format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              setState(() {
                                dateOfBirthController.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                          child: Container(
                            height: 44,
                            width: 160,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.zero,
                                color: Color(0xFF7ED957)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/images/truckimg.png', height: 18,),
                                ),
                                Text('Pick a Date',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    addHeight(20),

                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
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
                                            Text('Burger King with Pizza',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
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
                                        top: 75,
                                        // bottom: 0,
                                        left: 18,
                                        right: 15,
                                        //   bottom: 0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: const [
                                            Icon(Icons.arrow_back_ios,
                                              color: Colors.white,),
                                            Icon(Icons.arrow_forward_ios,
                                              color: Colors.white,)
                                          ],
                                        )
                                    ),
                                    Positioned(
                                        top: 125,
                                        bottom: 0,
                                        left: 235,
                                        right: 0,
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
                                            Text('Jack Smith',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
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
                                                  size: 12,),
                                                addWidth(3),
                                                Text('4.95 (35)',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 10,
                                                      color: const Color(0xFF6A7080)
                                                  ),),
                                              ],
                                            )
                                          ],
                                        )
                                    ),
                                    Positioned(
                                        top: 16,
                                        bottom: 0,
                                        left: 260,
                                        right: 0,
                                        //   bottom: 0,

                                        child: Column(
                                          children: [
                                            Obx(() {
                                              return Container(
                                                  height: 30,
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
                                                             top: 50,
                                                             child: Container(
                                                             height: 50,
                                                             decoration: const BoxDecoration(
                                                                 color: Colors.white,
                                                                 shape: BoxShape.circle
                                                             ),
                                                             child:  IconButton(
                                                                 onPressed: (){
                                                                   Get.back();
                                                                 },
                                                                 icon: const Icon(Icons.clear)),
                                                           ),)
                                                         ],
                                                       );
                                                    }
                                                );
                                              },
                                                child: Image.asset('assets/images/topChef.png',width: 40,)),
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
                                                                height: 50,
                                                                decoration: const BoxDecoration(
                                                                    color: Colors.white,
                                                                    shape: BoxShape.circle
                                                                ),
                                                                child:  IconButton(
                                                                    onPressed: (){
                                                                      Get.back();
                                                                    },
                                                                    icon: const Icon(Icons.clear)),
                                                              ),)
                                                          ],
                                                        );
                                                      }
                                                  );
                                                },
                                                child: Image.asset('assets/images/topChef.png',width: 40,)),
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
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Future<void> _showSimpleDialog() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Gluten Free',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: const Color(0xFF425159),),
              )),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
          child: Text('Halal',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              color: const Color(0xFF425159),),
          )
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Vegan',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: const Color(0xFF425159),),
              )),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
          child: Text('Vegetarian',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              color: const Color(0xFF425159),),
          )
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
          child: Text('Pescatarian',
          style: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          fontSize: 18,
          color: const Color(0xFF425159),),
          )
              ),
            ],
          );
        });
  }
  Future<void> _showSimpleDialog1() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Sustainable Packaging',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: const Color(0xFF425159),),
              )),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
          child: Text('Top Chefs',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              color: const Color(0xFF425159),),
          )
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Rating',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: const Color(0xFF425159),),
              )),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
          child: Text('Distance',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              color: const Color(0xFF425159),),
          )
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
          child: Text('Quickest Delivery',
          style: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          fontSize: 18,
          color: const Color(0xFF425159),),
          )
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
          child: Text('Recommended',
          style: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          fontSize: 18,
          color: const Color(0xFF425159),),
          )
              ),
            ],
          );
        });
  }
  Future<void> _showSimpleDialog2(BuildContext context) async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        barrierColor: const Color(0x01000000),
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
            ),
            insetPadding: const EdgeInsets.only(bottom: 0,top: 218),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all( 8.0),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  children: [
                                    Image.asset(
                                        'assets/images/murgaImg.png'),
                                    addHeight(6),
                                    Text('Burger King with Pizza',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
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
                              Positioned(
                                  top: 75,
                                  // bottom: 0,
                                  left: 18,
                                  right: 15,
                                  //   bottom: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: const [
                                      Icon(Icons.arrow_back_ios,
                                        color: Colors.white,),
                                      Icon(Icons.arrow_forward_ios,
                                        color: Colors.white,)
                                    ],
                                  )
                              ),
                              Positioned(
                                  top: 125,
                                  bottom: 0,
                                  left: 235,
                                  right: 0,
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
                                      Text('Jack Smith',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
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
                                            size: 12,),
                                          addWidth(3),
                                          Text('4.95 (35)',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: const Color(0xFF6A7080)
                                            ),),
                                        ],
                                      )
                                    ],
                                  )
                              ),
                              Positioned(
                                  top: 16,
                                  bottom: 0,
                                  left: 260,
                                  right: 0,
                                  //   bottom: 0,

                                  child: Column(
                                    children: [
                                      Obx(() {
                                        return Container(
                                            height: 30,
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
                                                        top: 50,
                                                        child: Container(
                                                          height: 50,
                                                          decoration: const BoxDecoration(
                                                              color: Colors.white,
                                                              shape: BoxShape.circle
                                                          ),
                                                          child:  IconButton(
                                                              onPressed: (){
                                                                Get.back();
                                                              },
                                                              icon: const Icon(Icons.clear)),
                                                        ),)
                                                    ],
                                                  );
                                                }
                                            );
                                          },
                                          child: Image.asset('assets/images/topChef.png',width: 40,)),
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
                                                          height: 50,
                                                          decoration: const BoxDecoration(
                                                              color: Colors.white,
                                                              shape: BoxShape.circle
                                                          ),
                                                          child:  IconButton(
                                                              onPressed: (){
                                                                Get.back();
                                                              },
                                                              icon: const Icon(Icons.clear)),
                                                        ),)
                                                    ],
                                                  );
                                                }
                                            );
                                          },
                                          child: Image.asset('assets/images/topChef.png',width: 40,)),
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
              ),
            ),
          );
        }
    );
  }
}
