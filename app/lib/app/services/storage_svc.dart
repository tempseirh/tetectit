import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageSvc {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(XFile image) async {
    final String scansPath = 'scans-${image.name}';

    final ref = _storage.ref(scansPath);
    await ref.putFile(File(image.path));
    return await ref.getDownloadURL();
  }

  Future<void> deleteImage(String path) async {
    final ref = _storage.ref(path);
    await ref.delete();
  }

  Future<String> getImageUrl(String path) async {
    final ref = _storage.ref(path);
    return await ref.getDownloadURL();
  }
}
