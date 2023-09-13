// import 'package:aad_oauth/aad_oauth.dart';
// import 'package:aad_oauth/model/config.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import '../../../main.dart';
// import '../api/microsoft_signin_screen_api.dart';
// import '../model/microsoft_signin_screen_model.dart';
// import 'microsoft_sign_in_web_view.dart';

// class MsSignInPage extends StatefulWidget {
//   MsSignInPage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   _MsSignInPageState createState() => _MsSignInPageState();
// }

// class _MsSignInPageState extends State<MsSignInPage> {
//   // Must configure flutter to start the web server for the app on
//   // the port listed below. In VSCode, this can be done with
//   // the following run settings in launch.json
//   // "args": ["-d", "chrome","--web-port", "8483"]
//   RxList<MicroSoftUsers> sharedFiles = <MicroSoftUsers>[].obs;
//   String? accessToken;
//   static final Config config = Config(
//     tenant: '1b56e005-1f09-45d3-bc8f-56007cae8a72',
//     clientId: '4cb749a1-c8fa-409d-ab66-93bb2d284338',
//     scope:
//         'profile openid offline_access Files.ReadWrite.Selected Files.ReadWrite.AppFolder Files.ReadWrite.All User.ReadBasic.All Sites.Manage.All Sites.Read.All Sites.ReadWrite.All User.Read User.ReadBasic.All User.ReadWrite email Files.Read Files.Read.All Files.Read.Selected Files.ReadWrite',
//     redirectUri: "msauth://com.example.yoooto/DTR%2FvbGfeX6Gm2OpKkrKKm0Swys%3D",
//     navigatorKey: navigatorKey,
//   );
//   // msauth://com.example.yoooto/DTR%2FvbGfeX6Gm2OpKkrKKm0Swys%3D
//   final AadOAuth oauth = AadOAuth(config);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 6.h,
//           ),
//           ListTile(
//             title: Text(
//               'Microsoft Sign In',
//               style: Theme.of(context).textTheme.headline5,
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.launch),
//             title: Text('Login'),
//             onTap: () {
//               login();
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.delete),
//             title: Text('Logout'),
//             onTap: () {
//               logout();
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.person),
//             title: Text('Users'),
//             onTap: () {
//               getUsers();
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.file_open),
//             title: Text('Files'),
//             onTap: () {
//               getUsersFile();
//             },
//           ),
//           Expanded(
//             child: Container(
//               child: Obx(
//                 () => ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: sharedFiles.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Padding(
//                       padding: EdgeInsets.only(top: 1.h, left: 2.w),
//                       child: InkWell(
//                         onTap: () {
//                           Get.to(() =>
//                               WebViewExample(url: sharedFiles[index].webUrl));
//                         },
//                         child: Container(
//                           padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   sharedFiles[index].name,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                       letterSpacing: 2,
//                                       fontSize: 15.sp),
//                                 ),
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Icon(Icons.link),
//                                     SizedBox(
//                                       width: 2.w,
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         sharedFiles[index].webUrl,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w400,
//                                             letterSpacing: 2,
//                                             fontSize: 8.sp),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 1.h,
//                                 ),
//                                 Divider(),
//                                 SizedBox(
//                                   height: 1.h,
//                                 ),
//                               ]),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void showError(dynamic ex) {
//     showMessage(ex.toString());
//   }

//   void showMessage(String text) {
//     var alert = AlertDialog(content: Text(text), actions: <Widget>[
//       TextButton(
//           child: const Text('Ok'),
//           onPressed: () {
//             Navigator.pop(context);
//           })
//     ]);
//     showDialog(context: context, builder: (BuildContext context) => alert);
//   }

//   void login() async {
//     try {
//       await oauth.login();

//       accessToken = await oauth.getAccessToken();
//       // String? idToken = await oauth.getIdToken();
//       // String url = await Oauth2Api.userinfoEmailScope;
//       // String profile = await Oauth2Api.userinfoProfileScope;
//       // String openidScope = await Oauth2Api.openidScope;
//       // print("idToken: $idToken");
//       // print("accessToken:  $accessToken");
//       // print("profile:  $profile");
//       // print("url:  $url");
//       // print("openidScope:  $openidScope");
//       await MicroSoftSignInApi.getProfiledata(token: accessToken!);

//       // showMessage('Logged in successfully, your access token: $accessToken');
//     } catch (e) {
//       showError(e);
//     }
//   }

//   void logout() async {
//     await oauth.logout();
//     showMessage('Logged out');
//   }

//   getUsers() async {
//     await MicroSoftSignInApi.getUsersData(token: accessToken!);
//   }

//   getUsersFile() async {
//     var result = await MicroSoftSignInApi.getUsersFiles(token: accessToken!);
//     sharedFiles.assignAll(result);
//   }
// }
