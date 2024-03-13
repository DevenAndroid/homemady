import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routers/routers.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_size.dart';
import '../widgets/onborading_list.dart';
import 'login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();
  final RxInt _pageIndex = 0.obs;
  bool loginLoaded = false;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  int currentIndex = 0;
  RxInt currentIndex12 = 0.obs;
  RxBool currentIndex1 = false.obs;
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          PageView.builder(
              itemCount: OnBoardingData.length + 1,
              controller: controller,
              physics: loginLoaded ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
              pageSnapping: true,
              onPageChanged: (index) {
                setState(() {
                  _pageIndex.value = index;
                  if (OnBoardingData.length == index) {
                    loginLoaded = true;
                  } else {
                    loginLoaded = false;
                  }
                });
              },
              itemBuilder: (context, index) {
                if (OnBoardingData.length == index) {
                  loginLoaded = true;
                  return const LoginScreen();
                }

                loginLoaded = false;
                return OnboardContent(
                  controller: controller,
                  indexValue: _pageIndex.value,
                  image: OnBoardingData[index].image.toString(),
                  title: OnBoardingData[index].title.toString(),
                  description: OnBoardingData[index].description.toString(),
                  description1: OnBoardingData[index].description1.toString(),
                  description2: OnBoardingData[index].description2.toString(),
                  description3: OnBoardingData[index].description3.toString(),
                  des22: OnBoardingData[index].des22.toString(),
                  des2: OnBoardingData[index].des2.toString(),
                  des1: OnBoardingData[index].des1.toString(),
                );
              }),
        ],
      ),
    ));
  }
}

class CustomIndicator extends StatelessWidget {
  final bool isActive;
  const CustomIndicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          width: isActive ? 35 : 10,
          height: 10,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppTheme.backgroundcolor),
              color: isActive ? const Color(0xffFFC529) : const Color(0xffFFC529).withOpacity(.40),
              borderRadius: const BorderRadius.all(Radius.circular(30))),
        ));
  }
}

class OnboardContent extends StatelessWidget {
  final String image, title, description;
  final String description1;
  final String description2;
  final String description3;
  final String des1;
  final String des22;
  final String des2;
  final int indexValue;
  final PageController controller;

  const OnboardContent(
      {Key? key,
      required this.controller,
      required this.image,
      required this.description1,
      required this.description2,
      required this.description3,
      required this.des1,
      required this.des2,
      required this.des22,
      required this.title,
      required this.description,
      required this.indexValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(children: [
      Expanded(
        child: Column(
          children: [
            Flexible(
              child: SizedBox(
                height: height * .42,
                width: width,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
                // decoration: BoxDecoration(
                //     image: DecorationImage(image: AssetImage(image), fit: BoxFit.contain,)),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...List.generate(
                        OnBoardingData.length,
                        (index) => Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: CustomIndicator(
                                isActive: index == indexValue,
                              ),
                            )),
                  ],
                ),
                SizedBox(
                  height: height * .03,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 26,
                    fontFamily: 'alegreyaSans',
                    color: Color(0xFF131A38),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * .02,
                ),
                if (des22 != '')
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          des22,
                        ),
                        width: 16,
                        height: 16,
                      ),
                      addWidth(5),
                      RichText(
                        text: TextSpan(
                          text: description,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            fontFamily: 'alegreyaSans',
                            color: Color(0xFF131A38),
                            fontStyle: FontStyle.italic,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: des1,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'alegreyaSans',
                                fontSize: 20,
                                color: Color(0xFF646774),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (des22 != '')
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          des22,
                        ),
                        width: 16,
                        height: 16,
                      ),
                      addWidth(5),
                      RichText(
                        text: TextSpan(
                          text: description1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            fontFamily: 'alegreyaSans',
                            color: Color(0xFF131A38),
                            fontStyle: FontStyle.italic,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: des2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                                fontFamily: 'alegreyaSans',
                                color: Color(0xFF646774),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (des22 != '')
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          des22,
                        ),
                        width: 16,
                        height: 16,
                      ),
                      addWidth(5),
                      RichText(
                        text: TextSpan(
                          text: description2,
                          style: const TextStyle(
                            fontFamily: 'alegreyaSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Color(0xFF131A38),
                            fontStyle: FontStyle.italic,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: description3,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                                fontFamily: 'alegreyaSans',
                                color: Color(0xFF646774),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: height * .06,
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
          height: height * .08,
          width: width * .95,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ElevatedButton(
              onPressed: () {
                controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                if (indexValue == 2) {
                  Get.toNamed(MyRouters.bottomNavbar);
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color(0xFF7ED957),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              child: const Icon(
                Icons.arrow_forward,
                size: 35,
              ))),
      SizedBox(
        height: height * .007,
      ),
    ]);
  }
}
