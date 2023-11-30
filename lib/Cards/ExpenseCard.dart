import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/ui/Location/model/SiteIndividualModel.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:attendance_admin/Components/Image.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatefulWidget {
  ExpenseCard({super.key, required this.workerList});
  Worker workerList;

  @override
  State<ExpenseCard> createState() => _WorkerCardState();
}

class _WorkerCardState extends State<ExpenseCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final auth = context.watch<WorkerRepository>();
    String formattedDate = DateFormat('dd/MM/yyyy').format(widget.workerList.createdAt);
    return  Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MainComponents()
                        .Images(working, 50.0),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        MainComponents()
                            .txtview18(widget.workerList.fullname),
                        MainComponents().txtview12(
                            'Date :- $formattedDate'),
                        // MainComponents().txtview12("Payment: ₹90000"),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context)
                .size
                .width /
                1.2,
            child: Divider(
              color: light_black,
              thickness: .2,
            ),
          ),
        ],
      ),
    );
  }
}