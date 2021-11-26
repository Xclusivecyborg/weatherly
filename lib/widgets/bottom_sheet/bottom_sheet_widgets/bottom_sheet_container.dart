import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_forecast/utils/app_colors.dart';

class SheetContainer extends StatelessWidget {
  final String header;
  final Widget? child;
  final double? height;
  final Widget? row;
  const SheetContainer({
    Key? key,
    required this.header,
    this.child,
    this.height,
    this.row,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              header,
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            row ?? Container()
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: height ?? 106,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.lightWhite,
            border: Border.all(
              width: 1.5,
              color: AppColors.lightPurple,
            ),
            borderRadius: BorderRadius.circular(11),
          ),
          child: child,
        ),
      ],
    );
  }
}
