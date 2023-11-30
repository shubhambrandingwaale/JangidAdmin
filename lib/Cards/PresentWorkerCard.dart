import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/ui/Location/model/SiteIndividualModel.dart';
import 'package:attendance_admin/ui/home/controller/HomeRepository.dart';
import 'package:attendance_admin/ui/home/model/PresentWorkerModel.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/CustomFont.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:attendance_admin/widgets/Button.dart';
import 'package:attendance_admin/widgets/CatchImage.dart';
import 'package:attendance_admin/widgets/Regular.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:attendance_admin/Components/Image.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PresentWokerCard extends StatefulWidget {
  PresentWokerCard({super.key, required this.workerList});
  PresentWorkerData workerList;

  @override
  State<PresentWokerCard> createState() => _WorkerCardState();
}

class _WorkerCardState extends State<PresentWokerCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = context.watch<HomeRepository>();
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(widget.workerList.createdAt);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        cacheImage(
                          'https://jangid.nlaolympiad.in${widget.workerList.profileImg}',
                          80,
                          80,
                          BoxFit.cover,
                          shape: BoxShape.circle,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Regular(
                              text: widget.workerList.workerUsername,
                              size: 18,
                              color: Appcolor.black,
                              fontWeight: CustomFontWeight.semibold,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Regular(
                              text:
                                  'Username : ${widget.workerList.workerUsername}',
                              size: 14,
                              color: Appcolor.black,
                              fontWeight: CustomFontWeight.regular,
                            ),
                            // MainComponents().txtview12('Date :- $formattedDate'),
                            // MainComponents().txtview12("Payment: ₹90000"),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Mybutton(
                            lable: 'Punch-out',
                            height: 40,
                            width: 100,
                            bgcolor: Appcolor.blue,
                            color: Appcolor.White,
                            size: 15,
                            onPressed: () async {
                              TimeOfDay? selectedTime =
                                  await Util.showTimePickerDialogin24hour(
                                context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (selectedTime != null) {
                                String formattedTime =
                                    _convertToIsoString(selectedTime);

                                Customlog(
                                    'Selected Time: ${selectedTime.format(context)}');
                                auth.startTimeController.text = formattedTime;
                                auth.PunchOut(context, widget.workerList.uid);
                              }
                            })
                      ],
                    ),
                  ],
                ),
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
  }

  String _convertToIsoString(TimeOfDay time) {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    String isoString = dateTime.toIso8601String();
    return isoString;
  }

  String _convertTo24HourFormat(TimeOfDay time) {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    DateFormat outputFormat = DateFormat("HH:mm");
    return outputFormat.format(dateTime);
  }
}
