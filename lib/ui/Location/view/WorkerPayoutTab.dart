import 'package:attendance_admin/Cards/WorkerPayoutCard.dart';
import 'package:attendance_admin/ui/Location/model/SiteIndividualModel.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:flutter/material.dart';

class WorkerPayoutTab extends StatefulWidget {
  WorkerPayoutTab({super.key, required this.workerPayoutData});
  List<Payout> workerPayoutData;

  @override
  State<WorkerPayoutTab> createState() => _WorkerPayoutTabState();
}

class _WorkerPayoutTabState extends State<WorkerPayoutTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Routesapp.gotoUserPage(context,
              //     auth.homeModelData[index].id);
            },
            child:
                WorkerPayoutCard(workerPayout: widget.workerPayoutData[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Appcolor.black,
            height: 1,
          );
        },
        itemCount: widget.workerPayoutData.length);
  }
}
