import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'table.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _imageFile;

  Future<void> _uploadImage(File imageFile) async {
    if (imageFile != null) {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);
      final url = Uri.parse('http://192.168.0.188:5000/upload-image');
      final response = await http.post(url, body: {'image': base64Image});

      if (response.statusCode == 200) {
        final xmlData = response.body;
        print(xmlData);
        // Navigate to the XmlDataPage with the XML data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => XmlDataPage(xmlData: xmlData),
          ),
        );
      } else {
        print('Failed to upload image');
      }
    }
  }


    Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _uploadImage(_imageFile!);
    }
  }

  Future<void> _openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _uploadImage(_imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
        backgroundColor: Colors.red.shade500,
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

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_editor/image_editor.dart';
// import 'package:image_picker/image_picker.dart' as image_picker;
// import 'excel_display_page.dart';
// // import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
//
// class CameraPage extends StatefulWidget {
//   const CameraPage({Key? key}) : super(key: key);
//
//   @override
//   _CameraPageState createState() => _CameraPageState();
// }
//
// class _CameraPageState extends State<CameraPage> {
//   File? _imageFile;
//
//
//   Future<void> _openCamera() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(
//         source: image_picker.ImageSource.camera);
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//       if (_imageFile != null) {
//         final bytes = await _imageFile!.readAsBytes();
//         final base64Image = base64Encode(bytes);
//
//         final url = Uri.parse('http://192.168.206.124:5000/upload-image');
//         final response = await http.post(url, body: {'image': base64Image});
//
//         if (response.statusCode == 200) {
//           print('Image uploaded successfully');
//         } else {
//           print('Failed to upload image');
//         }
//       }
//     }
//
//     Future<void> _openGallery() async {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(
//           source: image_picker.ImageSource.gallery);
//
//       if (pickedFile != null) {
//         setState(() {
//           _imageFile = File(pickedFile.path);
//         });
//         if (_imageFile != null) {
//           final bytes = await _imageFile!.readAsBytes();
//           final base64Image = base64Encode(bytes);
//
//           final url = Uri.parse('http://192.168.0.188:5000/upload-image');
//           final response = await http.post(url, body: {'image': base64Image});
//
//           if (response.statusCode == 200) {
//             print('Image uploaded successfully');
//           } else {
//             print('Failed to upload image');
//           }
//         }
//       }
//
//       Future<void> _storeImage() async {
//         if (_imageFile != null) {
//           final bytes = await _imageFile!.readAsBytes();
//           final base64Image = base64Encode(bytes);
//
//           final url = Uri.parse('http://192.168.0.188:5000/upload-image');
//           final response = await http.post(url, body: {'image': base64Image});
//
//           if (response.statusCode == 200) {
//             print('Image uploaded successfully');
//             final fileBytes = response.bodyBytes;
//             Directory directory = await getApplicationDocumentsDirectory();
//             String filePath = '${directory.path}/output.xlsx';
//             File file = File(filePath);
//             await file.writeAsBytes(bytes);
//
//             print('Excel file saved to: $filePath');
//
//             // Navigate to the NewPage after storing the image
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => exceldisplay()),
//             );
//           } else {
//             print('Failed to upload image');
//           }
//         }
//       }
//
//       @override
//       Widget build(BuildContext context) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('Camera'),
//             backgroundColor: Colors.grey[800],
//           ),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _imageFile == null
//                     ? const Text(
//                   'No image selected.',
//                   style: TextStyle(color: Colors.white),
//                 )
//                     : Image.file(_imageFile!),
//
//                 if (_imageFile != null)
//                   ElevatedButton(
//                     onPressed: _storeImage,
//                     child: const Text('Upload Image'),
//                   ),
//               ],
//             ),
//           ),
//           floatingActionButton: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               FloatingActionButton(
//                 heroTag: "camera_option",
//                 onPressed: _openCamera,
//                 tooltip: 'Open Camera',
//                 backgroundColor: Colors.red[600],
//                 child: const Icon(Icons.camera_alt),
//               ),
//               const SizedBox(width: 16.0),
//               FloatingActionButton(
//                 heroTag: "gallery_option",
//                 onPressed: _openGallery,
//                 tooltip: 'Open Gallery',
//                 backgroundColor: Colors.red[600],
//                 child: const Icon(Icons.photo_library),
//               ),
//             ],
//           ),
//         );
//       }
//     }
//   }

