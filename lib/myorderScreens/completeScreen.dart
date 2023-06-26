import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_size.dart';


class CompleteScreen extends StatefulWidget {
  const CompleteScreen({Key? key}) : super(key: key);

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17)
                                ),
                                child: Image.asset('assets/images/Rectangle 39702.png',height: 76,width: 76,)),
                            addWidth(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Panna Onion Pasta',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: const Color(0xFF1A2E33)
                                  ),),
                                addHeight(3),
                                Row(
                                  children: [
                                    Text('3 Items ',
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
                                    Text('1.5km',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: const Color(0xFF486769).withOpacity(0.70)
                                      ),),
                                  ],
                                ),
                                addHeight(5),
                                Row(
                                  children: [
                                    Text('€6.99',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: const Color(0xFF70CC49)
                                      ),),
                                    addWidth(8),
                                    Container(
                                      height: 22,
                                      width: 80,
                                      decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          color: const Color(0xFF7ED957)
                                      ),
                                      child:
                                      Center(
                                        child: Text('Completed',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFFFFFFFF),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding:  EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10),
                        child: Divider(
                          color: Color(0xFFE8E8E8),
                          thickness: 1.4,
                          height: 1,
                        ),
                      ),
                      addHeight(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 132,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: const Color(0xFF7ED957)
                                  )
                              ),
                              child: Center(
                                child: Text('Leave a review',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF7ED957),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            addWidth(15),
                            Container(
                              height: 30,
                              width: 132,
                              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Color(0xFF7ED957)
                              ),
                              child: Center(
                                child: Text('Order Again',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      addHeight(15),
                    ],
                  ),
                ),
                addHeight(10),
              ],
            );
          },
        ),
      ),
    );
  }
}
