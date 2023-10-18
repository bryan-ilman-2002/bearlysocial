// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:polkatalk/functions/getters/app_colors.dart';
// import 'package:polkatalk/functions/getters/heavy_shadow.dart';
// import 'package:polkatalk/functions/getters/light_shadow.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SocialMediaLinks extends StatelessWidget {
//   const SocialMediaLinks({super.key});

//   void _launchURL(String url) async {
//     await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//   }

//   final String url = 'https://www.google.com';

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () => _launchURL(url),
//           onLongPress: () {
//             Clipboard.setData(ClipboardData(text: url));
//           },
//           child: Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       'unverified',
//                       style: TextStyle(
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: tinyGray,
//                   // border: Border.all(
//                   //   color: moderateGray,
//                   // ),
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     heavyShadow,
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     SvgPicture.asset(
//                       'assets/svgs/instagram_icon.svg',
//                       width: 24,
//                       height: 24,
//                       color: moderateGray,
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     const Expanded(
//                       child: Text(
//                         "Click here to visit Google.",
//                         style: TextStyle(
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                     SvgPicture.asset(
//                       'assets/svgs/warning_icon.svg',
//                       width: 24,
//                       height: 24,
//                       color: moderateGray,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const Row(),
//         const Row(),
//         const Row(),
//         const Row(),
//       ],
//     );
//   }
// }
