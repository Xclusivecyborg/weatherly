import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxRow extends StatelessWidget {
  final String daytemp;
  final String time;
  final String icon;
  const BoxRow({
    Key? key,
    required this.daytemp,
    required this.time,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          daytemp,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          icon,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        // Image.asset(
        //   'assets/weather2.png',
        //   width: 50,
        //   height: 50,
        // ),
        Text(
          time,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
