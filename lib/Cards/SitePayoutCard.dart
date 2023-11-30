import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/ui/Location/model/SiteIndividualModel.dart';
import 'package:attendance_admin/widgets/CatchImage.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SitePayoutCard extends StatefulWidget {
  SitePayoutCard({super.key, required this.sitePayout});
  Payout sitePayout;

  @override
  State<SitePayoutCard> createState() => _SitePayoutCardState();
}

class _SitePayoutCardState extends State<SitePayoutCard> {
  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(widget.sitePayout.createdAt);
    return Container(
      decoration: const BoxDecoration(
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
                    cacheImage(
                        'https://jangid.nlaolympiad.in${widget.sitePayout!.siteImg}',
                        60,
                        60,
                        BoxFit.cover),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainComponents().txtview18(widget.sitePayout!.siteName),
                        MainComponents().txtview13("sent : $formattedDate"),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 4, 15, 4),
                  decoration: DottedDecoration(
                      shape: Shape.box,
                      dash: const [4, 1],
                      borderRadius: BorderRadius.circular(20)),
                  child: MainComponents()
                      .txtview14("-${widget.sitePayout!.amount} ₹"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
