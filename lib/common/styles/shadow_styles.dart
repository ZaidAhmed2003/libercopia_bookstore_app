import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/utils/constants/colors.dart';

class LShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: LColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 10),
  );

  static final horizontalProductShadow = BoxShadow(
    color: LColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}
