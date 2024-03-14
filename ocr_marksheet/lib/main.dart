import 'package:flutter/material.dart';
import 'package:ocr_marksheet/camera_page.dart';


void main() => runApp(MaterialApp(
  home: homePage(),
)) ;

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        title: Text('OCR MARKSHEET'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraPage()),
                  );
                },
                icon: Image.asset(
                  'assets/icons/cameraicon.png',
                  width: 500,
                  height: 500,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}


