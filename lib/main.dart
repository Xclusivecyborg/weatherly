import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_forecast/app/app.router.dart';
import 'app/app.locator.dart';


void main() async {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      initialRoute: Routes.weatherPage,
    );
  }
}
