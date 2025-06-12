import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    scaffoldBackgroundColor: kWhiteColor,
    colorScheme: ThemeData().colorScheme.copyWith(primary: kPrimaryColor),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.white,
      hourMinuteColor: Colors.grey.shade200,
      hourMinuteTextColor: Colors.black,
      hourMinuteTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      dayPeriodTextColor: Colors.black,
      dayPeriodColor: Colors.grey.shade200,
      dayPeriodTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      dialHandColor: Colors.blue,
      dialBackgroundColor: Colors.grey.shade200,
      dialTextColor: Colors.black,
      entryModeIconColor: Colors.black,
    ),
  );
}
