import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:homemady/widgets/custome_textfiled.dart';

import '../controller/faq_controller.dart';


class FaqsScreen extends StatefulWidget {
  const FaqsScreen({Key? key}) : super(key: key);
  static var faqsScreen ="/faqScreen";

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getData();
  }
  final controller = Get.put(FaqController());
  bool senderExpansion = false;
int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: backAppBar(title: 'FAQS :', context: context),

        body: controller.isDataLoading.value ?
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ListView.builder(
            itemCount: controller.model.value.data!.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffDCDCDC), width: 1),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          trailing:
                           (controller.model.value.data![index].selectedExpansion == false) ?
                          const Icon(
                            Icons.add,
                            color: Color(0xFF7ED957),
                          )
                              : const Icon(
                            Icons.remove,

                            color: Color(0xFF7ED957),
                          ),
                          onExpansionChanged: (value) {
                            setState(() {
                              controller.model.value.data![index].selectedExpansion = value;
                            });
                          },
                          title:  Text(
                            controller.model.value.data![index].question.toString(),
                            style: const TextStyle(
                              color:  Color(0xFF1D1D1D),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          children: <Widget>[
                            ListTile(
                                visualDensity: VisualDensity.compact,
                                dense: true,
                                iconColor: const Color(0xFF07B6CA),
                                subtitle: Html(
                                  data: controller.model.value.data![index].answer.toString(),
                                  style: {
                                    'body': Style(
                                        fontWeight: FontWeight.w400,
                                        fontSize: FontSize(13 ),
                                        color: const Color(0xFFBBBBBB)
                                    )
                                  },
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ): const Center(child: CircularProgressIndicator()),
      );
    });
  }
}