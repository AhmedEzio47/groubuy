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

  Future<String> uploadFile(
      File file, BuildContext context, String path) async {
    if (file == null) return '';

    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(path);
    print('storage path: $path');
    StorageUploadTask uploadTask;

    uploadTask = storageReference.putFile(file);
    uploadTask.events.listen((event) {
      progress = event.snapshot.bytesTransferred.toDouble() /
          event.snapshot.totalByteCount.toDouble();
      notifyListeners();
    }).onError((error) {
      // do something to handle error
    });
    await uploadTask.onComplete;
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
