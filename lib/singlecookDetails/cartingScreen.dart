import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/dimenestion.dart';


class carteingScreen extends StatefulWidget {
  const carteingScreen({Key? key}) : super(key: key);

  @override
  State<carteingScreen> createState() => _carteingScreenState();
}

class _carteingScreenState extends State<carteingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 4,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF37C666).withOpacity(0.10),
                                offset: const Offset(.1, .1,
                                ),
                                blurRadius: 20.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(child: Image.asset('assets/images/Rectangle 39762.png',height: 80,width: 70,)),
                                addWidth(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Special Burger',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: const Color(0xFF21283D)
                                      ),),
                                    addHeight(3),
                                    Text('Size: 200gm',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 11,
                                          color: const Color(0xFF364A4F)
                                      ),),
                                    addHeight(3),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text('spiciness :',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10,
                                                  color: const Color(0xFF1F2D30)
                                              ),),
                                            addWidth(4),
                                            Text('Mildly Spicy',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10,
                                                  color: const Color(0xFF6CC844)
                                              ),),
                                          ],
                                        ),
                                        addWidth(10),
                                        Row(
                                          children: [
                                            Text('Allergens :',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10,
                                                  color: const Color(0xFF1F2D30)
                                              ),),
                                            addWidth(4),
                                            Text('Crustaceans',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10,
                                                  color: const Color(0xFF6CC844)
                                              ),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    addHeight(6),
                                    IntrinsicHeight(
                                      child:
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap:
                                                () {
                                            },
                                            child:
                                            Container(
                                              decoration: BoxDecoration(border: Border.all(color: const Color(0xFF72CD4A)), shape: BoxShape.circle),
                                              alignment: Alignment.center,
                                              child: const Padding(
                                                padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                child: Text(
                                                  '-',
                                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF72CD4A)),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment:
                                            Alignment.center,
                                            child:
                                            const Padding(
                                              padding: EdgeInsets.only(left: 14.0, right: 14.0),
                                              child: Text(
                                                  '1'
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap:
                                                () {

                                            },
                                            child:
                                            Container(
                                              decoration: BoxDecoration(color: const Color(0xFF72CD4A),border: Border.all(color: const Color(0xFF72CD4A)), shape: BoxShape.circle),
                                              alignment: Alignment.center,
                                              child: const Padding(
                                                padding:  EdgeInsets.symmetric(horizontal: 8),
                                                child: Text(
                                                  '+',
                                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Colors.white),
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
                              ],
                            ),
                            addHeight(5),
                            Container(
                              margin: EdgeInsets.only(left: 75),
                              color: Color(0xFFE9E9E9),
                              width: AddSize.screenWidth,
                              height: 1,
                            ),
                            addHeight(7),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                addWidth(80),
                                Image.asset('assets/images/helpimg.png',height: 13,),
                                addWidth(4),
                                Text('Can cook more units by: 30th June 2023',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 11,
                                      color: const Color(0xFF364A4F)
                                  ),),
                              ],
                            ),
                            addHeight(4), Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                addWidth(80),
                                Image.asset('assets/images/helpimg.png',height: 13,),
                                addWidth(4),
                                Text('Can cook more units by: 30th June 2023',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 11,
                                      color: const Color(0xFF364A4F)
                                  ),),
                              ],
                            ),

                          ],
                        ),
                      ),
                      Positioned(
                        top: 14,
                        right: 20,
                        child:  Text('€6.99',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: const Color(0xFF70CC49)
                          ),),
                      )
                    ],
                  ),
                  addHeight(10)
                ],
              );
            },),
        ),

      ],
    );
  }
}
