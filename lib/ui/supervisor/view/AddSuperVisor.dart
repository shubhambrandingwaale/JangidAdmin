import 'dart:io';

import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/supervisor/controller/SuperVisorRepository.dart';
import 'package:attendance_admin/utility/Api.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/CustomFont.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:attendance_admin/widgets/AnimatedButton.dart';
import 'package:attendance_admin/widgets/CatchImage.dart';
import 'package:attendance_admin/widgets/CustomTextFeilds.dart';
import 'package:attendance_admin/widgets/HexColor.dart';
import 'package:attendance_admin/widgets/Imagepickerhandler.dart' as ig;
import 'package:attendance_admin/widgets/MyClick.dart';
import 'package:attendance_admin/widgets/Regular.dart';
import 'package:attendance_admin/widgets/image_viewer_dialog/image_gallery.dart';
import 'package:attendance_admin/widgets/loading/LoadingType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddSuperVisorController extends StatelessWidget {
  AddSuperVisorController(
      {Key? key, required this.iscomeFromHomeScreen, this.superVisiorId = 0})
      : super(key: key);
  bool iscomeFromHomeScreen;
  int superVisiorId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SuperVisorRepository(),
      child: Consumer(
        builder: (context, SuperVisorRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return AddSuperVisor(
                iscomeFromHomeScreen: iscomeFromHomeScreen,
                superVisiorId: superVisiorId,
              );
            case Status.Unauthenticated:
              return AddSuperVisor(
                iscomeFromHomeScreen: iscomeFromHomeScreen,
                superVisiorId: superVisiorId,
              );
            case Status.Authenticating:
              return AddSuperVisor(
                iscomeFromHomeScreen: iscomeFromHomeScreen,
                superVisiorId: superVisiorId,
              );
            case Status.Authenticated:
              return AddSuperVisor(
                iscomeFromHomeScreen: iscomeFromHomeScreen,
                superVisiorId: superVisiorId,
              );
            case Status.error:
              return AddSuperVisor(
                iscomeFromHomeScreen: iscomeFromHomeScreen,
                superVisiorId: superVisiorId,
              );
          }
        },
      ),
    );
  }
}

class AddSuperVisor extends StatefulWidget {
  AddSuperVisor(
      {super.key, required this.iscomeFromHomeScreen, this.superVisiorId = 0});
  bool iscomeFromHomeScreen;
  int superVisiorId;

  @override
  State<AddSuperVisor> createState() => _AddSuperVisorState();
}

class _AddSuperVisorState extends State<AddSuperVisor>
    with TickerProviderStateMixin
    implements ig.ImagePickerListener {
  late File image;
  late AnimationController controller;
  late ig.ImagePickerHandler imagePicker;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = ig.ImagePickerHandler(this, controller);
    imagePicker.init();
    final auth = context.read<SuperVisorRepository>();
    if (!widget.iscomeFromHomeScreen) {
      auth
          .getSuperVisorById(context, widget.superVisiorId)
          .asStream()
          .listen((event) {
        auth.nameController.text = auth.listOfData["fullname"] ?? '';
        auth.userNameController.text = auth.listOfData["username"] ?? '';
        auth.contactNumberController.text = auth.listOfData["phone"] ?? '';
        auth.passwordController.text = auth.listOfData["password"] ?? '';
        auth.emailAddressController.text = auth.listOfData["email"] ?? '';
        // auth.selectedSiteId = auth.listOfData["site_assigned"] != ""
        //     ? auth.listOfData["site_assigned"]
        //     : 'null';
        Customlog(event.toString());
      });
      auth.getAllSite(context);
    } else {
      auth.getAllSite(context);
    }
    // TODO: implement initState
    super.initState();
  }

  XFile? nbo;
  Future<XFile?> OpenFilePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  List<XFile> _selectedImages = [];
  List<Myfile> myDocumentfiles = [];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final auth = context.read<SuperVisorRepository>();
    List<XFile> pickedImages = await picker.pickMultiImage();

    if (pickedImages != null && pickedImages.isNotEmpty) {
      if (!widget.iscomeFromHomeScreen) {
        pickedImages.forEach((xFile) {
          myDocumentfiles.add(Myfile('file', File(xFile.path)));
        });
        auth.UpdateDocuments(
            context, myDocumentfiles, widget.superVisiorId.toString());
      } else {
        setState(() {
          _selectedImages = pickedImages;
        });
      }
    }
  }

  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = context.watch<SuperVisorRepository>();
    return Scaffold(
      body: SafeArea(
        child: auth.status == Status.Authenticating
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      MainComponents().back(
                          'back', () => Routesapp.gotoHomeScreen(context)),
                      // MainComponents().Images(image, 120.0),
                      // MainComponents().txtview12("Upload Worker Photo"),
                      Visibility(
                        visible: !widget.iscomeFromHomeScreen,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
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
                                      text: 'Upload Profile Photo',
                                      size: 16,
                                      color: Appcolor.grey)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomTextFeild(
                                        HintText: 'Fullname',
                                        Radius: 5,
                                        width: size.width * 0.40,
                                        controller: auth.nameController,
                                        onchangeFuntion: auth.NameError,
                                        errortext: auth.nameerror,
                                        TextInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.name,
                                        obscureText: false,
                                        PrefixIcon: Icon(Icons.person),
                                        isOutlineInputBorder: true))),
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: CustomTextFeild(
                                        HintText: 'Username',
                                        Radius: 5,
                                        width: size.width * 0.40,
                                        textCapitalization:
                                            TextCapitalization.none,
                                        controller: auth.userNameController,
                                        onchangeFuntion: auth.userNameError,
                                        errortext: auth.userNameerror,
                                        TextInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.name,
                                        obscureText: false,
                                        IsEnabled: widget.iscomeFromHomeScreen,
                                        PrefixIcon: Icon(Icons.person),
                                        isOutlineInputBorder: true))),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomTextFeild(
                            HintText: 'Contact Number',
                            Radius: 5,
                            width: size.width * 0.88,
                            TextInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            lenghtofInput: 10,
                            controller: auth.contactNumberController,
                            onchangeFuntion: auth.phoneNumberError,
                            errortext: auth.phoneError,
                            PrefixIcon: Icon(Icons.phone),
                            isOutlineInputBorder: true),
                      ),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          child: CustomTextFeild(
                              HintText: 'Email Address',
                              Radius: 5,
                              width: size.width * 0.88,
                              TextInputAction: TextInputAction.done,
                              keyboardType: TextInputType.streetAddress,
                              controller: auth.emailAddressController,
                              onchangeFuntion: auth.emailError,
                              errortext: auth.emailAddressError,
                              obscureText: false,
                              PrefixIcon: const Icon(Icons.home_outlined),
                              isOutlineInputBorder: true)),
                      Container(
                          padding: const EdgeInsets.all(10.0),
                          child: CustomTextFeild(
                              HintText: 'Password',
                              Radius: 5,
                              width: size.width * 0.88,
                              TextInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              controller: auth.passwordController,
                              onchangeFuntion: auth.PasswordError,
                              errortext: auth.passwordError,
                              maxline: 1,
                              SurfixIcon: GestureDetector(
                                  onTap: () {
                                    auth.onVisibiltyChange();
                                  },
                                  child: Icon(
                                    auth.isHide
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Appcolor.grey,
                                  )),
                              obscureText: auth.isHide,
                              PrefixIcon: const Icon(Icons.password),
                              isOutlineInputBorder: true)),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: MainComponents().txtview18("Add Documents")),
                      Visibility(
                        visible: _selectedImages.isEmpty,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
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
                                      MyClick(
                                        onPressed: () {
                                          _pickImages();
                                        },
                                        child: const Icon(
                                          Icons.add_a_photo_outlined,
                                          size: 80,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Regular(
                                        text: 'Add Document',
                                        size: 16,
                                        color: Appcolor.grey,
                                        fontWeight: CustomFontWeight.semibold,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          height: _selectedImages.isEmpty ? 0 : 100,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showAnimatedDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      animationType: DialogTransitionType.scale,
                                      curve: Curves.fastOutSlowIn,
                                      duration: const Duration(seconds: 1),
                                      builder: (BuildContext context) {
                                        Customlog(
                                            'images is :${_selectedImages}');
                                        return PhotoGallery(
                                          imagesArray: _selectedImages,
                                          pageController: pageController,
                                          comeFrom: 'userDetails',
                                        );
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          10), // Adjust the spacing as needed
                                  child: Image.file(
                                      File(_selectedImages[index].path)),
                                ),
                              );
                            },
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: auth.listOfData != null &&
                            auth.listOfData["docs"] != null &&
                            auth.listOfData["docs"].isNotEmpty,
                        child: SizedBox(
                          height: 200, // Adjust the height as per your design
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: auth.listOfData == null
                                ? <Widget>[]
                                : (auth.listOfData["docs"] as List<dynamic>)
                                    .map<Widget>((url) {
                                    String updatedUrl =
                                        url.replaceFirst('/assets/images', '');
                                    Customlog('updated url is : $updatedUrl');
                                    return InkWell(
                                      onTap: () {
                                        showAnimatedDialog(
                                            barrierDismissible: true,
                                            context: context,
                                            animationType:
                                                DialogTransitionType.scale,
                                            curve: Curves.fastOutSlowIn,
                                            duration:
                                                const Duration(seconds: 1),
                                            builder: (BuildContext context) {
                                              return PhotoGallery(
                                                imagesArray:
                                                    auth.listOfData["docs"],
                                                pageController: pageController,
                                                comeFrom: 'userDetails',
                                              );
                                            });
                                      },
                                      child: Stack(children: [
                                        Container(
                                          width:
                                              180, // Adjust the image container width
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Appcolor.shimmer,
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: const BorderRadius
                                                    .vertical(
                                                    top: Radius.circular(10)),
                                                child: Image.network(
                                                  'https://jangid.nlaolympiad.in$url',
                                                  width:
                                                      180, // Adjust the image width
                                                  height:
                                                      200, // Adjust the image height
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 20,
                                          child: CircleAvatar(
                                            backgroundColor: Appcolor.White,
                                            radius: 20,
                                            child: MyClick(
                                              onPressed: () {
                                                auth.deleteImage(
                                                    context,
                                                    updatedUrl,
                                                    widget.superVisiorId
                                                        .toString());
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.delete,
                                                  color: Appcolor.red,
                                                  size: 25,
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    );
                                  }).toList(),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            value: auth.selectedSiteId,
                            borderRadius: BorderRadius.circular(10),
                            hint: MainComponents().txtview14("Select Site"),
                            isExpanded: true,
                            items: auth.siteListData.map((e) {
                              return DropdownMenuItem(
                                  value: e.id, child: Text(e.siteName));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                auth.selectedSiteId = value;
                                Customlog(
                                    'selectedSiteID is ${auth.selectedSiteId}');
                              });
                            },
                          ),
                        )),
                      ),
                      // Container(
                      //     padding: EdgeInsets.all(10),
                      //     alignment: Alignment.centerLeft,
                      //     child: MainComponents().txtview18("Add Documents")),
                      // Visibility(
                      //   visible: _selectedImages.isEmpty,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      //     child: Column(
                      //       children: <Widget>[
                      //         Container(
                      //           width: size.width,
                      //           decoration: BoxDecoration(
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.grey.withOpacity(0.5),
                      //                 spreadRadius: 2,
                      //                 blurRadius: 4,
                      //                 offset: const Offset(
                      //                     0, 2), // changes position of shadow
                      //               ),
                      //             ],
                      //             color: Colors.white,
                      //             borderRadius: BorderRadius.circular(20),
                      //           ),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(9.0),
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 MyClick(
                      //                   onPressed: () {
                      //                     _pickImages();
                      //                   },
                      //                   child: const Icon(
                      //                     Icons.add_a_photo_outlined,
                      //                     size: 80,
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   height: 10,
                      //                 ),
                      //                 Regular(
                      //                   text: 'Add Document',
                      //                   size: 16,
                      //                   color: Appcolor.grey,
                      //                   fontWeight: CustomFontWeight.semibold,
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //     height: _selectedImages.isEmpty ? 0 : 100,
                      //     margin: const EdgeInsets.symmetric(horizontal: 20),
                      //     child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: _selectedImages.length,
                      //       itemBuilder: (context, index) {
                      //         return InkWell(
                      //           onTap: () {
                      //             showAnimatedDialog(
                      //                 barrierDismissible: true,
                      //                 context: context,
                      //                 animationType: DialogTransitionType.scale,
                      //                 curve: Curves.fastOutSlowIn,
                      //                 duration: const Duration(seconds: 1),
                      //                 builder: (BuildContext context) {
                      //                   Customlog(
                      //                       'images is :${_selectedImages}');
                      //                   return PhotoGallery(
                      //                     imagesArray: _selectedImages,
                      //                     pageController: pageController,
                      //                     comeFrom: 'userDetails',
                      //                   );
                      //                 });
                      //           },
                      //           child: Padding(
                      //             padding: const EdgeInsets.symmetric(
                      //                 horizontal:
                      //                     10), // Adjust the spacing as needed
                      //             child: Image.file(
                      //                 File(_selectedImages[index].path)),
                      //           ),
                      //         );
                      //       },
                      //     )),
                      const SizedBox(
                        height: 20,
                      ),
                      MyAnimatedbutton(
                          lable: widget.iscomeFromHomeScreen
                              ? 'Add SuperVisor'
                              : 'Update SuperVisor',
                          height: 50,
                          width: size.width * 0.60,
                          bgcolor: blue,
                          color: Appcolor.White,
                          size: 15,
                          loadingwidget: AnimatedLoadingWidget.inkDrop(
                              color: Appcolor.White, size: 15),
                          isloading: auth.status == Status.Authenticating,
                          fontweigth: CustomFontWeight.semibold,
                          onPressed: () async {
                            _selectedImages.forEach((xFile) {
                              auth.myfiles
                                  .add(Myfile('file', File(xFile.path)));
                            });
                            // Customlog(auth.myfiles);
                            if (widget.iscomeFromHomeScreen) {
                              await auth.addSupervisorValidation(
                                context,
                                true,
                                widget.superVisiorId.toString(),
                                auth.myfiles,
                              );
                              if (auth.isAddSuperVisor) {
                                _uploadPictureDialog(auth, context);
                              }
                            } else {
                              auth.addSupervisorValidation(
                                context,
                                false,
                                widget.superVisiorId.toString(),
                                auth.myfiles,
                              );
                            }
                          })
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  File? imageFile;
  @override
  userImage(File image) {
    final auth = context.read<SuperVisorRepository>();
    if (image != null) {
      String imagePath = image.path;
      if (auth.supervisorIdBySite.isEmpty) {
        auth.uploadPic(context, image, widget.superVisiorId.toString(), false);
        Customlog('image  is this $imagePath');
      } else {
        Navigator.pop(context);
        auth.status == Status.Authenticating;
        auth.uploadPic(context, image, auth.supervisorIdBySite, true);
        Customlog('image  is this $imagePath');
      }
    }
    setState(() {
      imageFile = image;
      Customlog('image  is $imageFile');
    });
  }

  Widget imagewithicon(SuperVisorRepository auth, String? from) {
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
                            auth.listOfData != null &&
                                    auth.listOfData["profile_img"] != null
                                ? 'https://jangid.nlaolympiad.in${auth.listOfData["profile_img"]}'
                                : "",
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

  Future<void> _uploadPictureDialog(
      SuperVisorRepository auth, BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload Profile Picture'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                    height: 100,
                    width: 200,
                    child: imagewithicon(auth, 'profile')),
                // Add any additional content or widgets as needed.
              ],
            ),
          ),
          actions: <Widget>[
            // TextButton(
            //   child: Text('Cancel'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            // TextButton(
            //   child: Text('Upload'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
          ],
        );
      },
    );
  }
}
