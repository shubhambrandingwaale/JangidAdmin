// import 'package:attendance_admin/Components/AllWorkersComponents.dart';
// import 'package:attendance_admin/Components/Colors.dart';
// import 'package:attendance_admin/Components/Image.dart';
// import 'package:attendance_admin/Components/MainComponents.dart';
// import 'package:flutter/material.dart';
//
// class SupervisorProfile extends StatefulWidget {
//   const SupervisorProfile({super.key});
//
//   @override
//   State<SupervisorProfile> createState() => _SupervisorProfileState();
// }
//
// class _SupervisorProfileState extends State<SupervisorProfile> {
//   String Choosevalue = 'Site1';
//   final li = [
//     'Site1',
//     'Site2',
//     'Site3',
//     'Site4',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: light_black,
//       body: SafeArea(
//         child: Container(
//           child: Container(
//             padding: EdgeInsets.all(10),
//             child: SafeArea(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Column(
//                   children: [
//                     MainComponents().wallet_back("Back", "1258", context),
//                     Container(
//                       child: Column(
//                         children: [
//                           MainComponents().Images(working, 120.0),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Container(
//                               padding: EdgeInsets.all(20),
//                               decoration:
//                                   MainComponents().decoration(Colors.white),
//                               child:
//                                   MainComponents().txtview14("Vishal Gautam"))
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                             child: Card(
//                                 child: AllWorkerComponents().homeCards(
//                                     "total Working in Hrs", "25000"))),
//                         Expanded(
//                             child: Card(
//                                 child: AllWorkerComponents()
//                                     .homeCards("total Payout ", "50000"))),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                             child: Container(
//                                 alignment: Alignment.center,
//                                 child: AllWorkerComponents().homeCards(
//                                     "total Working in Hrs", "-2500000"))),
//                         const SizedBox(
//                           width: 12,
//                         ),
//                         Expanded(
//                             child: Container(
//                                 decoration:
//                                     MainComponents().decoration(Colors.white),
//                                 child: MainComponents()
//                                     .Button("Send Budget", () => null, green))),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(10),
//                       alignment: Alignment.centerLeft,
//                       child: MainComponents().txtview15("Assigned to"),
//                     ),
//                     AllWorkerComponents().TableView(),
//                     Container(
//                         padding: EdgeInsets.all(13),
//                         alignment: Alignment.centerLeft,
//                         child: MainComponents().txtview15("Other Information")),
//                     Card(
//                       child: Column(
//                         children: [
//                           Container(
//                               padding: EdgeInsets.all(10),
//                               alignment: Alignment.centerLeft,
//                               child: MainComponents()
//                                   .txtview13("Contact Number : 985689855")),
//                           Container(
//                               padding: EdgeInsets.all(10),
//                               alignment: Alignment.centerLeft,
//                               child: MainComponents()
//                                   .txtview13("Daily wage : 100 rupees")),
//                           Container(
//                               padding: EdgeInsets.all(2),
//                               alignment: Alignment.centerLeft,
//                               child: MainComponents().txtview13(
//                                   "Address : Flat - 1843, opposite  bank, sector 41, faridabad, 121003, Haryana")),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                               padding: EdgeInsets.all(2),
//                               alignment: Alignment.centerLeft,
//                               child: MainComponents().txtview15("Documents")),
//                           Container(
//                             padding: EdgeInsets.all(10),
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   MainComponents().Images(aadharno, 130.0),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   MainComponents().Images(aadharno, 130.0),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   MainComponents().Images(aadharno, 130.0)
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
