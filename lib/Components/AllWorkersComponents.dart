import 'package:attendance_admin/Components/Image.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/ui/workers/model/AttendanceWorker.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Colors.dart';

class AllWorkerComponents {
  Widget AllWorkerList(Function() workerpage) {
    return Container(
      color: Colors.white,
      child: Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 15,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, index) {
              return MaterialButton(
                onPressed: () => {workerpage()},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                MainComponents().Images(working, 40.0),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MainComponents().txtview18("Sanjeev Singh"),
                                    MainComponents().txtview13(
                                        "working since : 19 sept, 2023"),
                                    MainComponents()
                                        .txtview13("Payment : ₹12568"),
                                  ],
                                )
                              ],
                            ),
                            MainComponents().Popup()
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Divider(
                          color: lowblack,
                          thickness: .2,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget homeCards(uptxt, lowtxt) {
    return Container(
      decoration: MainComponents().decoration(Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: MainComponents().txtview10(uptxt),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MainComponents().txtview14(lowtxt),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget TableView(List<AllAttendanceWorker> attendanceList) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 38.0,
              columns: const [
                DataColumn(
                    label: Text(
                  'Sr.no',
                  style: TextStyle(),
                  selectionColor: Colors.amberAccent,
                )),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Hours')),
                DataColumn(label: Text('Check-in')),
                DataColumn(label: Text('Checkout')),
                DataColumn(label: Text('Site name')),
              ],
              rows: List.generate(attendanceList.length, (index) {
                return DataRow(cells: [
                  DataCell(Container(width: 75, child: Text('${index + 1}'))),
                  DataCell(Container(
                      child: Text(DateFormat('dd/MM/yyyy')
                          .format(attendanceList[index].createdAt)))),
                  DataCell(
                      Container(child: Text(attendanceList[index].timeDiff))),
                  DataCell(Container(
                      child: Text(
                          Util.formatTime(attendanceList[index].checkIn)))),
                  DataCell(Container(
                      child: Text(
                          Util.formatTime(attendanceList[index].checkOut)))),
                  DataCell(
                      Container(child: Text(attendanceList[index].siteName)))
                ]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyDataTableSource extends DataTableSource {
  final List<AllAttendanceWorker> _data;

  _MyDataTableSource(this._data);

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }
    final record = _data[index];
    return DataRow(cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(DateFormat('dd/MM/yyyy').format(record.createdAt))),
      DataCell(Text(record.timeDiff)),
      DataCell(Text(Util.formatTime(record.checkIn))),
      DataCell(Text(Util.formatTime(record.checkOut))),
      DataCell(Text(record.siteName)),
    ]);
  }

  @override
  int get rowCount => _data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
