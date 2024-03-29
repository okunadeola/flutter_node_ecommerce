import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


void showSnackBar(BuildContext context, String text, [Color color = Colors.black]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: color,
        content: Text(text),
      ),
    );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'svg', 'WebP']);
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
