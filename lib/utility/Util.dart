// ignore_for_file: deprecated_member_use, file_names, use_build_context_synchronously, non_constant_identifier_names, unused_local_variable, duplicate_ignore, unused_field

import 'dart:io';
import 'package:attendance_admin/widgets/Regular.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/widgets/Button.dart';
import 'package:attendance_admin/widgets/Logoutalertbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Colors.dart';
import 'CustomFont.dart';

class Util {
  static String GOOGLE_API_KEY =
      const String.fromEnvironment('GOOGLE_API_KEY', defaultValue: '');

  static String apiKey = GOOGLE_API_KEY;
  static List<String> Language() {
    List<String> LANGLIST = [
      "Afrikaans",
      "Afrikaans (South Africa)",
      "Arabic",
      "Arabic (U.A.E.)",
      "Arabic (Bahrain)",
      "Arabic (Algeria)",
      "Arabic (Egypt)",
      "Arabic (Iraq)",
      "Arabic (Jordan)",
      "Arabic (Kuwait)",
      "Arabic (Lebanon)",
      "Arabic (Libya)",
      "Arabic (Morocco)",
      "Arabic (Oman)",
      "Arabic (Qatar)",
      "Arabic (Saudi Arabia)",
      "Arabic (Syria)",
      "Arabic (Tunisia)",
      "Arabic (Yemen)",
      "Azeri (Latin)",
      "Azeri (Latin) (Azerbaijan)",
      "Azeri (Cyrillic) (Azerbaijan)",
      "Belarusian",
      "Belarusian (Belarus)",
      "Bulgarian",
      "Bulgarian (Bulgaria)",
      "Bosnian (Bosnia and Herzegovina)",
      "Catalan",
      "Catalan (Spain)",
      "Czech",
      "Czech (Czech Republic)",
      "Welsh",
      "Welsh (United Kingdom)",
      "Danish",
      "Danish (Denmark)",
      "German",
      "German (Austria)",
      "German (Switzerland)",
      "German (Germany)",
      "German (Liechtenstein)",
      "German (Luxembourg)",
      "Divehi",
      "Divehi (Maldives)",
      "Greek",
      "Greek (Greece)",
      "English",
      "English (Australia)",
      "English (Belize)",
      "English (Canada)",
      "English (Caribbean)",
      "English (United Kingdom)",
      "English (Ireland)",
      "English (Jamaica)",
      "English (New Zealand)",
      "English (Republic of the Philippines)",
      "English (Trinidad and Tobago)",
      "English (United States)",
      "English (South Africa)",
      "English (Zimbabwe)",
      "Esperanto",
      "Spanish",
      "Spanish (Argentina)",
      "Spanish (Bolivia)",
      "Spanish (Chile)",
      "Spanish (Colombia)",
      "Spanish (Costa Rica)",
      "Spanish (Dominican Republic)",
      "Spanish (Ecuador)",
      "Spanish (Castilian)",
      "Spanish (Spain)",
      "Spanish (Guatemala)",
      "Spanish (Honduras)",
      "Spanish (Mexico)",
      "Spanish (Nicaragua)",
      "Spanish (Panama)",
      "Spanish (Peru)",
      "Spanish (Puerto Rico)",
      "Spanish (Paraguay)",
      "Spanish (El Salvador)",
      "Spanish (Uruguay)",
      "Spanish (Venezuela)",
      "Estonian",
      "Estonian (Estonia)",
      "Basque",
      "Basque (Spain)",
      "Farsi",
      "Farsi (Iran)",
      "Finnish",
      "Finnish (Finland)",
      "Faroese",
      "Faroese (Faroe Islands)",
      "French",
      "French (Belgium)",
      "French (Canada)",
      "French (Switzerland)",
      "French (France)",
      "French (Luxembourg)",
      "French (Principality of Monaco)",
      "Galician",
      "Galician (Spain)",
      "Gujarati",
      "Gujarati (India)",
      "Hebrew",
      "Hebrew (Israel)",
      "Hindi",
      "Hindi (India)",
      "Croatian",
      "Croatian (Bosnia and Herzegovina)",
      "Croatian (Croatia)",
      "Hungarian",
      "Hungarian (Hungary)",
      "Armenian",
      "Armenian (Armenia)",
      "Indonesian",
      "Indonesian (Indonesia)",
      "Icelandic",
      "Icelandic (Iceland)",
      "Italian",
      "Italian (Switzerland)",
      "Italian (Italy)",
      "Japanese",
      "Japanese (Japan)",
      "Georgian",
      "Georgian (Georgia)",
      "Kazakh",
      "Kazakh (Kazakhstan)",
      "Kannada",
      "Kannada (India)",
      "Korean",
      "Korean (Korea)",
      "Konkani",
      "Konkani (India)",
      "Kyrgyz",
      "Kyrgyz (Kyrgyzstan)",
      "Lithuanian",
      "Lithuanian (Lithuania)",
      "Latvian",
      "Latvian (Latvia)",
      "Maori",
      "Maori (New Zealand)",
      "FYRO Macedonian",
      "FYRO Macedonian (Former Yugoslav Republic of Macedonia)",
      "Mongolian",
      "Mongolian (Mongolia)",
      "Marathi",
      "Marathi (India)",
      "Malay",
      "Malay (Brunei Darussalam)",
      "Malay (Malaysia)",
      "Maltese",
      "Maltese (Malta)",
      "Norwegian (Bokm?l)",
      "Norwegian (Bokm?l) (Norway)",
      "Dutch",
      "Dutch (Belgium)",
      "Dutch (Netherlands)",
      "Norwegian (Nynorsk) (Norway)",
      "Northern Sotho",
      "Northern Sotho (South Africa)",
      "Punjabi",
      "Punjabi (India)",
      "Polish",
      "Polish (Poland)",
      "Pashto",
      "Pashto (Afghanistan)",
      "Portuguese",
      "Portuguese (Brazil)",
      "Portuguese (Portugal)",
      "Quechua",
      "Quechua (Bolivia)",
      "Quechua (Ecuador)",
      "Quechua (Peru)",
      "Romanian",
      "Romanian (Romania)",
      "Russian",
      "Russian (Russia)",
      "Sanskrit",
      "Sanskrit (India)",
      "Sami (Northern)",
      "Sami (Northern) (Finland)",
      "Sami (Skolt) (Finland)",
      "Sami (Inari) (Finland)",
      "Sami (Northern) (Norway)",
      "Sami (Lule) (Norway)",
      "Sami (Southern) (Norway)",
      "Sami (Northern) (Sweden)",
      "Sami (Lule) (Sweden)",
      "Sami (Southern) (Sweden)",
      "Slovak",
      "Slovak (Slovakia)",
      "Slovenian",
      "Slovenian (Slovenia)",
      "Albanian",
      "Albanian (Albania)",
      "Serbian (Latin) (Bosnia and Herzegovina)",
      "Serbian (Cyrillic) (Bosnia and Herzegovina)",
      "Serbian (Latin) (Serbia and Montenegro)",
      "Serbian (Cyrillic) (Serbia and Montenegro)",
      "Swedish",
      "Swedish (Finland)",
      "Swedish (Sweden)",
      "Swahili",
      "Swahili (Kenya)",
      "Syriac",
      "Syriac (Syria)",
      "Tamil",
      "Tamil (India)",
      "Telugu",
      "Telugu (India)",
      "Thai",
      "Thai (Thailand)",
      "Tagalog",
      "Tagalog (Philippines)",
      "Tswana",
      "Tswana (South Africa)",
      "Turkish",
      "Turkish (Turkey)",
      "Tatar",
      "Tatar (Russia)",
      "Tsonga",
      "Ukrainian",
      "Ukrainian (Ukraine)",
      "Urdu",
      "Urdu (Islamic Republic of Pakistan)",
      "Uzbek (Latin)",
      "Uzbek (Latin) (Uzbekistan)",
      "Uzbek (Cyrillic) (Uzbekistan)",
      "Vietnamese",
      "Vietnamese (Viet Nam)",
      "Xhosa",
      "Xhosa (South Africa)",
      "Chinese",
      "Chinese (S)",
      "Chinese (Hong Kong)",
      "Chinese (Macau)",
      "Chinese (Singapore)",
      "Chinese (T)",
      "Zulu",
      "Zulu (South Africa)"
    ];
    LANGLIST.sort();
    return LANGLIST;
  }

  static bool validateEmail(String value) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  static bool isNumber(String input) {
    var replaceInput = input.replaceAll("+", "");
    final regex = RegExp(r'^\d+$'); //matches a string containing only digits
    return regex.hasMatch(replaceInput);
  }

  static bool validatePhoneNumber(String value) {
    var pattern = r'^[6-9][0-9]{9}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  // ignore: non_constant_identifier_names
  static bool empty_string(String value) {
    bool isValid = false;
    if (value.isNotEmpty) {
      isValid = true;
    }
    return isValid;
  }

  static bool customback(BuildContext context) {
    Navigator.pop(context);
    return true;
  }

  static void showalert(
    BuildContext context,
    Function onpress,
    String title,
  ) {
    var scrollController = ScrollController();
    var actionScrollController = ScrollController();
    var dia = CupertinoAlertDialog(
      title: Text(title),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            onpress();
            Navigator.of(context, rootNavigator: true).pop();
          },
          isDefaultAction: true,
          isDestructiveAction: false,
          child: const Text('Yes'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          isDefaultAction: true,
          isDestructiveAction: false,
          child: const Text('No'),
        ),
      ],
      scrollController: scrollController,
      actionScrollController: actionScrollController,
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return dia;
        });
  }

  static void error(BuildContext context, String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.transparent,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Regular(
                      isunderline: false,
                      text: msg,
                      size: 16,
                      color: Appcolor.red),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Mybutton(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        lable: 'OK',
                        bgcolor: Colors.red,
                        color: Colors.white,
                        size: 16,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )),
                ],
              ),
            ),
          );
        });
  }

  static void errorlogout(BuildContext context, String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.transparent,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Regular(
                      isunderline: false,
                      text: msg,
                      size: 16,
                      color: Colors.red),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Mybutton(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        lable: 'OK',
                        bgcolor: Colors.red,
                        color: Colors.white,
                        size: 16,
                        onPressed: () {
                          // logout(context);
                          Navigator.of(context).pop();
                        },
                      )),
                ],
              ),
            ),
          );
        });
  }

  static logout(BuildContext context) {
    saveUserId('');
    saveUserName('');
    saveUser('');
    savetoken('');
    Routesapp.gotoLoginPage(context);
  }

  static Future<bool> logoutalertnew(BuildContext context) async {
    bool islogout = false;
    await showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoActionSheet(
          message: Regular(
            text: 'Are you sure want to logout ?',
            size: 16,
            color: Colors.black,
            isunderline: false,
          ),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              child: Regular(
                text: 'Logout',
                size: 16,
                color: Colors.blue,
                isunderline: false,
              ),
              onPressed: () {
                logout(context);
                Navigator.pop(context);
                islogout = true;
                Routesapp.gotoLoginPage(context);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              islogout = false;
            },
            child: Regular(
              text: 'Cancel',
              size: 16,
              color: Colors.red,
              isunderline: false,
            ),
          )),
    );
    return islogout;
  }

  static showDatePickerDialoge(
      BuildContext context,
      DateTime initialDate,
      DateTime firstDate,
      DateTime lastDate,
      TextEditingController textEditingController) async {
    DateTime? p = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Appcolor.PrimaryColor, // <-- SEE HERE
              onPrimary: Appcolor.White, // <-- SEE HERE
              onSurface: Appcolor.grey, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Appcolor.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (p != null) {
      textEditingController.text = DateFormat("MM/dd/yyyy").format(p);
      // setState(() {
      // });
    }
  }

  static Future<TimeOfDay?> showTimePickerDialogin24hour(
    BuildContext context, {
    required TimeOfDay initialTime,
    TextEditingController? textEditingController,
  }) async {
    TimeOfDay? selectedTime = initialTime;

    selectedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (selectedTime != null && textEditingController != null) {
      // Format the selected time in 24-hour format
      textEditingController.text = _formatTime(selectedTime);
    }

    return selectedTime;
  }

  static String _formatTime(TimeOfDay time) {
    // Use HH:mm to format time in 24-hour format
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  static Future<TimeOfDay?> showTimePickerDialog(
    BuildContext context, {
    required TimeOfDay initialTime,
    TextEditingController? textEditingController,
  }) async {
    TimeOfDay? selectedTime = initialTime;

    selectedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (selectedTime != null && textEditingController != null) {
      textEditingController.text = selectedTime.format(context);
    }

    return selectedTime;
  }

  static void success(BuildContext context, String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.transparent,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Regular(
                      isunderline: false,
                      text: msg,
                      size: 16,
                      color: Appcolor.black),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Mybutton(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        lable: 'OK',
                        bgcolor: Colors.green,
                        color: Colors.white,
                        size: 16,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )),
                ],
              ),
            ),
          );
        });
    // Util.error(context, msg);
  }

  static const bool _serviceEnabled = false;

  static Future<bool> CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return true;
  }

  static Future<void> logoutalert(
      BuildContext context, String HeadingMessage) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.transparent,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Regular(
                    text: "Do you want to logout !!",
                    size: 16,
                    color: Colors.black,
                    isunderline: false,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: logoutalertbutton(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.20,
                              lable: 'No',
                              bgcolor: Colors.red,
                              color: Colors.white,
                              size: 16,
                            )),
                        TextButton(
                            onPressed: () {
                              logout(context);
                              Navigator.pop(context);
                            },
                            child: logoutalertbutton(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.20,
                              lable: 'Yes',
                              bgcolor: Colors.green,
                              color: Colors.white,
                              size: 16,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  static showmessagebar(BuildContext context, String message,
      {bool iserror = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: iserror ? Colors.red : Colors.green,
      content: Regular(
        text: message,
        size: 14,
        color: Appcolor.White,
        start: true,
        fontFamily: CustomFont.poppins,
        fontWeight: CustomFontWeight.regular,
      ),
      duration: const Duration(seconds: 2),
    ));
  }

  static String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(now);
  }

  static alertMessage(
      BuildContext context, String HeadingMessage, Function onpress,
      {Function()? oncancel}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.transparent,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Regular(
                    text: HeadingMessage,
                    size: 16,
                    color: Colors.black,
                    isunderline: false,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (oncancel != null) {
                              oncancel();
                            }
                          },
                          child: logoutalertbutton(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 3,
                            lable: 'No',
                            bgcolor: Colors.red,
                            color: Colors.white,
                            size: 16,
                          )),
                      TextButton(
                          onPressed: () {
                            onpress();
                            Navigator.pop(context);
                          },
                          child: logoutalertbutton(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 3,
                            lable: 'Yes',
                            bgcolor: Colors.green,
                            color: Colors.white,
                            size: 16,
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  // static Future<bool> urlLauncher(String profileUrl) async {
  //   if (await canLaunch(profileUrl)) {
  //     await launch(profileUrl, forceSafariVC: false, forceWebView: false);
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  static String formatTime(DateTime dateTime) {
    final timeZone = 'Asia/Kolkata';

    final timeZoneOffset = dateTime.timeZoneOffset;
    final newDateTime = dateTime.subtract(timeZoneOffset);
    final asiaKolkataDateTime =
        newDateTime.add(Duration(hours: 5, minutes: 30));

    final formatter = DateFormat('HH:mm:ss');
    return formatter.format(asiaKolkataDateTime);
  }

  static bool isURL(String url, String type) {
    if (type == 'FB') {
      RegExp urlPattern = RegExp(
        r"https?://(www\.)?facebook\.com/[a-zA-Z0-9_.-]+/?",
        caseSensitive: false,
      );
      return urlPattern.hasMatch(url);
    } else if (type == 'insta') {
      RegExp urlPattern = RegExp(
        r"https?://(www\.)?instagram\.com/[a-zA-Z0-9_.-]+/?",
        caseSensitive: false,
      );
      return urlPattern.hasMatch(url);
    } else if (type == 'linkedin') {
      RegExp urlPattern = RegExp(
        r"https?://(www\.)?linkedin\.com/in/[a-zA-Z0-9-]+/?",
        caseSensitive: false,
      );
      return urlPattern.hasMatch(url);
    } else {
      return false;
    }
  }

  static CustomAlert(BuildContext context, String HeadingMessage, String lebel1,
      String lebel2, Function onpress, var size,
      {Function()? oncancel, String? iconType}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.transparent,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Lottie.asset(getAnimatedIcon(iconType.toString()),
                  //     repeat: true, width: 80),
                  const SizedBox(
                    height: 30,
                  ),
                  Regular(
                    text: HeadingMessage,
                    size: 16,
                    color: Colors.black,
                    fontWeight: CustomFontWeight.medium,
                    fontFamily: CustomFont.poppins,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          onpress();
                          Navigator.pop(context);
                        },
                        child: Mybutton(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: Appcolor.travelCardGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            lable: lebel1,
                            height: 50,
                            width: size,
                            bgcolor: Appcolor.PrimaryColor,
                            color: Appcolor.White,
                            size: 16,
                            fontWeight: FontWeight.bold,
                            onPressed: () {
                              onpress();
                            }),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (oncancel != null) {
                            oncancel();
                          }
                        },
                        child: Mybutton(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Appcolor.black, width: 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            lable: lebel2,
                            height: 50,
                            width: size,
                            bgcolor: Appcolor.White,
                            color: Appcolor.PrimaryColor,
                            size: 16,
                            fontWeight: FontWeight.bold,
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  static Future<void> hideKeyboard(BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static Future<bool> Help_support(BuildContext context) async {
    bool islogout = false;
    await showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: Regular(
              isunderline: false,
              text: 'Want Help & Support on',
              size: 16,
              color: Colors.grey),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.email_outlined,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Regular(
                      isunderline: false,
                      text: 'Email',
                      size: 16,
                      color: Colors.blue),
                ],
              ),
              onPressed: () {
                // logout(context);
                // launch('mailto:loancomparesg@gmail.com?subject=');
                Navigator.pop(context);

                // Util.saveuser("");
                // FirebaseAuth.instance.signOut();
                // String user = FirebaseAuth.instance.currentUser!.uid;
                // print('$user');
                // Routesapp().gotologin(context);
              },
            ),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(
                  Icons.whatshot_outlined,
                  color: Colors.teal,
                ),
                const SizedBox(
                  width: 5,
                ),
                Regular(
                    isunderline: false,
                    text: 'Whats app',
                    size: 16,
                    color: Colors.blue),
              ]),
              onPressed: () {
                // logout(context);
                // launchWhatsapp('');
                Navigator.pop(context);
                // Util.saveuser("");
                // FirebaseAuth.instance.signOut();
                // String user = FirebaseAuth.instance.currentUser!.uid;
                // print('$user');
                // Routesapp().gotologin(context);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              islogout = false;
            },
            child: Regular(
                isunderline: false,
                text: 'Cancel',
                size: 16,
                color: Colors.red),
          )),
    );

    return islogout;
  }

  static Future<bool> saveUser(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
    return true;
  }

  static Future<bool> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    return true;
  }

  static Future<bool> saveUserLoginDetails(String model) async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    shared_User.setString('model', model);
    return true;
  }

  static Future<String> getsaveUserLoginDetails() async {
    bool id = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String
    // print("token ${prefs.get("token")}");
    final tocken = prefs.get("model") ?? '';
    return tocken.toString();
  }

  static Future<bool> savetoken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    return true;
  }

  static Future<bool> savetype(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('type', type);
    return true;
  }

  static Future<bool> savewelcome(String welcome) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('welcome', welcome);
    return true;
  }

  static Future<String> getwelcome() async {
    bool id = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String
    // print("token ${prefs.get("token")}");
    final tocken = prefs.get("welcome") ?? '';
    return tocken.toString();
  }

  static Future<bool> saveUserName(String Name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', Name);
    return true;
  }

  static Future<String> getUserName() async {
    bool id = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final tocken = prefs.get("name") ?? '';
    return tocken.toString();
  }

  static Future<bool> saveUserProfileImage(String Image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('image', Image);
    return true;
  }

  static Future<String> getUserProfileImage() async {
    bool id = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final tocken = prefs.get("image") ?? '';
    return tocken.toString();
  }

  static Future<bool> saveloginmodel(String modeldata) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('userData', modeldata);
    return true;
  }

  static Future<String> getUser() async {
    bool id = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String
    // print("token ${prefs.get("token")}");
    final tocken = prefs.get("user") ?? '';
    return tocken.toString();
  }

  static Future<String> getUserId() async {
    bool id = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final tocken = prefs.get("userId") ?? '';
    return tocken.toString();
  }

  static Future<String> gettoken() async {
    bool id = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String
    // print("token ${prefs.get("token")}");
    final tocken = prefs.get("token") ?? '';
    return tocken.toString();
  }

  static Future<void> setDeviceToken(String token) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('deviceId', token);
  }

  static Future<String?> getDeviceToken() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? deviceToken = sharedPref.getString('deviceId');
    return deviceToken;
  }

  static Future<bool> isKeyboardVisibility() async {
    return WidgetsBinding.instance.window.viewInsets.bottom > 0.0;
  }

  static UpdateAlert(
      BuildContext context, String HeadingMessage, String lebel1) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          Size size = MediaQuery.of(context).size;
          return Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.transparent,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset("assets/lottie/playStore.json",
                      repeat: true, width: 200, height: 100),
                  const SizedBox(
                    height: 30,
                  ),
                  Regular(
                    text: HeadingMessage,
                    size: 16,
                    color: Colors.black,
                    fontWeight: CustomFontWeight.medium,
                    fontFamily: CustomFont.poppins,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Mybutton(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: Appcolor.travelCardGradient,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          lable: lebel1,
                          height: 50,
                          width: size.width * 0.80,
                          bgcolor: Appcolor.PrimaryColor,
                          color: Appcolor.White,
                          size: 16,
                          fontWeight: FontWeight.bold,
                          onPressed: () async {
                            String playStoreUrl =
                                'https://play.google.com/store/apps/details?id=com.app.couchStayOnetick';
                            // if (await canLaunch(playStoreUrl)) {
                            //   await launch(playStoreUrl);
                            // } else {
                            //   throw 'Could not launch $playStoreUrl';
                            // }
                          }),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  static AddressUpdateDialoge(BuildContext context, Widget widget) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(2),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Routesapp.gotoBackPage(
                          context); // Close the dialog when the icon is pressed
                    },
                  ),
                ],
              ),
              widget,
            ],
          ),
        );
      },
    );
  }

  static Future<bool> getCameraPermission() async {
    if (await Permission.camera.status.isGranted) {
      return true;
    } else if (await Permission.camera.request().isGranted) {
      return true;
    } else if (await Permission.camera.request().isPermanentlyDenied) {
      await openAppSettings();
      return false;
    } else if (await Permission.camera.request().isDenied) {
      return false;
    } else {
      return false;
    }
  }
}

String getAnimatedIcon(String iconType) {
  switch (iconType) {
    case "Accept":
      return "assets/lottie/Accept.json";
    case "Decline":
      return "assets/lottie/Decline.json";
    default:
      return "assets/lottie/default.json";
  }
}
