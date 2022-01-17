import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_forecast/app/app.locator.dart';
import 'package:weather_forecast/services/get_current_location.dart';
import 'package:weather_forecast/services/network.dart';
import 'package:weather_forecast/utils/app_colors.dart';
import 'package:weather_forecast/utils/app_strings.dart';
import 'package:weather_forecast/views/location_view/location_view.form.dart';
import 'package:weather_forecast/views/location_view/location_view_model.dart';
import 'package:weather_forecast/views/weather/weather_page_viewmodel.dart';
import 'package:weather_forecast/widgets/body.dart';
import 'package:weather_forecast/widgets/custom_toast.dart';
import 'package:weather_forecast/widgets/location_textfield.dart';
import 'package:weather_forecast/widgets/weather_box.dart';

final _location = Location();
final _navigation = locator<NavigationService>();
final _api = locator<Network>();

@FormView(
  fields: [
    FormTextField(name: 'search'),
  ],
)
class ForecastReport extends StatelessWidget with $ForecastReport {
  ForecastReport({Key? key, required this.newmod}) : super(key: key);
  final WeatherPageViewmodel newmod;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocationViewModel>.reactive(
      viewModelBuilder: () => LocationViewModel(
          api: _api, location: _location, navigation: _navigation),
      // onModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Body(
            isBusy: model.isBusy,
            cityname: model.cityname.isEmpty ? newmod.cityname : model.cityname,
            country: model.country.isEmpty ? newmod.country : model.country,
            navigator: GestureDetector(
              onTap: model.pop,
              child: Container(
                height: 43,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: AppColors.backgroundWhite,
                ),
              ),
            ),
            navigate: () => _showSheet(context, model, searchController),
            child: WeatherBox(
              isCelsius: model.isCelsius,
              doubleTap: () async {
                await model.toggleLocation(
                  model.isCelsius,
                  searchController.text.isEmpty
                      ? newmod.cityname
                      : searchController.text,
                );
                model.toggleCelsius();
                customtoast(
                  toastmessage: 'Temperature changed',
                );
              },
              weathericon: model.getWeatherIcon(model.condition),
              date: model.date!.isEmpty ? newmod.date : model.date,
              time: model.time!.isEmpty ? newmod.time : model.time,
              temp: model.temperature.isEmpty
                  ? newmod.temperature.substring(0, 2)
                  : model.temperature.substring(0, 2),
              location:
                  model.cityname.isEmpty ? newmod.cityname : model.cityname,
              country: model.country.isEmpty ? newmod.country : model.country,
            ),
            child2: const SizedBox(),
            child3: const SizedBox(),
          ),
        );
      },
    );
  }
}

_showSheet(BuildContext context, LocationViewModel model,
    TextEditingController searchController) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Row(
        children: [
          Text(
            location,
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
      content: CustomSearchField(
        onChanged: model.changeCityName,
        preixIcon: Icons.place,
        hint: cityName,
        controller: searchController,
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            model.pop();
            customtoast(toastmessage: 'please wait');
            await model.getWeatherbyCityCelsius(
              name: searchController.text.isEmpty
                  ? model.city
                  : searchController.text,
            );
            customtoast(toastmessage: 'successful');
            searchController.clear();
          },
          child: Container(
            height: 43,
            width: 43,
            decoration: BoxDecoration(
              color: AppColors.purple,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.search,
              color: AppColors.backgroundWhite,
            ),
          ),
        ),
      ],
    ),
  );
}
