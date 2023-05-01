import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:netshop/Utils/helpers/Sessions.dart';
import 'package:netshop/component/%20widgets/Input_text_field.dart';
import 'package:netshop/constants/App_style/AppColors.dart';

class ProfileController extends ChangeNotifier {
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();

  bool _loading = false;

  get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("User");

  XFile? _image;

  XFile? get images => _image;

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      imageUpload(context);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      imageUpload(context);
      notifyListeners();
    }
  }

  void pickImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape: Border.all(color: Colors.white),
            content: Container(
              height: 115,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.pop(context);
                      pickCameraImage(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text("Gallery"),
                    onTap: () {
                      Navigator.pop(context);
                      pickGalleryImage(context);
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }

  void imageUpload(BuildContext context) async {
    setLoading(true);

    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref("/profileImage" + SessionControler().userId.toString());
    firebase_storage.UploadTask uploadtask =
        storageRef.putFile(File(images!.path));

    await Future.value(uploadtask);
    final newurl = await storageRef.getDownloadURL();

    ref
        .child(SessionControler().userId.toString())
        .update({"profile": newurl.toString()}).then((value) {
      _image = null;
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }

  Future<void> showUserNameDialogAlert(BuildContext context, String name) {
    userNameController.text = name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(backgroundColor: AppColors.orange,
            title: Center(
                child: Text(
              "Update username",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  fontSize: 18),
            )),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: userNameController,
                    focusNode: userNameFocusNode,
                    validator: (value) {},
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Enter Name",
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                  )
                ],
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 30,
                  width: 70,
                  child: Center(
                    child: Text("Cancel",
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.successColor),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  ref.child(SessionControler().userId.toString()).update(
                      {"username": userNameController.text.toString()}).then((value) {
                    userNameController.clear();
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 30,
                  width: 70,
                  child: Center(
                    child: Text("OK",
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.successColor),
                ),
              ),
            ],
          );
        });
  }

  Future<void> showUserphoneDialogAlert(BuildContext context, String phone) {
    phoneController.text = phone;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.orange,
            title: Center(
                child: Text(
              "Update Phone",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  fontSize: 18),
            )),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(keyboardType: TextInputType.phone,
                    controller: phoneController,
                    focusNode: phoneFocusNode,
                    validator: (value) {},
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Enter Phone",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                  )
                ],
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 30,
                  width: 70,
                  child: Center(
                    child: Text("Cancel",
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.successColor),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  ref.child(SessionControler().userId.toString()).update(
                      {"phone": phoneController.text.toString()}).then((value) {
                    phoneController.clear();
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 30,
                  width: 70,
                  child: Center(
                    child: Text("OK",
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.successColor),
                ),
              ),
            ],
          );
        });
  }
}
