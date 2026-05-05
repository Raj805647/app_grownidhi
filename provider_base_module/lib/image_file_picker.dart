import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> pickImage({bool fromCamera = false}) async {
    final XFile? image = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 70,
    );

    return image?.path;
  }
}

class FilePickerService {
  static Future<String?> pickFile() async {
    final result = await FilePicker.pickFiles();

    if (result != null && result.files.single.path != null) {
      return result.files.single.path!;
    }
    return null;
  }
}


Future<String?> showPickerDialog(BuildContext context) async {
  final choice = await showModalBottomSheet<String>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Camera"),
              onTap: () => Navigator.pop(context, "camera"),
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Gallery"),
              onTap: () => Navigator.pop(context, "gallery"),
            ),
          ],
        ),
      );
    },
  );

  if (choice == null) return null;

  if (choice == "camera") {
    return await ImagePickerService.pickImage(fromCamera: true);
  } else if (choice == "gallery") {
    return await ImagePickerService.pickImage();
  } else {
    return await FilePickerService.pickFile();
  }
}