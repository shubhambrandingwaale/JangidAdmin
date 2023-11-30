import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/addSiteLocation/model/SupervisorModel.dart';
import 'package:attendance_admin/ui/supervisor/controller/SuperVisorRepository.dart';
import 'package:attendance_admin/ui/supervisor/model/AllSuperVisorModel.dart';
import 'package:attendance_admin/ui/workers/controller/WorkerRepository.dart';
import 'package:attendance_admin/ui/workers/model/WorkerModel.dart';
import 'package:attendance_admin/ui/workers/view/AddWorker.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/widgets/CatchImage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SuperVisorCard extends StatefulWidget {
  SuperVisorCard({super.key, required this.superVisordata});
  SuperVisorDataList superVisordata;

  @override
  State<SuperVisorCard> createState() => _SuperVisorCardState();
}

class _SuperVisorCardState extends State<SuperVisorCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = context.watch<SuperVisorRepository>();
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(widget.superVisordata.createdAt);
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      margin: const EdgeInsets.only(top: 10),
      decoration: MainComponents().decoration(Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  children: [
                    cacheImage(
                      'https://jangid.nlaolympiad.in${widget.superVisordata.profileImg}',
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
                                  widget.superVisordata.fullname,
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
                                    Routesapp.gotoAddSuperVisor(
                                      context,
                                      false,
                                      superVisorid: widget.superVisordata.id,
                                    );
                                  } else if (choice == 'Delete') {
                                    auth.deleteSuperVisor(context,
                                        widget.superVisordata.id.toString());
                                  } else if (choice == 'View') {
                                    Routesapp.gotoSuperVisorProfile(
                                        context, widget.superVisordata.id);
                                  }
                                },
                                icon: const Icon(Icons
                                    .more_vert), // This makes the icon clickable
                                itemBuilder: (BuildContext context) {
                                  return ['Edit', 'Delete', 'View']
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
                        // MainComponents()
                        //     .txtview18(widget.superVisordata.fullname),
                        const SizedBox(
                          height: 5,
                        ),
                        MainComponents()
                            .txtview11("work since: $formattedDate"),
                        const SizedBox(
                          height: 5,
                        ),
                        MainComponents().txtview11(
                            "Wallet Balance: ${widget.superVisordata.walletBalance}"),
                        const SizedBox(
                          height: 5,
                        ),
                        // MainComponents().txtview11(
                        //     "Payment: ${widget.superVisordata.}"),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 4, 15, 4),
                child: MainComponents().Popup(),
              )
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
