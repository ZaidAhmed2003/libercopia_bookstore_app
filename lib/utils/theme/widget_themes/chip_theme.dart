import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class LChipTheme {
  LChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: LColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: LColors.black),
    selectedColor: LColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: LColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: LColors.darkerGrey,
    labelStyle: TextStyle(color: LColors.white),
    selectedColor: LColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: LColors.white,
  );
}
