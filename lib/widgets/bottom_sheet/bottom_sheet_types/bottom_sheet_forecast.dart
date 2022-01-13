import 'package:flutter/material.dart' hide Notification;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/models/get_weather_daily.dart';
import 'package:weather_forecast/models/notifications_model.dart';
import 'package:weather_forecast/utils/app_colors.dart';
import 'package:weather_forecast/utils/app_strings.dart';
import 'package:weather_forecast/widgets/bottom_sheet/bottom_sheet_widgets/bottom_sheet_colum.dart';
import 'package:weather_forecast/widgets/bottom_sheet/bottom_sheet_widgets/bottom_sheet_container.dart';
import 'package:weather_forecast/widgets/bottom_sheet/bottom_sheet_widgets/bottom_sheet_header.dart';
import 'package:weather_forecast/widgets/bottom_sheet/bottom_sheet_widgets/bottom_sheet_row.dart';

class ForecastBottomSheet extends StatelessWidget {
  final List<dynamic> hoursnapshot;
  final List<Daily> datasnapshot;
  final List<Notification>? notification;
  final String Function(int) getIcon;
  const ForecastBottomSheet({
    Key? key,
    required this.hoursnapshot,
    required this.datasnapshot,
    required this.notification,
    required this.getIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SheetHeader(
          children: [
            Text(
              forecastReport,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textPurple,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textPurple,
            ),
          ],
        ),
        SheetContainer(
          header: today,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              separatorBuilder: (ctx, index) => const SizedBox(
                width: 30,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (ctx, index) {
                if (hoursnapshot.isEmpty) {
                  String temp = 'No data';
                  String icon = '';
                  String time = '';
                  return BoxRow(
                    icon: icon,
                    daytemp: temp,
                    time: time,
                  );
                } else {
                  String time = DateFormat('h a')
                      .format(DateTime.fromMillisecondsSinceEpoch(
                          hoursnapshot[index]['dt'] * 1000))
                      .toLowerCase();
                  String icon =
                      getIcon(hoursnapshot[index]['weather'][0]["id"]);
                  int temp = hoursnapshot[index]['temp'].toInt();
                  return BoxRow(
                    icon: icon,
                    daytemp: '$temp°c',
                    time: time,
                  );
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SheetContainer(
          row: Container(
            alignment: Alignment.center,
            height: 36,
            width: 100,
            decoration: BoxDecoration(
              color: AppColors.purple,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              fiveDays,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w600,
                color: AppColors.backgroundWhite,
                fontSize: 11,
              ),
            ),
          ),
          height: 246.71,
          header: nextForecast,
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            separatorBuilder: (ctx, index) => const Divider(
              color: AppColors.ash,
              thickness: 0.3,
              height: 0.5,
            ),
            itemCount: 5,
            itemBuilder: (ctx, index) {
              if (datasnapshot.isEmpty) {
                String date = 'No data';
                String icon = '';
                String temp = '';
                return BoxColumn(
                  icon: icon,
                  date: date,
                  temp: temp,
                );
              } else {
                String icon = getIcon(datasnapshot[index].condition!);
                String date = DateFormat('MMMM d').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        datasnapshot[index].dt! * 1000));
                String temp = datasnapshot[index].temp.substring(0, 2);
                return BoxColumn(
                  icon: icon,
                  date: date,
                  temp: '$temp°c',
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
