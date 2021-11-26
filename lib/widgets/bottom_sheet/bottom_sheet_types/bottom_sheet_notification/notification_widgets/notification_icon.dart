import 'package:flutter/material.dart';
import 'package:weather_forecast/utils/app_colors.dart';

class NotificationIcon extends StatelessWidget {
  final Function()? ontap;
  const NotificationIcon({
    Key? key,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 43,
        width: 43,
        decoration: BoxDecoration(
          color: AppColors.boxColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.notifications,
          color: AppColors.backgroundWhite,
          size: 30,
        ),
      ),
    );
  }
}
