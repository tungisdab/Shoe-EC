import 'dart:developer';

import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final XFile? imageUrl = await picker.pickImage(
      source: source, imageQuality: 80);
  
  if (imageUrl != null) {
    return await imageUrl.readAsBytes();
  } else {
    log('No image selected.');
    return null;
  }
}