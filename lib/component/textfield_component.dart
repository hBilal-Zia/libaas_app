import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldComponent extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final Color? hintColor;
  final bool? showSuffix;
  final bool? readOnly;
  final bool? calender;
  final bool? showPass;
  final VoidCallback? calenderClick;
  final FormFieldValidator<String> validator;

  const TextFieldComponent({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.readOnly = false,
    this.hintColor,
    this.calender = false,
    this.showSuffix = false,
    this.showPass = true,
    this.calenderClick,
    required this.validator,
  }) : super(key: key);

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    // Determine whether to obscure the text based on the showSuffix property
    if (widget.showSuffix == false) {
      isObscured = false;
    } else if (widget.showSuffix == true && widget.showPass == false) {
      isObscured = false;
    }

    return TextFormField(
      readOnly: widget.readOnly!,
      controller: widget.textEditingController,
      obscureText: isObscured,
      validator: widget.validator,
      style: TextStyle(
        fontFamily: GoogleFonts.openSans().fontFamily,
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        suffixIcon: widget.showSuffix == true && widget.showPass == true
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
                child: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xffAAA3A3),
                ),
              )
            : widget.showSuffix == true && widget.calender == true
                ? GestureDetector(
                    onTap: widget.calenderClick,
                    child: const Icon(
                      Icons.calendar_month,
                      color: Color(0xffAAA3A3),
                    ),
                  )
                : const SizedBox(),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.hintColor ?? const Color(0xffAAA3A3),
          fontFamily: GoogleFonts.openSans().fontFamily,
          fontSize: 24.0,
          fontWeight: FontWeight.w500,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 30.0,
        ),
        fillColor: const Color(0xffF2F0F0),
        filled: true,
      ),
    );
  }
}
