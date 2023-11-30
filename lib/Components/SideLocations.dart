import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/Image.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/Models/Brain.dart';
import 'package:attendance_admin/ui/Location/controller/AllSiteRepositry.dart';
import 'package:attendance_admin/ui/Location/view/Sitelocation.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/Location/model/AllSiteModel.dart';
import 'package:attendance_admin/widgets/CatchImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class SitesLocations {
  Widget SiteLocationList(
      BuildContext context, AllsiteModel listdata, AddSiteRepository auth) {
    return Container(
      decoration: SingleSitelocation().boxdecor(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainComponents().txtview15("Site Locations"),
              ],
            ),
          ),
          ListData(listdata.data, auth)
        ],
      ),
    );
  }

  Widget Imgbt(BuildContext context, routes) {
    return MaterialButton(
      color: Colors.white,
      elevation: 5,
      onPressed: () => {BrainCode().Navigatorpush(context, routes)},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MainComponents().Images(add_new, 30.0),
            SizedBox(
              width: 9,
            ),
          ],
        ),
      ),
    );
  }

  Widget ListData(List<AllSiteDataList> data, AddSiteRepository auth) {
    return Container(
      decoration: SingleSitelocation().boxdecor(),
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (BuildContext context, index) {
            int total_budget = data[index].totalBudget;
            return GestureDetector(
              onTap: () {
                Routesapp.gotoViewSite(context, data[index].id);
                // BrainCode().Navigatorpush(context, Sitelocation());
                print(data[index].id);
              },
              child: Container(
                decoration: SingleSitelocation().boxdecor(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          cacheImage(
                            'https://jangid.nlaolympiad.in${data[index].image}',
                            60,
                            60,
                            BoxFit.cover,
                            shape: BoxShape.circle,
                          ),
                          // MainComponents().Images(sites, 60.0),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: MainComponents()
                                        .txtview15(data[index].siteName)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MainComponents().Images(worker, 20.0),
                                        MainComponents()
                                            .txtview13(data[index].ownerName),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        MainComponents().Images(Calendar, 20.0),
                                        MainComponents().txtview13(
                                            DateFormat('dd/MM/yyyy')
                                                .format(data[index].createdAt)),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MainComponents().Images(walleticon, 20.0),
                                      MainComponents().txtview13(
                                          data[index].budgetLeft.toString()),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      MainComponents().Images(money_bag, 20.0),
                                      MainComponents().txtview13(
                                          data[index].totalBudget.toString()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      PopupMenuButton<String>(
                        onSelected: (String choice) {
                          if (choice == 'Edit') {
                            Routesapp.gotoAddSite(context, false,
                                siteId: data[index].id);
                          } else if (choice == 'Delete') {
                            auth.deleteSite(context, data[index].id.toString());
                          }
                        },
                        icon: const Icon(
                            Icons.more_vert), // This makes the icon clickable
                        itemBuilder: (BuildContext context) {
                          return ['Edit', 'Delete'].map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      )
                      // MainComponents().Popup()
                    ],
                  ),

                ),
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Divider(
                color: lowblack,
                thickness: .2,
              ),
            );
      },),
    );
  }
}

class SingleSitelocation {
  Widget textframe() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MainComponents().txtview18("Site Locations"),
          // MainComponents().Popup()
        ],
      ),
    );
  }

  Widget ImageCard() {
    return Column(
      children: [
        MainComponents().Images(sites, 120.0),
        const SizedBox(
          height: 10,
        ),
        MainComponents().txtview18(
            "House No.187,opposite,Showroom,sector 12,Faridabad,121303,Haryana")
      ],
    );
  }

  Widget homeCards(uptxt, lowtxt) {
    return Container(
      decoration: boxdecor(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                  child: MainComponents().txtview11(uptxt),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MainComponents().txtview13(lowtxt),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget longlat(uptxt, lon, lat) {
  //   return
  //     Container(
  //     decoration: boxdecor(),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Container(
  //           alignment: Alignment.centerRight,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(3.0),
  //                 child: Regular(),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(3.0),
  //                 child: MainComponents().txtview13("Lon" + lon),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: MainComponents().txtview13("Lat" + lat),
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget SiteCard(uptxt, lowtxt) {
    return Container(
      decoration: boxdecor(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                  child: MainComponents().txtview11(uptxt),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 30),
                  child: MainComponents().txtview18(lowtxt),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget Deductions_list() {
    return Container(
      decoration: boxdecor(),
      child: Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, index) {
              return MaterialButton(
                padding: EdgeInsets.all(5),
                onPressed: () => {},
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              MainComponents().Images(working, 50.0),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MainComponents().txtview18("Sanjeev Singh"),
                                  MainComponents()
                                      .txtview12("Working Since: 19 Sep, 2023"),
                                  MainComponents().txtview12("Payment: ₹90000"),
                                ],
                              )
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(15, 4, 15, 4),
                              child: MainComponents().Popup())
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Divider(
                        color: light_black,
                        thickness: .2,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  BoxDecoration boxdecor() {
    return BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10));
  }
}
