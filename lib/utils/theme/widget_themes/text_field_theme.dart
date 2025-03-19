import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class LTextFormFieldTheme {
  LTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: LColors.darkGrey,
    suffixIconColor: LColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
      fontSize: LSizes.fontSizeMd,
      color: LColors.black,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: LSizes.fontSizeSm,
      color: LColors.black,
    ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      color: LColors.black.withOpacity(0.8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(LSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: LColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(LSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: LColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(LSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: LColors.dark),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(LSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: LColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(LSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: LColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: LColors.darkGrey,
    suffixIconColor: LColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
      fontSize: LSizes.fontSizeMd,
      color: LColors.white,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: LSizes.fontSizeSm,
      color: LColors.white,
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      color: LColors.white.withOpacity(0.8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(LSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: LColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(LSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: LColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(LSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: LColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(LSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: LColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(LSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: LColors.warning),
    ),
  );
}
