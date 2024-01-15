import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class SelectImageService {
  final storageRef = FirebaseStorage.instance.ref();

  XFile? _file;

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();

    _file = await imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file!.readAsBytes();
    }
  }

  Future<String> selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);

    img.Image? modifiedImage = img.decodeImage(image);

    int width = 800;
    int height = 800;

    img.Image resizedImage = img.copyResize(modifiedImage!, width: width, height: height);

    Uint8List compressedBytes = img.encodeJpg(resizedImage, quality: 85);

    final imageRef = storageRef.child(
        "images/${DateTime.now().millisecondsSinceEpoch.toString()}-${_file!.name}");

    try {
      await imageRef.putData(compressedBytes);

      String downloadURL = await imageRef.getDownloadURL();

      return downloadURL;
    } on FirebaseException catch (e) {
      // TODO: Throw error
      return '';
    }
  }
}
