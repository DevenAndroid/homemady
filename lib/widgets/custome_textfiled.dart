import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dimenestion.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  RxBool? obSecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String? labelText;
  final RxString hintText;
  final Widget? suffixIcon;
  final Widget? prefix;

  List<TextInputFormatter>? inputFormatters1 = [];

  CustomTextField({
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.obSecure,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    required this.hintText,
    this.suffixIcon,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.inputFormatters1,
    this.onFieldSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
          cursorColor: const Color(0xFF7ED957),
        // autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: widget.onFieldSubmitted,
          inputFormatters: widget.inputFormatters1,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingCompleted,
          obscureText: widget.obSecure!.value,
          minLines: widget.isMulti ? 4 : 1,
          maxLines: widget.isMulti ? null : 1,
          onTap: widget.onTap,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          decoration: InputDecoration(
            counter: const Offstage(),
            filled: true,
            errorMaxLines: 2,
            enabled: widget.enabled,
            fillColor: Colors.transparent,
            hintText: widget.hintText.value,
            errorText: widget.errorText,
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Colors.black),
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffixIcon,
            hintStyle: GoogleFonts.poppins(
              color: const Color(0xff2F353F),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            /*errorStyle: const TextStyle(
              overflow: TextOverflow.clip,
            ),*/
            contentPadding: const EdgeInsets.only(left: 10, top: 15),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8.0)),
          ),
          validator: widget.validator);
    });
  }
}


// custom button

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CommonButton({Key? key, required this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
               Color(0xFF7ED957),
                Color(0xff6BD13F)]
          )
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(AddSize.screenWidth, AddSize.size50*1.1),
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(title,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: .5,
                  fontSize: 20))),
    );
  }
}


AppBar backAppBar(
    {required title,
      required BuildContext context,
      String dispose = "",
      Color? backgroundColor = Colors.white,
      Color? textColor = Colors.black,
      Widget? icon,
      disposeController}) {
  return AppBar(
    //shadowColor:  Colors.grey[400],
    toolbarHeight: 60,
    elevation: 0,
    surfaceTintColor: Colors.grey.shade300,
    leadingWidth: AddSize.size40 * 0.9,
    backgroundColor: backgroundColor,
    title: Text(
      title,
      style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 17,
          color: const Color(0xFF303D48)
      ),
    ),
    leading: Padding(
      padding: EdgeInsets.only(left: AddSize.padding15),
      child: GestureDetector(
          onTap: () {
            Get.back();
            if (dispose == "dispose") {}
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ??
                  Icon(Icons.arrow_back_rounded)
            ],
          )),
    ),
  );
}
