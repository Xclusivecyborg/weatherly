import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_forecast/services/network.dart';
import 'package:weather_forecast/views/location_view/location_view.dart';

import 'package:weather_forecast/views/weather/weather_page.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: WeatherPage, initial: true),
    CupertinoRoute(page: ForecastReport),
  ],
  dependencies: [
    LazySingleton(
      classType: NavigationService,
    ),
    LazySingleton(classType: Network),
  ],
  logger: StackedLogger(),
)
class AppRouter {
  /* This class serves no other purpose other than having the
   StackedApp annotation attached to it*/
}
