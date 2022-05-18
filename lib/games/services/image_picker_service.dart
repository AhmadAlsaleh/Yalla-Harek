import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImagePickerService {
  static Future<String?> getFromGallery() async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    return pickedFile?.path;
  }

  static Future<String?> uploadFile(File image) async {
    try {
      final _firebaseStorage = FirebaseStorage.instance;
      final fileName = basename(image.path);
      var snapshot = await _firebaseStorage
          .ref()
          .child('images/$fileName-${DateTime.now()}')
          .putFile(image);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e, s) {
      log('$e - $s');
      return null;
    }
  }
}
