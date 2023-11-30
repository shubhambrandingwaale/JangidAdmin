import 'package:attendance_admin/Cards/SitePayoutCard.dart';
import 'package:attendance_admin/ui/Location/model/SiteIndividualModel.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:flutter/material.dart';

class SitePayoutTab extends StatefulWidget {
  SitePayoutTab({super.key, required this.SitePayoutData});
  List<Payout> SitePayoutData;

  @override
  State<SitePayoutTab> createState() => _SitePayoutTabState();
}

class _SitePayoutTabState extends State<SitePayoutTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Routesapp.gotoUserPage(context,
              //     auth.homeModelData[index].id);
            },
            child: SitePayoutCard(sitePayout: widget.SitePayoutData[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Appcolor.black,
            height: 1,
          );
        },
        itemCount: widget.SitePayoutData.length);
  }
}
