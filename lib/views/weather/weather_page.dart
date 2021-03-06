import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_forecast/app/app.locator.dart';
import 'package:weather_forecast/app/app.router.dart';
import 'package:weather_forecast/services/get_current_location.dart';
import 'package:weather_forecast/services/network.dart';
import 'package:weather_forecast/utils/app_colors.dart';
import 'package:weather_forecast/utils/app_strings.dart';
import 'package:weather_forecast/views/location_view/location_view.form.dart';
import 'package:weather_forecast/views/weather/weather_page_viewmodel.dart';
import 'package:weather_forecast/widgets/body.dart';
import 'package:weather_forecast/widgets/bottom_sheet/bottom_sheet_types/bottom_sheet_forecast.dart';
import 'package:weather_forecast/widgets/bottom_sheet/bottom_sheet_types/bottom_sheet_notification/notification_widgets/notification_icon.dart';
import 'package:weather_forecast/widgets/bottom_sheet/bottom_sheet_types/bottom_sheet_notification/notification_widgets/notification_list.dart';
import 'package:weather_forecast/widgets/bottom_sheet/bottom_sheet_widgets/bottom_sheet.dart';
import 'package:weather_forecast/widgets/bottom_sheet/bottom_sheet_widgets/bottom_sheet_header.dart';
import 'package:weather_forecast/widgets/custom_button.dart';
import 'package:weather_forecast/widgets/custom_toast.dart';
import 'package:weather_forecast/widgets/weather_box.dart';

final _location = Location();
final _navigation = locator<NavigationService>();
final _api = locator<Network>();

class WeatherPage extends StatelessWidget with $ForecastReport {
  WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WeatherPageViewmodel>.reactive(
      onModelReady: (model) => model.initialize(),
      viewModelBuilder: () => WeatherPageViewmodel(
          api: _api, location: _location, navigation: _navigation),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: RefreshIndicator(
            onRefresh: model.initialize,
            child: Body(
              cityname: model.cityname,
              country: model.country,
              navigate: () async {
                _navigation.navigateTo(
                  Routes.forecastReport,
                  arguments: ForecastReportArguments(model: model),
                );
              },
              isBusy: model.isBusy,
              child: WeatherBox(
                isCelsius: model.isCelsius,
                weathericon: model.getWeatherIcon(model.condition),
                date: model.date,
                time: model.time,
                temp: model.temperature.isEmpty
                    ? '0'
                    : model.temperature.substring(0, 2),
                location: model.cityname,
                country: model.country,
                doubleTap: () async {
                  await model.toggleWeather(model.isCelsius);
                  model.toggleCelsius();
                  customtoast(
                    toastmessage: 'Temperature changed',
                  );
                },
              ),
              child2: Center(
                child: CustomButton(
                  color: AppColors.boxColor,
                  label: forecastReport,
                  onTap: () => showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (_) => ForecastSheet(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ForecastBottomSheet(
                        getIcon: model.getWeatherIcon,
                        notification: model.notifications,
                        datasnapshot: model.datasnapshot!,
                        hoursnapshot: model.hoursnapshots!,
                      ),
                    ),
                  ),
                ),
              ),
              child3: NotificationIcon(
                ontap: () => showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => ForecastSheet(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SheetHeader(
                          children: [
                            Text(
                              yourNotifications,
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
                        Text(
                          'New',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.deepAsh,
                          ),
                        ),
                        SizedBox(
                          height: 270,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            shrinkWrap: true,
                            itemCount: model.notifications!.length,
                            itemBuilder: (context, index) {
                              if (model.notifications!.isEmpty) {
                                String icon = '';
                                String message = noData;
                                String date = '';
                                return NotificationListWidget(
                                    icon: icon, date: date, message: message);
                              } else {
                                String icon = model.getWeatherIcon(model
                                    .notifications![index].weather![0].id!);
                                String message = model.getNotificationMessage(
                                    model
                                        .notifications![index].weather![0].id!);
                                String date = DateFormat('MMM d').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      model.notifications![index].dt! * 1000),
                                );
                                return NotificationListWidget(
                                    icon: icon, date: date, message: message);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
