import 'package:flutter/material.dart';
import 'package:ocr_marksheet/camera_page.dart';
import 'package:animate_do/animate_do.dart';
import 'adminpage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OCR Marksheet',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAdmin = false; // Default to user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.red.shade900,
              Colors.red.shade800,
              Colors.red.shade400,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeInUp(
                    duration: Duration(milliseconds: 1300),
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60),
                      FadeInUp(
                        duration: Duration(milliseconds: 1400),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Email or Phone number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      FadeInUp(
                        duration: Duration(milliseconds: 1500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "User",
                              style: TextStyle(
                                color: isAdmin ? Colors.grey : Colors.black,
                              ),
                            ),
                            Switch(
                              value: isAdmin,
                              onChanged: (value) {
                                setState(() {
                                  isAdmin = value;
                                });
                              },
                            ),
                            Text(
                              "Admin",
                              style: TextStyle(
                                color: isAdmin ? Colors.black : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      FadeInUp(
                        duration: Duration(milliseconds: 1600),
                        child: MaterialButton(
                          onPressed: () {
                            // Handle login logic here
                            if (isAdmin) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => AdminPage()),
                              );
                            } else {
                              // Navigate to homePage for user
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => homePage()),
                              );
                            }
                          },
                          height: 50,
                          color: Colors.red[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 colors: [
//                   Colors.red.shade900,
//                   Colors.red.shade800,
//                   Colors.red.shade400
//                 ]
//             )
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(height: 80,),
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),)),
//                   SizedBox(height: 10,),
//                   FadeInUp(duration: Duration(milliseconds: 1300), child: Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),)),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(30),
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(height: 60,),
//                       FadeInUp(duration: Duration(milliseconds: 1400), child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [BoxShadow(
//                                 color: Color.fromRGBO(225, 95, 27, .3),
//                                 blurRadius: 20,
//                                 offset: Offset(0, 10)
//                             )]
//                         ),
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                   border: Border(bottom: BorderSide(color: Colors.grey.shade200))
//                               ),
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                     hintText: "Email or Phone number",
//                                     hintStyle: TextStyle(color: Colors.grey),
//                                     border: InputBorder.none
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                   border: Border(bottom: BorderSide(color: Colors.grey.shade200))
//                               ),
//                               child: TextField(
//                                 obscureText: true,
//                                 decoration: InputDecoration(
//                                     hintText: "Password",
//                                     hintStyle: TextStyle(color: Colors.grey),
//                                     border: InputBorder.none
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                       SizedBox(height: 40,),
//                       FadeInUp(duration: Duration(milliseconds: 1500), child: Text("Forgot Password?", style: TextStyle(color: Colors.grey),)),
//                       SizedBox(height: 40,),
//                       FadeInUp(duration: Duration(milliseconds: 1600), child: MaterialButton(
//                         onPressed: () {
//                           // Navigate to homePage after successful login
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(builder: (context) => homePage()),
//                           );
//                         },
//                         height: 50,
//                         color: Colors.red[900],
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                         child: Center(
//                           child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                         ),
//                       )),
//                       SizedBox(height: 50,),
//                       // FadeInUp(duration: Duration(milliseconds: 1700), child: Text("Continue with social media", style: TextStyle(color: Colors.grey),)),
//                       // SizedBox(height: 30,),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('OCR MARKSHEET'),
        centerTitle: true,
        backgroundColor:  Colors.red.shade500,
      ),
      body: Center(
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraPage()),
            );
          },
          icon: Image.asset(
            'assets/icons/cameraicon.png',
            fit: BoxFit.cover, // Use BoxFit.cover instead of fixed width and height
          ),
        ),
      ),
    );
  }
}
//
// import 'package:flutter/material.dart';
// import 'package:ocr_marksheet/camera_page.dart';
//
//
// void main() => runApp(MaterialApp(
//   home: homePage(),
// )) ;
//
// class homePage extends StatelessWidget {
//   const homePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white70,
//       appBar: AppBar(
//         title: Text('OCR MARKSHEET'),
//         centerTitle: true,
//         backgroundColor: Colors.grey[800],
//       ),
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => CameraPage()),
//                   );
//                 },
//                 icon: Image.asset(
//                   'assets/icons/cameraicon.png',
//                   width: 500,
//                   height: 500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )
//     );
//   }
// }
//
//
