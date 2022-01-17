import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_forecast/utils/app_colors.dart';

class CustomSearchField extends StatelessWidget {
  final IconData? preixIcon;
  final Widget? suffixIcon;
  final String? hint;
  final Function(String)? onChanged;
  final TextEditingController controller;
  const CustomSearchField({
    Key? key,
    @required this.hint,
    this.preixIcon,
    this.suffixIcon,
    this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 5,
        right: 5,
      ),
      child: TextField(
        controller: controller,
        autofocus: true,
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: Icon(
            preixIcon,
            color: AppColors.purple,
          ),
          hintText: hint!,
          hintStyle: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.ash,
            fontSize: 14,
          ),
          border: InputBorder.none,
        ),
      ),
      height: 43,
      width: 180,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightPurple),
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
