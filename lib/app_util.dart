import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/constants/constants.dart';
import 'package:groubuy/custom_modal.dart';
import 'package:groubuy/models/user_model.dart' as user_model;
import 'package:groubuy/services/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUtil with ChangeNotifier {
  static showLoader(BuildContext context, {String message}) {
    Navigator.of(context).push(CustomModal(
        child: SpinKitCubeGrid(
      color: MyColors.primaryColor,
    )));
  }

  static Future<File> pickImageFromGallery() async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      'jpg',
      'png',
    ]);

    if (result != null) {
      File file = File(result.files.single.path);
      return file;
    }

    return null;
  }

  static double progress;

  Future<String> uploadFile(File file, String path) async {
    if (file == null) return '';

    Reference storageReference = FirebaseStorage.instance.ref().child(path);

    UploadTask uploadTask;
    uploadTask = storageReference.putFile(file);

    uploadTask.snapshotEvents.listen((snapshot) {
      progress =
          snapshot.bytesTransferred.toDouble() / snapshot.totalBytes.toDouble();
      notifyListeners();
    }).onError((error) {
      // do something to handle error
    });
    await uploadTask;
    print('File Uploaded');
    String url = await storageReference.getDownloadURL();

    return url;
  }

  static showToast(String message) {
    Fluttertoast.showToast(
      timeInSecForIosWeb: 1,
      msg: message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static setUserVariablesByFirebaseUser(User user) async {
    user_model.User loggedInUser =
        await DatabaseService.getUserWithId(user?.uid);

    Constants.currentUser = loggedInUser;
    Constants.currentFirebaseUser = user;
    Constants.currentUserId = user?.uid;
    authStatus = AuthStatus.LOGGED_IN;

    Constants.isFacebookOrGoogleUser = false;
  }

  static Future<String> getLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('language');
  }

  static String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      AppUtil.showToast(
          language(en: "Email is Required", ar: 'يجب إدخال البريد الالكتروني'));
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      AppUtil.showToast(
          language(en: "Invalid Email", ar: 'البريد الإلكتروني غير صحيح'));
      return "Invalid Email";
    }
    return null;
  }

  static showAlertDialog({
    @required BuildContext context,
    String heading,
    String message,
    String firstBtnText,
    String secondBtnText,
    String thirdBtnText,
    Function firstFunc,
    Function secondFunc,
    Function thirdFunc,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: heading != null ? Text(heading) : null,
            content: Text(
              message,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: firstFunc,
                child: Text(
                  firstBtnText,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              secondBtnText != null
                  ? MaterialButton(
                      onPressed: secondFunc,
                      child: Text(
                        secondBtnText,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),
              thirdBtnText != null
                  ? MaterialButton(
                      onPressed: thirdFunc,
                      child: Text(
                        thirdBtnText,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),
            ],
          );
        });
  }
}

String language({String ar, String en}) {
  if (Constants.language == 'ar') {
    return ar;
  } else {
    return en;
  }
}

List<String> searchList(String text) {
  if (text == null || text.isEmpty) return null;
  List<String> list = [];
  for (int i = 1; i <= text.length; i++) {
    list.add(text.substring(0, i).toLowerCase());
  }
  return list;
}
