import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _imageFile;

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
        backgroundColor: Colors.grey[800],
      ),
      body: Center(
        child: _imageFile == null
            ? Text(
          'No image selected.',
          style: TextStyle(color: Colors.white),
        )
            : Image.file(_imageFile!),
      ),
     floatingActionButton: Row(
       mainAxisAlignment: MainAxisAlignment.end,
       children: [
         FloatingActionButton(onPressed: _openCamera,
         tooltip: 'Open Camera',
           child: Icon(Icons.camera_alt),
           backgroundColor: Colors.grey[800],
         ),
         SizedBox(width: 16.0),
         FloatingActionButton(
           onPressed: _openGallery,
           tooltip: 'Open Gallery',
           child: Icon(Icons.photo_library),
           backgroundColor: Colors.grey[800],
         ),
       ],
     ),
    );
  }
}