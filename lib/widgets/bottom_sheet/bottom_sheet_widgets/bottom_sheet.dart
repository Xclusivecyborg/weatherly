import 'package:flutter/material.dart';
import 'package:weather_forecast/utils/app_colors.dart';

class ForecastSheet extends StatelessWidget {
  final Widget? child;
  final double? height;
  const ForecastSheet({
    Key? key,
    this.child,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 29),
        child: child ?? Container(),
        decoration: const BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }
}
