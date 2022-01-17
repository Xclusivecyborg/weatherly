// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../views/location_view/location_view.dart';
import '../views/weather/weather_page.dart';
import '../views/weather/weather_page_viewmodel.dart';

class Routes {
  static const String weatherPage = '/';
  static const String forecastReport = '/forecast-report';
  static const all = <String>{
    weatherPage,
    forecastReport,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.weatherPage, page: WeatherPage),
    RouteDef(Routes.forecastReport, page: ForecastReport),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    WeatherPage: (data) {
      var args = data.getArgs<WeatherPageArguments>(
        orElse: () => WeatherPageArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => WeatherPage(key: args.key),
        settings: data,
      );
    },
    ForecastReport: (data) {
      var args = data.getArgs<ForecastReportArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ForecastReport(
          key: args.key,
          newmod: args.model,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// WeatherPage arguments holder class
class WeatherPageArguments {
  final Key? key;
  WeatherPageArguments({this.key});
}

/// ForecastReport arguments holder class
class ForecastReportArguments {
  final Key? key;
  final WeatherPageViewmodel model;
  ForecastReportArguments({this.key, required this.model});
}
