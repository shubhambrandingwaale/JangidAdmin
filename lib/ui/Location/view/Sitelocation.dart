import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/Image.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/Components/SideLocations.dart';
import 'package:attendance_admin/Views/AddExpense.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/Location/controller/AllSiteRepositry.dart';
import 'package:attendance_admin/ui/Location/view/SItePayoutTab.dart';
import 'package:attendance_admin/ui/Location/view/WorkerPayoutTab.dart';
import 'package:attendance_admin/ui/Location/view/WorkerTab.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/CustomFont.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/widgets/CatchImage.dart';
import 'package:attendance_admin/widgets/Regular.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SitelocationController extends StatelessWidget {
  SitelocationController({Key? key, required this.siteId}) : super(key: key);
  int siteId = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AddSiteRepository(),
      child: Consumer(
        builder: (context, AddSiteRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return Sitelocation(siteId: siteId);
            case Status.Unauthenticated:
              return Sitelocation(siteId: siteId);
            case Status.Authenticating:
              return Sitelocation(siteId: siteId);
            case Status.Authenticated:
              return Sitelocation(siteId: siteId);
            case Status.error:
              return Sitelocation(siteId: siteId);
          }
        },
      ),
    );
  }
}

class Sitelocation extends StatefulWidget {
  Sitelocation({super.key, required this.siteId});
  int siteId = 0;

  @override
  State<Sitelocation> createState() => _SitelocationState();
}

class _SitelocationState extends State<Sitelocation> {
  void Change_Routes(Routes) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Routes));
  }

  @override
  void initState() {
    if (mounted) {
      final auth = context.read<AddSiteRepository>();
      auth.getSiteById(context, widget.siteId);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = context.watch<AddSiteRepository>();
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(auth.siteIndividualData!.createdAt);
    return Scaffold(
      backgroundColor: light_black,
      body: DefaultTabController(
        length: 3,
        child: auth.status == Status.Authenticating
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Column(
                  children: [
                    MainComponents()
                        .back('back', () => Routesapp.viewAllSites(context)),
                    // SingleSitelocation().textframe(),
                    cacheImage(
                        'https://jangid.nlaolympiad.in${auth.siteIndividualData!.image}',
                        100,
                        100,
                        BoxFit.cover),
                    const SizedBox(
                      height: 10,
                    ),
                    MainComponents()
                        .txtview18(auth.siteIndividualData!.address),
                    const SizedBox(
                      height: 10,
                    ),
                    //       Container(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 10, vertical: 10),
                    //         width: size.width * 0.3,
                    //         height: 80,
                    //         decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Regular(
                    //               text: 'Created at',
                    //               size: 12,
                    //               color: Appcolor.black,
                    //               fontWeight: CustomFontWeight.semibold,
                    //             ),
                    //             const SizedBox(
                    //               height: 5,
                    //             ),
                    //             Flexible(
                    //                 child: MainComponents()
                    //                     .txtview13(formattedDate)),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.all(5),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Container(
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: 10, vertical: 10),
                    //         width: size.width * 0.32,
                    //         height: 80,
                    //         decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Regular(
                    //               text: 'Present Working',
                    //               size: 12,
                    //               color: Appcolor.black,
                    //               fontWeight: CustomFontWeight.semibold,
                    //             ),
                    //             SizedBox(
                    //               height: 5,
                    //             ),
                    //             Flexible(
                    //                 child: MainComponents().txtview13(auth
                    //                     .siteIndividualData!.presentWorkers))
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 5,
                    //       ),
                    //       Container(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 10, vertical: 10),
                    //         width: size.width * 0.3,
                    //         height: 80,
                    //         decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Regular(
                    //               text: 'Total Worker',
                    //               size: 12,
                    //               color: Appcolor.black,
                    //               fontWeight: CustomFontWeight.semibold,
                    //             ),
                    //             SizedBox(
                    //               height: 5,
                    //             ),
                    //             Flexible(
                    //                 child: MainComponents().txtview13(
                    //                     auth.siteIndividualData!.totalWorkers)),
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 5,
                    //       ),
                    //       Container(
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: 10, vertical: 10),
                    //         width: size.width * 0.3,
                    //         height: 80,
                    //         decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Regular(
                    //               text: 'Total Transaction',
                    //               size: 12,
                    //               color: Appcolor.black,
                    //               fontWeight: CustomFontWeight.semibold,
                    //             ),
                    //             SizedBox(
                    //               height: 5,
                    //             ),
                    //             Flexible(
                    //                 child: MainComponents().txtview13(auth
                    //                     .siteIndividualData!
                    //                     .totalTransactions)),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.all(10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: [
                    //       MainComponents().homeCards(
                    //           walleticon,
                    //           "Total Expense",
                    //           "${auth.siteIndividualData!.totalBudget - auth.siteIndividualData!.budgetLeft}",
                    //           ""),
                    //       MainComponents().homeCards(
                    //           money_bag,
                    //           "budget for this site",
                    //           "${auth.siteIndividualData!.totalBudget}",
                    //           ""),
                    //     ],
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Images(image, 45.0),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Regular(
                                            text: 'Site Radius',
                                            size: 15,
                                            color: Appcolor.black,
                                            fontWeight: CustomFontWeight.semibold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Regular(
                                            text: "${auth.siteIndividualData!.radius}",
                                            size: 15,
                                            color: Appcolor.black,
                                            textAlign: TextAlign.center,
                                            fontWeight:
                                                CustomFontWeight.medium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              elevation: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Images(image, 45.0),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Regular(
                                            text: 'Present Worker',
                                            size: 15,
                                            color: Appcolor.black,
                                            fontWeight: CustomFontWeight.semibold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Regular(
                                                text: auth.siteIndividualData!.presentWorkers,
                                                size: 15,
                                                color: Appcolor.black,
                                                fontWeight:
                                                    CustomFontWeight.semibold,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Images(image, 45.0),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Regular(
                                            text: 'Total Worker',
                                            size: 15,
                                            color: Appcolor.black,
                                            fontWeight: CustomFontWeight.semibold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Regular(
                                            text: auth.siteIndividualData!.totalWorkers,
                                            size: 15,
                                            color: Appcolor.black,
                                            textAlign: TextAlign.center,
                                            fontWeight:
                                            CustomFontWeight.medium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              elevation: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Images(image, 45.0),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Regular(
                                            text: 'Total Transactions',
                                            size: 15,
                                            color: Appcolor.black,
                                            fontWeight: CustomFontWeight.semibold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Regular(
                                                text: auth.siteIndividualData!.totalTransactions,
                                                size: 15,
                                                color: Appcolor.black,
                                                fontWeight:
                                                CustomFontWeight.semibold,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Images(image, 45.0),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Regular(
                                            text: 'Total Expense',
                                            size: 15,
                                            color: Appcolor.black,
                                            fontWeight: CustomFontWeight.semibold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Regular(
                                            text: "${auth.siteIndividualData!.totalBudget - auth.siteIndividualData!.budgetLeft}",
                                            size: 15,
                                            color: Appcolor.black,
                                            textAlign: TextAlign.center,
                                            fontWeight:
                                            CustomFontWeight.medium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              elevation: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Images(image, 45.0),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Regular(
                                            text: 'Site Budget',
                                            size: 15,
                                            color: Appcolor.black,
                                            fontWeight: CustomFontWeight.semibold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Regular(
                                                text: '${
                                                  auth.siteIndividualData!
                                                      .totalBudget
                                                }',
                                                size: 15,
                                                color: Appcolor.black,
                                                fontWeight:
                                                CustomFontWeight.semibold,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Images(image, 45.0),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Regular(
                                            text: 'Created At',
                                            size: 15,
                                            color: Appcolor.black,
                                            fontWeight: CustomFontWeight.semibold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Regular(
                                            text: formattedDate,
                                            size: 15,
                                            color: Appcolor.black,
                                            textAlign: TextAlign.center,
                                            fontWeight:
                                            CustomFontWeight.medium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: MainComponents().SiteLocation1("Manage Budget",
                          "Add Expense", minus, context, AddExpense()),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    tabbar(size),
                    Expanded(child: _tabBarView(size, auth)),
                    Visibility(
                      visible: false,
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(6),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MainComponents().txtview15("Workers"),
                                  ],
                                )),
                            // ListView.separated(
                            //   shrinkWrap: true,
                            //   itemCount:
                            //       auth.siteIndividualData!.workers.length,
                            //   physics: NeverScrollableScrollPhysics(),
                            //   itemBuilder: (BuildContext context, index) {
                            //     String workersCreatedDate =
                            //         DateFormat('dd/MM/yyyy').format(auth
                            //             .siteIndividualData!
                            //             .workers[index]
                            //             .createdAt);
                            //     return MaterialButton(
                            //       padding: const EdgeInsets.all(5),
                            //       onPressed: () => {},
                            //       child: Column(
                            //         children: [
                            //           Padding(
                            //             padding: const EdgeInsets.all(8.0),
                            //             child: Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 Row(
                            //                   children: [
                            //                     MainComponents()
                            //                         .Images(working, 50.0),
                            //                     const SizedBox(
                            //                       width: 20,
                            //                     ),
                            //                     Column(
                            //                       mainAxisAlignment:
                            //                           MainAxisAlignment.start,
                            //                       crossAxisAlignment:
                            //                           CrossAxisAlignment
                            //                               .start,
                            //                       children: [
                            //                         MainComponents()
                            //                             .txtview18(auth
                            //                                 .siteIndividualData!
                            //                                 .workers[index]
                            //                                 .fullname),
                            //                         MainComponents().txtview12(
                            //                             'Date :- $workersCreatedDate'),
                            //                         // MainComponents().txtview12("Payment: ₹90000"),
                            //                       ],
                            //                     )
                            //                   ],
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             width: MediaQuery.of(context)
                            //                     .size
                            //                     .width /
                            //                 1.2,
                            //             child: Divider(
                            //               color: light_black,
                            //               thickness: .2,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     );
                            //   },
                            //   separatorBuilder:
                            //       (BuildContext context, int index) {
                            //     return Divider(
                            //       color: Appcolor.black,
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  TabBar tabbar(Size size) {
    return TabBar(
        isScrollable: true,
        unselectedLabelColor: Appcolor.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
        labelColor: Appcolor.White,
        labelPadding: const EdgeInsets.symmetric(horizontal: 5),
        indicator: BoxDecoration(
          color: Appcolor.blue,
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(color: Appcolor.black)
        ),
        tabs: [
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              // width: size.width,
              height: 30,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     border: Border.all(color: Appcolor.PrimaryColor, width: 1)),
              child: const Align(
                alignment: Alignment.center,
                child: Text("Workers"),
              ),
            ),
          ),
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     border: Border.all(
              //       color: Appcolor.PrimaryColor,
              //       width: 1,
              //     )),
              child: const Align(
                alignment: Alignment.center,
                child: Text("Workers Payout"),
              ),
            ),
          ),
          Tab(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     border: Border.all(color: Appcolor.PrimaryColor, width: 1)),
              child: const Align(
                alignment: Alignment.center,
                child: Text("Site Payout"),
              ),
            ),
          ),
        ]);
  }

  TabBarView _tabBarView(Size size, AddSiteRepository auth) {
    return TabBarView(children: [
      WorkerTab(
        workerData: auth.siteIndividualData!.workers,
      ),
      WorkerPayoutTab(workerPayoutData: auth.siteIndividualData!.workerPayouts),
      SitePayoutTab(
        SitePayoutData: auth.siteIndividualData!.sitePayouts,
      ),
    ]);
  }
}
