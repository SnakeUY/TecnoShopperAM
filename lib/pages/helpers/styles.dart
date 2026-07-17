import 'package:flutter/material.dart';

class FormStyles {
  static double formRadius = 20;
  static double hzPadding = 37;
  static double vtFormPadding = 18;

  static const Color primaryColor = Color(0xff00b27f);
  static const Color secondaryColor = Color(0xff007b80);
  static const Color baseColor = Color(0xff4a4a4a);

  static const Color lightGrayColor = Color(0xffe6e6e6);
  static const Color grayColor = Color(0xff505050);
  static const Color darkGrayColor = Color(0xff2d2d2d);

  static const Color helperColor = Color(0xff555555);
  static const Color optionalColor = Color(0xff007b80);
  static const Color errorColor = Color(0xffea6060);

  static final BoxDecoration formContainerDecoration = BoxDecoration(
    color: Colors.white,
    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
    border: Border.all(color: const Color(0xffd4d4d4)),
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(FormStyles.formRadius),
    ),
  );

  static TextStyle barlow = const TextStyle();
  static TextStyle baloo = const TextStyle();

  static TextStyle appTitle1 = barlow.copyWith(
    color: FormStyles.primaryColor,
    fontWeight: FontWeight.w800,
    fontSize: 8,
    letterSpacing: 1.95,
  );
  static TextStyle appTitle2 = baloo.copyWith(
      color: FormStyles.primaryColor,
      fontSize: 32,
      letterSpacing: -1.08,
      height: 1.1,
      decoration: TextDecoration.underline,
      decorationThickness: 1.2);

  static TextStyle formTitle = baloo.copyWith(color: FormStyles.primaryColor, height: 1, fontSize: 30, letterSpacing: 0.22);

  static TextStyle formSection =
      barlow.copyWith(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5, color: secondaryColor);

  static TextStyle imageBatch =
      barlow.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 0.5);

  static TextStyle productName =
      barlow.copyWith(fontWeight: FontWeight.w600, color: FormStyles.secondaryColor, letterSpacing: 0.63, fontSize: 20);
  static TextStyle productPrice =
      barlow.copyWith(fontWeight: FontWeight.w500, fontSize: 20, height: 1.8, letterSpacing: 0.63);
  static TextStyle orderLabel =
      barlow.copyWith(fontSize: 14, color: FormStyles.baseColor, letterSpacing: 0.44, fontWeight: FontWeight.w500);
  static TextStyle orderPrice =
      barlow.copyWith(fontSize: 14, color: FormStyles.baseColor, letterSpacing: 0.44, fontWeight: FontWeight.w600);
  static TextStyle orderTotalLabel =
      barlow.copyWith(fontSize: 16, color: FormStyles.baseColor, letterSpacing: 0.5, fontWeight: FontWeight.w500);
  static TextStyle orderTotal =
      barlow.copyWith(fontSize: 20, color: FormStyles.baseColor, letterSpacing: 0.63, fontWeight: FontWeight.bold);

  static TextStyle helperStyle =
      barlow.copyWith(fontSize: 16, color: helperColor, letterSpacing: 0.5, fontWeight: FontWeight.w500);
  static TextStyle inputStyle =
      barlow.copyWith(fontSize: 16, color: FormStyles.baseColor, letterSpacing: 0.5, fontWeight: FontWeight.w500);

  static TextStyle submitButtonText =
      barlow.copyWith(fontSize: 16, color: Colors.white, letterSpacing: 0.44, fontWeight: FontWeight.bold);

  static TextStyle labelOptional =
      barlow.copyWith(fontSize: 10, color: optionalColor, fontWeight: FontWeight.w600, letterSpacing: 0.5);
  static TextStyle labelNotValid =
      barlow.copyWith(fontSize: 8, color: errorColor, fontWeight: FontWeight.bold, letterSpacing: 1);
  static TextStyle labelRequired =
      barlow.copyWith(fontSize: 6, color: grayColor, fontWeight: FontWeight.bold, letterSpacing: .5);

  static TextStyle textButton =
      barlow.copyWith(fontSize: 16, color: FormStyles.secondaryColor, letterSpacing: 0.5, fontWeight: FontWeight.bold);
  static TextStyle optionsTitle =
      barlow.copyWith(fontSize: 20, color: FormStyles.darkGrayColor, letterSpacing: 0.63, fontWeight: FontWeight.w600);

  static TextStyle iconDropdown = baloo.copyWith(
    color: FormStyles.secondaryColor,
    fontSize: 27,
  );

  static TextStyle formError = barlow.copyWith(
      fontSize: 12, color: errorColor, fontStyle: FontStyle.italic, letterSpacing: 0.38, fontWeight: FontWeight.w500);

  static TextStyle inputLabel =
      barlow.copyWith(fontSize: 16, color: FormStyles.baseColor, letterSpacing: 0.5, fontWeight: FontWeight.w600);

  static InputDecoration getInputDecoration({String? helper}) {
    return InputDecoration(
      helperStyle: FormStyles.helperStyle,
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: FormStyles.secondaryColor)),
      errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: FormStyles.errorColor)),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: FormStyles.lightGrayColor)),
      border: const OutlineInputBorder(),
      errorStyle: const TextStyle(color: Colors.transparent),
      helperText: '',
      hintText: helper,
      hintStyle: FormStyles.helperStyle,
    );
  }
}
