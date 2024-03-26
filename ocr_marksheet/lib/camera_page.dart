import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

      final bytes = await _imageFile!.readAsBytes();
      final base64Image = base64Encode(bytes);

      final url = Uri.parse('http://192.168.232.124:5000/upload-image');
      final response = await http.post(url, body: {'image': base64Image});

      if(response.statusCode == 200){
        print('Image uploaded successfully');
      }else{
        print('Failed to upload image');
      }
    }
  }

  Future<void> _openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      final bytes = await _imageFile!.readAsBytes();
      final base64Image = base64Encode(bytes);

      final url = Uri.parse('http://192.168.232.124:5000/upload-image');
      final response = await http.post(url, body: {'image': base64Image});

      if(response.statusCode == 200){
        print('Image uploaded successfully');
      }else{
        print('Failed to upload image');
      }
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
         FloatingActionButton(
           heroTag: "camera_option",
           onPressed: _openCamera,
         tooltip: 'Open Camera',
           backgroundColor: Colors.red[600],
           child: Icon(Icons.camera_alt),
         ),
         SizedBox(width: 16.0),
         FloatingActionButton(
           heroTag: "gallery_option",
           onPressed: _openGallery,
           tooltip: 'Open Gallery',
           backgroundColor: Colors.red[600],
           child: Icon(Icons.photo_library),
         ),
       ],
     ),
    );
  }
}