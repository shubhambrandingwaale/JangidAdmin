// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables, avoid_print, empty_catches

import 'dart:developer';

import 'package:attendance_admin/utility/CustomFont.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFeild extends StatelessWidget {
  CustomTextFeild(
      {Key? key,
      required this.HintText,
      this.PrefixIcon,
      required this.Radius,
      this.SurfixIcon,
      this.SurfixIconPerssedIcon,
      this.ValidationErrorMessage,
      required this.width,
      this.controller,
      this.onComplete,
      required this.TextInputAction,
      required this.keyboardType,
      required this.obscureText,
      required this.isOutlineInputBorder,
      this.label,
      this.maxlength,
      this.maxline,
      this.IsEnabled,
      this.lenghtofInput,
      this.Innercolor,
      this.IsAadhar,
      this.height,
      this.minline,
      this.FocusborderColor,
      this.onchangeFuntion,
      this.TextStyleforLabelText,
      this.TextStyleForHintText,
      this.decoration,
      this.errortext,
      this.contentPadding,
      this.outlineborder,
      this.textCapitalization,
      this.cursorColor,
      this.styleoftextfeild,
      this.onTap,
      this.errortextstyle,
      this.IsCreditCard})
      : super(key: key);
  int? lenghtofInput;
  double width, Radius;
  String HintText;
  String? ValidationErrorMessage;
  Widget? label;
  Widget? SurfixIcon, PrefixIcon;
  Function? SurfixIconPerssedIcon;
  TextEditingController? controller;
  TextInputType keyboardType;
  bool obscureText;
  double? height;
  bool? IsEnabled;
  TextStyle? TextStyleforLabelText, TextStyleForHintText;
  dynamic Innercolor;
  EdgeInsetsGeometry? contentPadding;
  var TextInputAction;
  int? maxline, minline, maxlength;
  bool isOutlineInputBorder;
  bool? IsAadhar = false;
  bool? IsCreditCard;
  Function? onchangeFuntion;
  Color? FocusborderColor;
  String? errortext;
  Decoration? decoration;
  InputBorder? outlineborder;
  Color? cursorColor;
  TextStyle? styleoftextfeild;
  TextStyle? errortextstyle;
  Function()? onTap;
  TextCapitalization? textCapitalization;
  Function(String? c)? onComplete;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          width: width,
          decoration: decoration ??
              BoxDecoration(
                  borderRadius: BorderRadius.circular(Radius),
                  color: Innercolor ?? Colors.white),
          child: TextField(
            onTap: onTap ??
                () {
                  log('onTap');
                },
            cursorColor: cursorColor,
            maxLines: maxline,
            textCapitalization:
                textCapitalization ?? TextCapitalization.sentences,
            minLines: minline,
            textAlign: TextAlign.start,
            maxLength: maxlength, // set the maximum character limit to 10
            // decoration: InputDecoration(
            //   labelText: 'Enter text',
            //   border: OutlineInputBorder(),
            // ),
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: TextInputAction,
            style: styleoftextfeild ??
                TextStyle(color: Colors.black, fontSize: 16),
            inputFormatters: keyboardType == TextInputType.phone
                ? IsAadhar == true
                    ? [
                        CustomInputFormatter(),
                        LengthLimitingTextInputFormatter(14)
                      ]
                    : IsCreditCard == true && IsAadhar != true
                        ? [
                            CustomInputFormatter(),
                            LengthLimitingTextInputFormatter(19)
                          ]
                        : [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            LengthLimitingTextInputFormatter(
                                lenghtofInput ?? 10)
                          ]
                : keyboardType == TextInputType.number
                    ? [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
                        LengthLimitingTextInputFormatter(lenghtofInput ?? 100)
                      ]
                    : keyboardType == TextInputType.name
                        ? [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z ]'))
                          ]
                        : [FilteringTextInputFormatter.singleLineFormatter],
            onChanged: (String errormessage) {
              try {
                onchangeFuntion!(errormessage);
              } catch (e) {}
            },
            onSubmitted: onComplete,
            decoration: InputDecoration(
                isCollapsed: true,
                focusedBorder: !isOutlineInputBorder
                    ? InputBorder.none
                    : OutlineInputBorder(
                        borderSide:
                            BorderSide(color: FocusborderColor ?? Colors.grey),
                        borderRadius: BorderRadius.circular(Radius),
                      ),
                contentPadding: contentPadding ??
                    EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                labelStyle:
                    TextStyleforLabelText ?? TextStyle(color: Colors.black),
                label: label,
                enabled: IsEnabled ?? true,
                prefixIcon: PrefixIcon,
                suffixIcon: SurfixIcon,
                hintText: HintText,
                hintStyle: TextStyleForHintText ??
                    TextStyle(color: Colors.grey.shade600),
                border: isOutlineInputBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Radius))
                    : outlineborder),
          ),
        ),
        (errortext ?? '').isEmpty
            ? SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  FittedBox(
                      child: Text(
                    errortext ?? "",
                    textAlign: TextAlign.start,
                    style: errortextstyle ??
                        TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: CustomFont.poppins,
                            fontWeight: CustomFontWeight.regular),
                  ))
                ],
              )
      ],
    );
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    text = text.replaceAll(RegExp(r'(\s)|(\D)'), '');

    int offset = newValue.selection.start;

    var subText =
        newValue.text.substring(0, offset).replaceAll(RegExp(r'(\s)|(\D)'), '');

    int realTrimOffset = subText.length;

// if (newValue.selection.baseOffset == 0) {

// return newValue;

// }

    var buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);

      var nonZeroIndex = i + 1;

      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(
            ' '); // Replace this with anything you want to put after each 4 numbers
      }

// This block is only executed once

      if (nonZeroIndex % 4 == 0 &&
          subText.length == nonZeroIndex &&
          nonZeroIndex > 4) {
        int moveCursorToRigth = nonZeroIndex ~/ 4 - 1;

        realTrimOffset += moveCursorToRigth;
      }

// This block is only executed once

      if (nonZeroIndex % 4 != 0 && subText.length == nonZeroIndex) {
        int moveCursorToRigth = nonZeroIndex ~/ 4;

        realTrimOffset += moveCursorToRigth;
      }
    }

    var string = buffer.toString();

    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: realTrimOffset));
  }
}
