import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:weather_forecast/utils/app_colors.dart';
import 'package:weather_forecast/utils/app_strings.dart';
import 'package:weather_forecast/views/location_view/location_view.form.dart';
import 'package:weather_forecast/views/weather/weather_page_viewmodel.dart';
import 'package:weather_forecast/widgets/body.dart';
import 'package:weather_forecast/widgets/bottom_sheet/bottom_sheet_widgets/bottom_sheet.dart';
import 'package:weather_forecast/widgets/location_textfield.dart';
import 'package:weather_forecast/widgets/weather_box.dart';

@FormView(
  fields: [
    FormTextField(name: 'search'),
  ],
)
class ForecastReport extends StatelessWidget with $ForecastReport {
  ForecastReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WeatherPageViewmodel>.reactive(
      viewModelBuilder: () => WeatherPageViewmodel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Body(
            isBusy: model.isBusy,
            cityname: model.cityname,
            country: model.country,
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
            navigate: () => showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (_) => ForecastSheet(
                child: Column(
                  children: [
                    Row(
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomSearchField(
                          onChanged: (val) async {},
                          preixIcon: Icons.place,
                          hint: cityName,
                          controller: searchController,
                        ),
                        GestureDetector(
                          onTap: () {
                            model.pop();
                            model.getWeatherbyCityCelsius(
                                name: searchController.text);
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
                  ],
                ),
              ),
            ),
            child: WeatherBox(
              isCelsius: model.isCelsius,
              doubleTap: () async {
                await model.toggleLocation(
                    model.isCelsius, searchController.text);
                model.toggleCelsius();
              },
              weathericon: model.getWeatherIcon(model.condition),
              date: model.date,
              time: model.time,
              temp: model.temperature,
              location: model.cityname,
              country: model.country,
            ),
            child2: const SizedBox(),
            child3: const SizedBox(),
          ),
        );
      },
    );
  }
}












/* () => showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (_) => ForecastSheet(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SheetHeader(
                                      children: [
                                        Text(
                                          'Forecast Report',
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
                                    const SheetContainer(
                                      header: 'Today',
                                    ),
                                    const SheetContainer(
                                      height: 246.71,
                                      header: 'Next forecast',
                                    ),
                                  ],
                                ),
                              ),
                            ) , */