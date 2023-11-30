import 'dart:io';

import 'package:attendance_admin/Components/AllWorkersComponents.dart';
import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/workers/controller/WorkerProfileRepository.dart';
import 'package:attendance_admin/ui/workers/model/AttendanceWorker.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:attendance_admin/widgets/CustomTextFeilds.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/CustomFont.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/widgets/MyClick.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:attendance_admin/widgets/AnimatedButton.dart';
import 'package:attendance_admin/widgets/Button.dart';
import 'package:attendance_admin/widgets/CatchImage.dart';
import 'package:attendance_admin/widgets/Regular.dart';
import 'package:attendance_admin/widgets/image_viewer_dialog/image_gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class WorkerProfileController extends StatelessWidget {
  WorkerProfileController({Key? key, required this.workerId}) : super(key: key);
  int workerId = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => WorkerProfileRepository(),
      child: Consumer(
        builder: (context, WorkerProfileRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return WorkerProfile(
                workerId: workerId,
              );
            case Status.Unauthenticated:
              return WorkerProfile(
                workerId: workerId,
              );
            case Status.Authenticating:
              return WorkerProfile(
                workerId: workerId,
              );
            case Status.Authenticated:
              return WorkerProfile(
                workerId: workerId,
              );
            case Status.error:
              return WorkerProfile(
                workerId: workerId,
              );
          }
        },
      ),
    );
  }
}

class WorkerProfile extends StatefulWidget {
  WorkerProfile({super.key, required this.workerId});
  int workerId = 0;

  @override
  State<WorkerProfile> createState() => _WorkerProfileState();
}

class _WorkerProfileState extends State<WorkerProfile> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  TextEditingController _searchController = TextEditingController();
  Future<void> refresh() async {
    final auth = context.read<WorkerProfileRepository>();
    auth.getWorkerById(context, widget.workerId);
    auth.getAllSite(context);
    auth.getAttendanceById(context, widget.workerId);
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 10), () async {
      final auth = context.read<WorkerProfileRepository>();
      print(await Permission.storage.request());
      auth.getWorkerById(context, widget.workerId);
      auth.getAllSite(context);
      auth.getAttendanceById(context, widget.workerId);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = context.watch<WorkerProfileRepository>();
    PageController pageController = PageController();
    List<AllAttendanceWorker> filteredList = auth.attendanceList
        .where((entry) => entry.siteName
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();
    return Scaffold(
      backgroundColor: light_black,
      body: auth.status == Status.Authenticating
          ? const CircularProgressIndicator()
          : RefreshIndicator(
              onRefresh: refresh,
              color: Appcolor.blue,
              child: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      MainComponents().back('back',
                          () => Routesapp.gotoWorkerListScreen(context)),
                      Container(
                        child: Column(
                          children: [
                            cacheImage(
                              'https://jangid.nlaolympiad.in${auth.workerIndividualData!.profileImg}',
                              100,
                              100,
                              BoxFit.cover,
                              shape: BoxShape.circle,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                padding: const EdgeInsets.all(20),
                                decoration:
                                    MainComponents().decoration(Colors.white),
                                child: MainComponents().txtview14(auth
                                    .workerIndividualData!.fullname
                                    .toString()))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Card(
                                  child: Container(
                                      decoration: MainComponents()
                                          .decoration(Colors.white),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Regular(
                                                      text:
                                                          'Total working in Hrs',
                                                      size: 12,
                                                      color: Appcolor.black,
                                                      fontWeight:
                                                          CustomFontWeight
                                                              .semibold,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Regular(
                                                      text: auth
                                                          .workerIndividualData!
                                                          .totalWorkingHours
                                                          .toString(),
                                                      size: 12,
                                                      color: Appcolor.black,
                                                      fontWeight:
                                                          CustomFontWeight
                                                              .medium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ])))),
                          Expanded(
                              child: Card(
                                  child: Container(
                                      decoration: MainComponents()
                                          .decoration(Colors.white),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Regular(
                                                      text: 'Total payout',
                                                      size: 12,
                                                      color: Appcolor.black,
                                                      fontWeight:
                                                          CustomFontWeight
                                                              .semibold,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Regular(
                                                      text: auth
                                                          .workerIndividualData!
                                                          .totalPayout
                                                          .toString(),
                                                      size: 12,
                                                      color: Appcolor.black,
                                                      fontWeight:
                                                          CustomFontWeight
                                                              .medium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ])))),
                          Expanded(
                              child: Card(
                                  child: Container(
                                      decoration: MainComponents()
                                          .decoration(Colors.white),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Regular(
                                                      text: 'Total Paid',
                                                      size: 12,
                                                      color: Appcolor.black,
                                                      fontWeight:
                                                          CustomFontWeight
                                                              .semibold,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Regular(
                                                      text: auth
                                                          .workerIndividualData!
                                                          .totalPaid
                                                          .toString(),
                                                      size: 12,
                                                      color: Appcolor.black,
                                                      fontWeight:
                                                          CustomFontWeight
                                                              .medium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ])))),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                    width: 170,
                                    child: Container(
                                        decoration: MainComponents()
                                            .decoration(Colors.white),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Regular(
                                                        text:
                                                            'Pending amount to pay',
                                                        size: 12,
                                                        color: Appcolor.black,
                                                        fontWeight:
                                                            CustomFontWeight
                                                                .semibold,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Regular(
                                                        text: auth
                                                            .workerIndividualData!
                                                            .pendingPayout
                                                            .toString(),
                                                        size: 12,
                                                        color: Appcolor.black,
                                                        fontWeight:
                                                            CustomFontWeight
                                                                .medium,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ])))),
                            Visibility(
                              visible: false,
                              child: Container(
                                  padding: EdgeInsets.all(6),
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                      width: 170,
                                      child: Container(
                                          decoration: MainComponents()
                                              .decoration(Colors.white),
                                          child: Mybutton(
                                              lable: "Total Payout",
                                              height: 50,
                                              width: 170,
                                              bgcolor: Appcolor.blue,
                                              color: Appcolor.White,
                                              size: 14,
                                              fontWeight:
                                                  CustomFontWeight.semibold,
                                              onPressed: () {
                                                _showDialog(context);
                                              })))),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: MainComponents().txtview15("Assigned to"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Card(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IgnorePointer(
                                  ignoring: auth.isDropdownEnable,
                                  child: DropdownButton(
                                    value: int.parse(auth.selectedSiteId == ""
                                        ? "0"
                                        : auth.selectedSiteId),
                                    borderRadius: BorderRadius.circular(10),
                                    hint: MainComponents()
                                        .txtview14("Select Site"),
                                    isExpanded: true,
                                    items: auth.siteListData.map((e) {
                                      return DropdownMenuItem(
                                          value: e.id, child: Text(e.siteName));
                                    }).toList(),
                                    onChanged: (value) {
                                      auth.changeSiteId(value.toString());
                                    },
                                  ),
                                ),
                              )),
                            ),
                            Expanded(
                                flex: 0,
                                child: MainComponents().Button(auth.btnText,
                                    () {
                                  auth.isdropdownEnable(
                                      context, widget.workerId);
                                },
                                    auth.btnText == 'Assign'
                                        ? Colors.green
                                        : Colors.redAccent))
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Regular(
                              text: 'Attendance',
                              size: 15,
                              color: Appcolor.black,
                              fontWeight: CustomFontWeight.medium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextFeild(
                                  HintText: 'Search by Site Name',
                                  Radius: 10,
                                  width: 220,
                                  TextInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  obscureText: false,
                                  height: 45,
                                  controller: _searchController,
                                  onchangeFuntion: (value) {
                                    setState(() {});
                                  },
                                  isOutlineInputBorder: true),
                              Mybutton(
                                  lable: 'Export',
                                  height: 45,
                                  width: 100,
                                  bgcolor: Appcolor.blue,
                                  color: Appcolor.White,
                                  size: 15,
                                  onPressed: () {
                                    createExcelFile(filteredList);
                                  })
                            ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 350,
                        child: ListView(children: [
                          PaginatedDataTable(
                            columnSpacing: 38.0,
                            sortColumnIndex: _sortColumnIndex,
                            sortAscending: _sortAscending,
                            rowsPerPage: 5, // Set the number of rows per page
                            columns: [
                              DataColumn(
                                label: const Text('Sr.no'),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    _sortColumnIndex = columnIndex;
                                    _sortAscending = ascending;
                                    auth.attendanceList.sort((a, b) {
                                      if (ascending) {
                                        return a.createdAt
                                            .compareTo(b.createdAt);
                                      } else {
                                        return b.createdAt
                                            .compareTo(a.createdAt);
                                      }
                                    });
                                  });
                                },
                              ),
                              DataColumn(
                                label: Row(
                                  children: [
                                    Text('Date'),
                                    SizedBox(width: 5),
                                    Icon(
                                      _sortColumnIndex == 1
                                          ? _sortAscending
                                              ? Icons.arrow_upward
                                              : Icons.arrow_downward
                                          : null,
                                    ),
                                  ],
                                ),
                                numeric: false,
                                tooltip: 'Sort by Date',
                              ),
                              const DataColumn(label: Text('Hours')),
                              const DataColumn(label: Text('Check-in')),
                              const DataColumn(label: Text('Checkout')),
                              const DataColumn(label: Text('Site name')),
                            ],
                            source: _MyDataTableSource(filteredList),
                          ),
                        ]),
                      ),
                      Container(
                          padding: EdgeInsets.all(13),
                          alignment: Alignment.centerLeft,
                          child:
                              MainComponents().txtview15("Other Information")),
                      Card(
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: MainComponents().txtview13(
                                    "Contact Number : ${auth.workerIndividualData!.phone}")),
                            Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: MainComponents().txtview13(
                                    "Daily wage : ${auth.workerIndividualData!.dailyWageSalary}")),
                            Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: MainComponents().txtview13(
                                    "Address : ${auth.workerIndividualData!.address}")),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                                padding: const EdgeInsets.all(2),
                                alignment: Alignment.centerLeft,
                                child: MainComponents().txtview15("Documents")),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: InkWell(
                                  onTap: () {
                                    showAnimatedDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        animationType:
                                            DialogTransitionType.scale,
                                        curve: Curves.fastOutSlowIn,
                                        duration: const Duration(seconds: 1),
                                        builder: (BuildContext context) {
                                          return PhotoGallery(
                                            imagesArray:
                                                auth.workerIndividualData!.docs,
                                            pageController: pageController,
                                            comeFrom: 'userDetails',
                                          );
                                        });
                                  },
                                  child: Row(
                                    children: [
                                      for (String imageUrl
                                          in auth.workerIndividualData!.docs)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Image.network(
                                            'https://jangid.nlaolympiad.in/$imageUrl',
                                            width:
                                                180, // Adjust the image width
                                            height:
                                                200, // Adjust the image height
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class _MyDataTableSource extends DataTableSource {
  final List<AllAttendanceWorker> _data;

  _MyDataTableSource(this._data);

  @override
  DataRow? getRow(int index) {
    Customlog('data is : ${_data.length}  $_data');
    if (index >= _data.length) {
      return null;
    }
    final record = _data[index];
    return DataRow(cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(DateFormat('dd/MM/yyyy').format(record.createdAt))),
      DataCell(Text(record.hours)),
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

void _showDialog(BuildContext context) {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Amount and Reason'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(labelText: 'Reason'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Submit'),
            onPressed: () {
              // Process the amount and reason here
              String amount = amountController.text;
              String reason = reasonController.text;
              // You can handle the data as needed, for example, send it to an API or update your state.
              print('Amount: $amount, Reason: $reason');
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> createExcelFile(List<AllAttendanceWorker> data) async {
  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String currentTime = DateFormat('HH-mm-ss').format(DateTime.now());
  String fileName = 'AttendanceSheet-$currentDate-$currentTime.xlsx';

  sheet.appendRow(
      ['S.No.', 'Date', 'Hours', 'Check-in', 'Check-out', 'Site Name']);
  // Populate Excel sheet with data
  for (int row = 0; row < data.length; row++) {
    sheet.appendRow([
      '${row + 1}',
      DateFormat('dd/MM/yyyy').format(data[row].createdAt),
      data[row].timeDiff,
      Util.formatTime(data[row].checkIn),
      Util.formatTime(data[row].checkOut),
      data[row].siteName
    ]);
  }

  final directory = await getApplicationDocumentsDirectory();
  final filePath = '/storage/emulated/0/Download/$fileName';
  Customlog(' file path is :$filePath');
  final excelBytes = await excel.encode();
  try {
    File(filePath).writeAsBytesSync(excelBytes!);
  } catch (e) {
    print('Error: $e');
  }
  openFile(filePath);
  // showNotification(filePath);
}

Future<void> showNotification(String filePath) async {
  bool areNotificationsAllowed =
      await AwesomeNotifications().isNotificationAllowed();

  if (!areNotificationsAllowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 0,
      channelKey: 'basic_channel',
      title: 'Excel File Downloaded',
      body: 'File is downloaded and ready to open.',
    ),
  );
  openFile(filePath);

  // AwesomeNotifications().actionStream.listen((receivedNotification) {
  //   if (receivedNotification.payload != null &&
  //       receivedNotification.payload!['filePath'] != null) {
  //     openFile(receivedNotification.payload!['filePath']);
  //   }
  // });
}

void openFile(String filePath) {
  OpenFile.open(filePath);
}
