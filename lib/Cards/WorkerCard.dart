import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/workers/controller/WorkerRepository.dart';
import 'package:attendance_admin/ui/workers/model/WorkerModel.dart';
import 'package:attendance_admin/ui/workers/view/AddWorker.dart';
import 'package:attendance_admin/widgets/CatchImage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WorkerCard extends StatefulWidget {
  WorkerCard({super.key, required this.workerdata});
  WorkerDataList workerdata;

  @override
  State<WorkerCard> createState() => _WorkerCardState();
}

class _WorkerCardState extends State<WorkerCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = context.watch<WorkerRepository>();
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(widget.workerdata.createdAt);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  children: [
                    cacheImage(
                      'https://jangid.nlaolympiad.in${widget.workerdata.profileImg}',
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
                        SizedBox(
                          width: size.width * 0.60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  '${widget.workerdata.fullname}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: blue,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              PopupMenuButton<String>(
                                onSelected: (String choice) {
                                  if (choice == 'Edit') {
                                    Routesapp.gotoAddWorkerScreen(
                                      context,
                                      false,
                                      workerid: widget.workerdata.id,
                                    );
                                  } else if (choice == 'Delete') {
                                    auth.deleteWorker(context,
                                        widget.workerdata.id.toString());
                                  }
                                },
                                icon: const Icon(Icons
                                    .more_vert), // This makes the icon clickable
                                itemBuilder: (BuildContext context) {
                                  return ['Edit', 'Delete']
                                      .map((String choice) {
                                    return PopupMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                    );
                                  }).toList();
                                },
                              ),
                            ],
                          ),
                        ),
                        MainComponents()
                            .txtview13("working since : $formattedDate"),
                      ],
                    )
                  ],
                ),
              ),
            ],
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
    );
  }
}
