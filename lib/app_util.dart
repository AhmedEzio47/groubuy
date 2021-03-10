import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtil with ChangeNotifier {
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
}
