import 'package:attendance_admin/Cards/ExpenseCard.dart';
import 'package:attendance_admin/ui/Location/controller/AllSiteRepositry.dart';
import 'package:attendance_admin/ui/Location/model/SiteIndividualModel.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkerTab extends StatefulWidget {
  WorkerTab({super.key, required this.workerData});
  List<Worker> workerData;

  @override
  State<WorkerTab> createState() => _WorkerTabState();
}

class _WorkerTabState extends State<WorkerTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Routesapp.gotoUserPage(context,
              //     auth.homeModelData[index].id);
            },
            child: ExpenseCard(workerList: widget.workerData[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.black,
            height: 1,
          );
        },
        itemCount: widget.workerData.length);
  }
}
