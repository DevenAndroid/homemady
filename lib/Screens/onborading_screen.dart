import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/onborading_list.dart';
import 'package:google_fonts/google_fonts.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return  Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height*.9,
              child: PageView.builder(
                  itemCount: page1.length,
                  controller: controller,
                  onPageChanged: (newValue) {
                    setState(() {
                      currentIndex = newValue;
                    });
                  },
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(

                                height: 50,
                              ),
                              Center(
                                child: Image(
                                  image: AssetImage(page1[index].img,),width: 344,height: 310,
                                ),
                              ),
                              const SizedBox(

                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SmoothPageIndicator(
                                    axisDirection: Axis.horizontal,
                                    controller: controller,
                                    count: page1.length,
                                    effect: const WormEffect(
                                      activeDotColor: Color(0xFFFFC529),
                                      dotWidth: 10,
                                      dotHeight: 10,
                                      dotColor: Colors.black12,
                                    ),
                                  ),
                                ],
                              ),
                              addHeight(10),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        page1[index].title,
                                        style: GoogleFonts.alegreyaSans(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 26,
                                          color: const Color(0xFF131A38),
                                            fontStyle: FontStyle.italic,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                       Text(page1[index].des22,style: const TextStyle(color: Color(0xFF7ED957),fontSize: 20),),
                                        RichText(
                                          text: TextSpan(
                                            text:  page1[index].description,
                                            style: GoogleFonts.alegreyaSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20,
                                              color: const Color(0xFF131A38),
                                              fontStyle: FontStyle.italic,
                                            ),
                                            children:  <TextSpan>[
                                              TextSpan(text:  page1[index].des1,
                                                style: GoogleFonts.alegreyaSans(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 20,
                                                  color: const Color(0xFF131A38),
                                                  fontStyle: FontStyle.italic,
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(page1[index].des22,style: const TextStyle(color: Color(0xFF7ED957),fontSize: 20),),
                                        RichText(
                                          text: TextSpan(
                                            text:  page1[index].description1,
                                            style: GoogleFonts.alegreyaSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20,
                                              color: const Color(0xFF131A38),
                                              fontStyle: FontStyle.italic,
                                            ),
                                            children:  <TextSpan>[
                                              TextSpan(text:  page1[index].des2,
                                                style: GoogleFonts.alegreyaSans(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 20,
                                                  color: const Color(0xFF131A38),
                                                  fontStyle: FontStyle.italic,
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(page1[index].des22,style: const TextStyle(color: Color(0xFF7ED957),fontSize: 20),),
                                        RichText(
                                          text: TextSpan(
                                            text:  page1[index].description2,
                                            style: GoogleFonts.alegreyaSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20,
                                            color: const Color(0xFF131A38),
                                            fontStyle: FontStyle.italic,
                                          ),
                                            children:  <TextSpan>[
                                              TextSpan(text:  page1[index].description3,
                                                style: GoogleFonts.alegreyaSans(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 20,
                                            color: const Color(0xFF131A38),
                                            fontStyle: FontStyle.italic,
                                          ),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),

                                  ]
                              )
                            ]
                        )
                    );
                  }
              ),
            ),
            const SizedBox(
              height: 0,
            ),

            Center(
              child: Container(
                width: 60,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF7ED957),
                  shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5F5F5F).withOpacity(0.4),
                        offset: const Offset(0.0, 0.5),
                        blurRadius: 5,),
                    ]
                ),
                child: InkWell(
                  onTap: (){
                    Get.toNamed(MyRouters.loginScreen);
                  },
                  child: const Icon(Icons.arrow_forward,size: 30,color: Colors.white,),
                ),
              ),
            )
            // InkWell(
            //     onTap: (){
            //       // Get.toNamed(MyRouters.mobileNumber);
            //     },
            //     child: CustomOutlineButton(title: "Open free account",)),
            // SizedBox(height: 15,),
            // const CustomOutlineBoder(title: "I have an account", backgroundColor: Colors.white,textColor: AppTheme.buttonColor),


          ],
        ),
      ),
    );
  }
}
