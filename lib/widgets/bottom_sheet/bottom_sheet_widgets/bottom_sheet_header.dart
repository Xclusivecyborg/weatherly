import 'package:flutter/material.dart';
import 'package:weather_forecast/utils/app_colors.dart';

class SheetHeader extends StatelessWidget {
  final List<Widget>? children;
  const SheetHeader({
    Key? key,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: AppColors.ash,
          thickness: 2,
          height: 2,
          endIndent: 120,
          indent: 120,
        ),
        const SizedBox(height: 12),
        Container(
          height: 43,
          width: 152,
          padding: const EdgeInsets.only(left: 14),
          decoration: BoxDecoration(
            color: AppColors.lightPurple,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: children!,
          ),
        ),
      ],
    );
  }
}
