import 'dart:io';
import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/addSiteLocation/controller/AddSiteLocationRepository.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:attendance_admin/widgets/AnimatedButton.dart';
import 'package:attendance_admin/widgets/CatchImage.dart';
import 'package:attendance_admin/widgets/CustomTextFeilds.dart';
import 'package:attendance_admin/widgets/HexColor.dart';
import 'package:attendance_admin/widgets/MyClick.dart';
import 'package:attendance_admin/widgets/Regular.dart';
import 'package:attendance_admin/widgets/loading/LoadingType.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:attendance_admin/widgets/Imagepickerhandler.dart' as ig;

class AddSiteLocationController extends StatelessWidget {
  AddSiteLocationController(
      {Key? key, required this.iscomeFromHomeScreen, this.siteId = 0})
      : super(key: key);
  bool iscomeFromHomeScreen;
  int siteId;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AddSiteLocationRepository(),
      child: Consumer(
        builder: (context, AddSiteLocationRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return AddSiteLocation(
                  siteId: siteId, iscomeFromHomeScreen: iscomeFromHomeScreen);
            case Status.Unauthenticated:
              return AddSiteLocation(
                  siteId: siteId, iscomeFromHomeScreen: iscomeFromHomeScreen);
            case Status.Authenticating:
              return AddSiteLocation(
                  siteId: siteId, iscomeFromHomeScreen: iscomeFromHomeScreen);
            case Status.Authenticated:
              return AddSiteLocation(
                  siteId: siteId, iscomeFromHomeScreen: iscomeFromHomeScreen);
            case Status.error:
              return AddSiteLocation(
                siteId: siteId,
                iscomeFromHomeScreen: iscomeFromHomeScreen,
              );
          }
        },
      ),
    );
  }
}

class AddSiteLocation extends StatefulWidget {
  AddSiteLocation(
      {super.key, required this.iscomeFromHomeScreen, this.siteId = 0});
  bool iscomeFromHomeScreen;
  int siteId;

  @override
  State<AddSiteLocation> createState() => _AddSiteLocationState();
}

class _AddSiteLocationState extends State<AddSiteLocation>
    with TickerProviderStateMixin
    implements ig.ImagePickerListener {
  late File image;
  late AnimationController controller;
  late ig.ImagePickerHandler imagePicker;

  @override
  void initState() {
    // TODO: implement initState

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = ig.ImagePickerHandler(this, controller);
    imagePicker.init();

    final auth = context.read<AddSiteLocationRepository>();
    if (!widget.iscomeFromHomeScreen) {
      auth.getSiteById(context, widget.siteId).asStream().listen((event) {
        auth.siteNameController.text = auth.siteIndividualData!.siteName ?? '';
        auth.ownerNameController.text =
            auth.siteIndividualData!.ownerName ?? '';
        auth.contactNumberController.text =
            auth.siteIndividualData!.ownerContact ?? '';
        auth.addressController.text = auth.siteIndividualData!.address ?? '';
        auth.totalBudgetController.text =
            auth.siteIndividualData!.totalBudget.toString() ?? '';
        auth.startTimeController.text =
            auth.siteIndividualData!.startTime ?? '';
        auth.endTimeController.text = auth.siteIndividualData!.endTime ?? '';
        Customlog(event.toString());

        setState(() {
          auth.isCompleted =
              auth.siteIndividualData!.isCompleted ? true : false;
          Customlog('is completed : ${auth.isCompleted}');
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = context.watch<AddSiteLocationRepository>();
    return Scaffold(
      backgroundColor: light_black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                onTap: () {
                  Routesapp.gotoBackPage(context);
                },
                child: Container(
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Regular(text: 'Back', size: 15, color: Appcolor.blue),
                        const SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.keyboard_return_outlined,
                          color: lightblue,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      imagewithicon(auth, 'profile'),
                      const SizedBox(
                        height: 10,
                      ),
                      Regular(
                          text: 'Upload Site front Photo',
                          size: 16,
                          color: Appcolor.grey)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFeild(
                            Radius: 15,
                            width: size.width,
                            TextInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            errortext: auth.sitenameerror,
                            onchangeFuntion: auth.siteNameError,
                            obscureText: false,
                            isOutlineInputBorder: false,
                            outlineborder: InputBorder.none,
                            HintText: 'Site Name',
                            controller: auth.siteNameController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFeild(
                            HintText: 'Owner Name',
                            Radius: 15,
                            width: size.width,
                            TextInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            errortext: auth.ownernameerror,
                            onchangeFuntion: auth.ownerNameError,
                            obscureText: false,
                            isOutlineInputBorder: false,
                            outlineborder: InputBorder.none,
                            controller: auth.ownerNameController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyClick(
                            onPressed: () async {
                              TimeOfDay? selectedTime =
                                  await Util.showTimePickerDialog(
                                context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (selectedTime != null) {
                                Customlog(
                                    'Selected Time: ${selectedTime.format(context)}');
                                auth.startTimeController.text =
                                    selectedTime.format(context);
                              }
                            },
                            child: CustomTextFeild(
                              Radius: 15,
                              width: size.width,
                              TextInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              // errortext: auth.startTimeError,
                              // onchangeFuntion: auth.startError,
                              obscureText: false,
                              IsEnabled: false,
                              isOutlineInputBorder: false,
                              outlineborder: InputBorder.none,
                              HintText: 'Start Time',
                              controller: auth.startTimeController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyClick(
                            onPressed: () async {
                              TimeOfDay? selectedTime =
                                  await Util.showTimePickerDialog(
                                context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (selectedTime != null) {
                                Customlog(
                                    'Selected Time: ${selectedTime.format(context)}');
                                auth.endTimeController.text =
                                    selectedTime.format(context);
                              }
                            },
                            child: CustomTextFeild(
                              HintText: 'End Time',
                              Radius: 15,
                              width: size.width,
                              TextInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              // errortext: auth.endTimeError,
                              // onchangeFuntion: auth.endError,
                              obscureText: false,
                              IsEnabled: false,
                              isOutlineInputBorder: false,
                              outlineborder: InputBorder.none,
                              controller: auth.endTimeController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFeild(
                        HintText: 'Enter Address',
                        Radius: 15,
                        width: size.width,
                        TextInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        errortext: auth.addressError,
                        onchangeFuntion: auth.AddressError,
                        obscureText: false,
                        isOutlineInputBorder: false,
                        outlineborder: InputBorder.none,
                        controller: auth.addressController,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFeild(
                        HintText: 'Enter Total Budget',
                        Radius: 15,
                        width: size.width,
                        TextInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        errortext: auth.totalBudgetError,
                        onchangeFuntion: auth.budgetError,
                        obscureText: false,
                        isOutlineInputBorder: false,
                        outlineborder: InputBorder.none,
                        controller: auth.totalBudgetController,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFeild(
                        HintText: 'Enter Contact Number',
                        Radius: 15,
                        width: size.width,
                        TextInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        errortext: auth.phoneError,
                        onchangeFuntion: auth.phoneNumberError,
                        obscureText: false,
                        lenghtofInput: 10,
                        isOutlineInputBorder: false,
                        outlineborder: InputBorder.none,
                        controller: auth.contactNumberController,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: !widget.iscomeFromHomeScreen,
                child: CustomSwitch('Is Site Completed ?', auth.isCompleted,
                    (bool value) {
                  setState(() {
                    auth.isCompleted = value;
                    auth.UpdateSiteIsCompleted(
                        context, widget.siteId.toString());
                  });
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: MyAnimatedbutton(
                      lable: widget.iscomeFromHomeScreen
                          ? 'Add Site'
                          : 'Update Site',
                      height: 50,
                      width: 100,
                      bgcolor: Appcolor.blue,
                      color: Appcolor.White,
                      loadingwidget: AnimatedLoadingWidget.inkDrop(
                          color: Appcolor.White, size: 15),
                      isloading: auth.status == Status.Authenticating,
                      size: 15,
                      onPressed: () {
                        if (imageFile == null) {
                          Util.showmessagebar(
                              context, 'Please Upload Site Photo',
                              iserror: true);
                        } else if (auth.startTimeController.text.isEmpty) {
                          Util.showmessagebar(
                              context, 'Please select start time',
                              iserror: true);
                        } else if (auth.endTimeController.text.isEmpty) {
                          Util.showmessagebar(context, 'Please select end time',
                              iserror: true);
                        } else {
                          widget.iscomeFromHomeScreen
                              ? auth.addSiteValidation(
                                  context, true, widget.siteId.toString(),
                                  file: imageFile!)
                              : auth.addSiteValidation(
                                  context, false, widget.siteId.toString());
                        }
                      }))
            ]),
          ),
        ),
      ),
    );
  }

  File? imageFile;
  @override
  userImage(File image) {
    final auth = context.read<AddSiteLocationRepository>();
    // if (image != null) {
    //   String imagePath=image.path;
    //   Customlog('image  is this $imagePath');
    // }
    setState(() {
      imageFile = image;
      Customlog('image  is $imageFile');
    });
  }

  Widget imagewithicon(AddSiteLocationRepository auth, String? from) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Appcolor.White,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: HexColor("#F5F5F5").withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: auth.isprofileupdateStart
                ? SizedBox(
                    height: 100,
                    width: 100,
                    child: Center(
                      child: AnimatedLoadingWidget.spinCircle(
                        color: Appcolor.selectColor1,
                      ),
                    ),
                  )
                : imageFile != null
                    ? Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(imageFile!.path),
                                    scale: 10))))
                    : from == 'profile'
                        ? cacheImage(
                            '${imageFile?.path}',
                            100,
                            100,
                            BoxFit.cover,
                            shape: BoxShape.circle,
                          )
                        : cacheImage(
                            '',
                            100,
                            100,
                            BoxFit.cover,
                            shape: BoxShape.circle,
                          ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: MyClick(
              onPressed: () async {
                if (from == 'profile') {
                  if (await getCameraPermission()) {
                    imagePicker.showDialog(context);
                  }
                }
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: HexColor("#0F52BA"),
                  shape: BoxShape.circle,
                ),
                child: from == 'profile'
                    ? Icon(
                        Icons.camera_alt_outlined,
                        color: Appcolor.White,
                        size: 20,
                      )
                    : Icon(
                        Icons.edit,
                        color: Appcolor.White,
                        size: 20,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomSwitch(String text, bool isSelected, Function onClick) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Regular(
          text: text,
          size: 15,
          color: Appcolor.black,
          fontWeight: FontWeight.w700,
        ),
        // Spacer(),
        CupertinoSwitch(
            trackColor: Appcolor.grey,
            activeColor: Appcolor.blue,
            value: isSelected,
            onChanged: (value) {
              onClick(value);
            })
      ],
    );
  }

  Future<bool> getCameraPermission() async {
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
