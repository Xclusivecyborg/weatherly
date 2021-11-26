import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_forecast/utils/app_colors.dart';

class Body extends StatelessWidget {
  final bool? isBusy;
  final Function()? navigate;
  final Widget? navigator;
  final String? cityname, country;
  final Widget? child, child2, child3;
  final Function()? ontap;
  const Body({
    Key? key,
    this.isBusy,
    this.navigate,
    this.cityname,
    this.country,
    this.child,
    this.child2,
    this.ontap,
    this.navigator, this.child3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isBusy!
          ? const CircularProgressIndicator()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(27.0, 40, 27.0, 72),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        navigator!,
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: GestureDetector(
                                  onTap: navigate,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.place,
                                        color: AppColors.backgroundWhite,
                                      ),
                                      Text(
                                        '$cityname, $country',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: GoogleFonts.dmSans(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.backgroundWhite,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                height: 43,
                                decoration: BoxDecoration(
                                  color: AppColors.boxColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                             child3!,
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                    child!,
                    const SizedBox(height: 100),
                    child2!,
                  ],
                ),
              ),
            ),
    );
  }
}
