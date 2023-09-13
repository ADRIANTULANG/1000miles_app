// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// import 'googleDrive.dart';

// class GoogleDriveView extends StatefulWidget {
//   const GoogleDriveView({super.key});

//   @override
//   State<GoogleDriveView> createState() => _GoogleDriveViewState();
// }

// class _GoogleDriveViewState extends State<GoogleDriveView> {
//   final drive = GoogleDrive();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: 100.h,
//         width: 100.w,
//         child: Center(
//           child: TextButton(
//               onPressed: () async {
//                 drive.getHttpClient();
//                 // FilePickerResult? result =
//                 //     await FilePicker.platform.pickFiles();
//                 // if (result != null) {
//                 //   File file = File(result.files.single.path.toString());
//                 //   print(result.files.single.identifier);
//                 //   print("absolute ${file.absolute}");
//                 //   print("url: ${file.uri}");
//                 //   print("parent ${file.parent}");
//                 //   print("name with extension ${result.files.single.name}");
//                 //   print("extension ${result.files.single.extension}");
//                 //   print("runtimeType: ${file.runtimeType}");

//                 //   // drive.upload(file: file);
//                 // } else {
//                 //   // User canceled the picker
//                 // }
//               },
//               child: Text("Pressed")),
//         ),
//       ),
//     );
//   }
// }
