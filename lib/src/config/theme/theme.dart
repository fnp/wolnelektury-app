import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

const String sourceSans3Family = 'SourceSans3';
const String sourceSerif4Family = 'SourceSerif4';

ThemeData get lightTheme => _baseTheme.copyWith(
  textTheme: _baseTheme.textTheme.apply(
    bodyColor: CustomColors.black,
    displayColor: CustomColors.black,
  ),
  dialogTheme: _lightModeDialog,
  inputDecorationTheme: _lightModeInput,
  brightness: Brightness.light,
  chipTheme: ChipThemeData(
    color: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return CustomColors.grey;
      }
      return CustomColors.white;
    }),
    side: BorderSide.none,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  ),
  scaffoldBackgroundColor: CustomColors.lightGrey,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: CustomColors.primaryYellowColor,
    onPrimary: CustomColors.black,
    secondary: CustomColors.secondaryBlueColor,
    onSecondary: CustomColors.white,
    error: CustomColors.red,
    onError: CustomColors.white,
    surface: CustomColors.lightGrey,
    onSurface: CustomColors.black,
    secondaryContainer: CustomColors.white,
    onSecondaryContainer: CustomColors.black,
    tertiaryContainer: CustomColors.white,
    onTertiaryContainer: CustomColors.black,
  ),
);

ThemeData get darkTheme => _baseTheme.copyWith(
  textTheme: _baseTheme.textTheme.apply(
    bodyColor: CustomColors.white,
    displayColor: CustomColors.white,
  ),
  dialogTheme: _darkModeDialog,
  inputDecorationTheme: _darkModeInput,
  brightness: Brightness.dark,
  chipTheme: ChipThemeData(
    color: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return CustomColors.darkModeGrey;
      }
      return CustomColors.black;
    }),
    side: BorderSide.none,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  ),
  scaffoldBackgroundColor: CustomColors.darkGrey,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: CustomColors.primaryYellowColor,
    onPrimary: CustomColors.white,
    secondary: CustomColors.secondaryBlueColor,
    onSecondary: CustomColors.white,
    error: CustomColors.red,
    onError: CustomColors.white,
    surface: CustomColors.darkGrey,
    onSurface: CustomColors.white,
    secondaryContainer: CustomColors.darkModeGrey,
    onSecondaryContainer: CustomColors.white,
    tertiaryContainer: CustomColors.black,
    onTertiaryContainer: CustomColors.darkModeGrey,
  ),
);

final _baseTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'SourceSans3',
  bottomSheetTheme: BottomSheetThemeData(
    modalBarrierColor: CustomColors.secondaryBlueColor.withValues(alpha: 0.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle: const TextStyle(
      color: CustomColors.red,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: 'SourceSans3',
    ),
    menuStyle: MenuStyle(
      backgroundColor: const WidgetStatePropertyAll(CustomColors.white),
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: CustomColors.green,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shadowColor: const WidgetStatePropertyAll(Colors.transparent),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(
          horizontal: Dimensions.veryLargePadding,
          vertical: Dimensions.mediumPadding,
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: CustomColors.white,
          fontFamily: 'SourceSans3',
        ),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
      backgroundColor: WidgetStateProperty.all<Color>(CustomColors.red),
      overlayColor: WidgetStateProperty.all<Color>(
        CustomColors.white.withValues(alpha: 0.2),
      ),
    ),
  ),
);

final yellowElevatedButton = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  padding: const EdgeInsets.symmetric(
    horizontal: Dimensions.veryLargePadding,
    vertical: Dimensions.mediumPadding,
  ),
  textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: CustomColors.black,
    fontFamily: 'SourceSans3',
  ),
  backgroundColor: CustomColors.primaryYellowColor,
);

final blueElevatedButton = yellowElevatedButton.copyWith(
  backgroundColor: const WidgetStatePropertyAll(
    CustomColors.secondaryBlueColor,
  ),
);

DialogThemeData _lightModeDialog = DialogThemeData(
  backgroundColor: Colors.white,
  barrierColor: CustomColors.secondaryBlueColor.withValues(alpha: 0.5),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(Dimensions.smallBorderRadius),
    ),
  ),
);

DialogThemeData _darkModeDialog = DialogThemeData(
  backgroundColor: CustomColors.darkGrey,
  barrierColor: CustomColors.secondaryBlueColor.withValues(alpha: 0.5),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(Dimensions.smallBorderRadius),
    ),
  ),
);

final _lightModeInput = InputDecorationTheme(
  contentPadding: const EdgeInsets.symmetric(
    horizontal: Dimensions.veryLargePadding,
    vertical: Dimensions.mediumPadding,
  ),
  hintStyle: const TextStyle(
    color: CustomColors.black,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'SourceSans3',
  ),
  fillColor: Colors.white,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.elementHeight / 2),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.elementHeight / 2),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.elementHeight / 2),
    borderSide: BorderSide.none,
  ),
);

final _darkModeInput = _lightModeInput.copyWith(
  fillColor: CustomColors.darkModeGrey,
  hintStyle: const TextStyle(
    color: CustomColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'SourceSans3',
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.elementHeight / 2),
    borderSide: const BorderSide(color: CustomColors.darkGrey),
  ),
);

final alternativeInput = _lightModeInput.copyWith(
  filled: false,
  contentPadding: EdgeInsets.zero,
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.elementHeight / 2),
    borderSide: const BorderSide(color: CustomColors.black),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.elementHeight / 2),
    borderSide: const BorderSide(color: CustomColors.black),
  ),
);
