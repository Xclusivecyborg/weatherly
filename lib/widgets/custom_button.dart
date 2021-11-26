import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_forecast/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final Function()? onTap;
  final Color? color;
  final double? width;
  const CustomButton({
    Key? key,
    this.label,
    this.onTap,
    @required this.color,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(right: 40),
        alignment: Alignment.center,
        height: 60,
        width: width ?? MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              label!,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w600,
                color: AppColors.backgroundWhite,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.keyboard_arrow_up,
              color: AppColors.backgroundWhite,
            ),
          ],
        ),
      ),
    );
  }
}
