import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_textfiled.dart';


class FaqsScreen extends StatefulWidget {
  const FaqsScreen({Key? key}) : super(key: key);

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  bool senderExpansion = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: backAppBar(title: 'Faqs', context: context),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ListView.builder(
          itemCount: 6,
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
                        trailing: (senderExpansion == false)
                            ? const Icon(
                          Icons.add,
                          color: Color(0xFF7ED957),
                        )
                            : const Icon(
                          Icons.remove,
                          color: Color(0xFF7ED957),
                        ),
                        onExpansionChanged: (value) {
                          setState(() {
                            senderExpansion = value;
                          });
                        },
                        title: const Text(
                          "What is Homemady? ",
                          style: TextStyle(
                            color: const Color(0xFF1D1D1D),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        children: <Widget>[
                          const ListTile(
                            visualDensity: VisualDensity.compact,
                            dense: true,
                            iconColor: Color(0xFF07B6CA),
                            subtitle: Text(
                              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley..",
                              style: TextStyle(
                                color: Color(0xFFBBBBBB),
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
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
      ),
    );
  }
}