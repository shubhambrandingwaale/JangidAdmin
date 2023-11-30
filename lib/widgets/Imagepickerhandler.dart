import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Imagepick.dart';

class ImagePickerHandler {
  late ImagePickerDialog imagePicker;
  late final AnimationController _controller;
  late final ImagePickerListener _listener;

  ImagePickerHandler(this._listener, this._controller);

  openCamera() async {
    imagePicker.dismissDialog();
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      _listener.userImage(File(image.path));
    }
  }

  openGallery() async {
    imagePicker.dismissDialog();
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      _listener.userImage(File(image.path));
    }
  }

  void init() {
    imagePicker = ImagePickerDialog(this, _controller);
    imagePicker.initState();
  }

  showDialog(BuildContext context) {
    imagePicker.getImage(context);
  }
}

abstract class ImagePickerListener {
  userImage(File image);
}
