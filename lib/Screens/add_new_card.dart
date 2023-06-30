import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/editprofiletextfiled.dart';


class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({Key? key}) : super(key: key);

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  bool showErrorMessage = false;
  bool value = false;
  RxBool checkboxColor = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: 'Add New Card', context: context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Name',style: GoogleFonts.poppins(
                   color: const Color(0xFF535353),
                   fontWeight: FontWeight.w400,
                   fontSize: 16,
                 ),),
                addHeight(7.0),
                EditProfileTextFieldWidget(
                  hint: 'Arlene Mccoy',
                  onTap: (){},
                ),
                addHeight(20.0),
                Text('Card Number',style: GoogleFonts.poppins(
                  color: const Color(0xFF535353),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),),
                addHeight(7.0),
                EditProfileTextFieldWidget(
                  hint: '4561 456892 3521',
                  onTap: (){},
                  suffix: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/master_card.png',height: 20,),
                    ],
                  ),
                ),
                addHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Expires ',style: GoogleFonts.poppins(
                            color: const Color(0xFF535353),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),),
                          addHeight(7),
                          EditProfileTextFieldWidget(
                            hint: '02/12',
                            onTap: (){},
                          ),
                        ],
                      ),
                    ),
                    addWidth(29.88),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CVV ',style: GoogleFonts.poppins(
                            color: const Color(0xFF535353),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),),
                          addHeight(7),
                          EditProfileTextFieldWidget(
                            hint: '5135',
                            onTap: (){},
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
                addHeight(20),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.0,
                      child: Theme(
                        data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            unselectedWidgetColor: checkboxColor.value == false
                                ? Color(0xFF64646F)
                                : Color(0xFF64646F)
                        ),
                        child: Checkbox(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: value,
                            activeColor: Color(0xFF7ED957),
                            onChanged: (newValue) {
                              setState(() {
                                value = newValue!;
                                checkboxColor.value = !newValue!;
                              });
                            }),
                      ),
                    ),
                    Text(
                        'Securely save card and details',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: const Color(0xFF878787))),
                  ],
                ),
                addHeight(200),
                CommonButton(title: 'Save',onPressed: (){
                  if (value != true) {
                    setState(() {
                      showErrorMessage = true;
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Agree to our terms of Service"),
                          ));
                    }
                    );
                  }
                  else {
                    setState(() {
                      showErrorMessage = false;
                      Get.toNamed(MyRouters.emailVerificationScreen);
                    });
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
