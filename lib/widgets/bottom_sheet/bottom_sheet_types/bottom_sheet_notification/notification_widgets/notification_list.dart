import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_forecast/utils/app_colors.dart';

class NotificationListWidget extends StatelessWidget {
  const NotificationListWidget({
    Key? key,
    required this.icon,
    required this.date,
    required this.message,
  }) : super(key: key);

  final String icon;
  final String date;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          icon ,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date ,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: AppColors.deepAsh,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
