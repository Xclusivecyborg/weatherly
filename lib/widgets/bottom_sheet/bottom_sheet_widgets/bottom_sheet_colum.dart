import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxColumn extends StatelessWidget {
  const BoxColumn({
    Key? key,
    required this.date,
   required this.temp,
    required this.icon,
  }) : super(key: key);

  final String date;
  final String temp;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
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
          //   width: 60,
          //   height: 40,
          //   fit: BoxFit.contain,
          // ),
          Text(
            temp,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
