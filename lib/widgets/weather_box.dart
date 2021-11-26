import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_forecast/utils/app_colors.dart';
import 'package:weather_forecast/utils/app_strings.dart';

class WeatherBox extends StatelessWidget {
  final String? time;
  final String? date;
  final String? weathericon;
  final int? temp;
  final String? location, country;
  final Function() doubleTap;
  final bool isCelsius;
  const WeatherBox({
    Key? key,
    this.date,
    required this.weathericon,
    this.temp,
    this.location,
    this.country,
    this.time,
    required this.doubleTap,
    required this.isCelsius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: doubleTap,
      child: Container(
        height: 348,
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
          color: AppColors.lightWhite,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 0.5,
            color: AppColors.backgroundWhite,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weathericon ?? '',
                  style: const TextStyle(
                    fontSize: 75,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      today,
                      style: GoogleFonts.dmSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.backgroundWhite,
                      ),
                    ),
                    Text(
                      date!,
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.backgroundWhite,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Stack(children: [
              Text(
                '$temp ',
                style: GoogleFonts.dmSans(
                  fontSize: 130,
                  fontWeight: FontWeight.bold,
                  color: AppColors.backgroundWhite,
                ),
              ),
              Positioned(
                right: 0,
                top: 14,
                child: Text(
                  isCelsius ? '°c' : '°f',
                  style: GoogleFonts.dmSans(
                    fontSize: 35,
                    fontWeight: FontWeight.w400,
                    color: AppColors.backgroundWhite,
                  ),
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$location,$country ',
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.backgroundWhite,
                  ),
                ),
                Container(
                  height: 5,
                  width: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundWhite,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  '  $time',
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.backgroundWhite,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
