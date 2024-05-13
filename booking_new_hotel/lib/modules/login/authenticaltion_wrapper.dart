// import 'package:booking_new_hotel/global/global_var.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../bottomTap/bottom_tap_screen.dart';
// import 'login_or_signup_screen.dart';
// import 'send_email_to_verify_screen.dart';


// // ignore: must_be_immutable
// class AuthenticationWrapper extends StatefulWidget {
//   bool gobalState;
//   AuthenticationWrapper({super.key, required this.gobalState});

//   @override
//   State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
// }

// class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
//   @override
//   Widget build(BuildContext context) {
//      return StreamBuilder(
//       stream: GlobalVar.authService.getAuthInstance().authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           User? user = snapshot.data as User?;
//            if (user != null && user.emailVerified) {
//               // User is signed in and email is verified, navigate to the homepage
//               return const BottomTapScreen();
//             }
//             else
//             {
//               return SendEmailToVerify();
//             }
//         }
//         else
//         {
//             return LoginOrSignUpScreen(gobalState: widget.gobalState);
//         }
//       },
//     );
//   }
// }