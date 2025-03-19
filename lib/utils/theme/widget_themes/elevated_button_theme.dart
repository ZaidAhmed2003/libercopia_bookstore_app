import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class LElevatedButtonTheme {
  LElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: LColors.light,
      backgroundColor: LColors.primary,
      disabledForegroundColor: LColors.darkGrey,
      disabledBackgroundColor: LColors.buttonDisabled,
      side: const BorderSide(color: LColors.primary),
      padding: const EdgeInsets.symmetric(vertical: LSizes.buttonHeight),
      textStyle: const TextStyle(
        fontSize: 16,
        color: LColors.textWhite,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LSizes.buttonRadius),
      ),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: LColors.light,
      backgroundColor: LColors.primary,
      disabledForegroundColor: LColors.darkGrey,
      disabledBackgroundColor: LColors.darkerGrey,
      side: const BorderSide(color: LColors.primary),
      padding: const EdgeInsets.symmetric(vertical: LSizes.buttonHeight),
      textStyle: const TextStyle(
        fontSize: 16,
        color: LColors.textWhite,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LSizes.buttonRadius),
      ),
    ),
  );
}
