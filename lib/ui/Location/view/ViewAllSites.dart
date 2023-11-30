import 'dart:convert';

import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/Image.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/Components/SharePref.dart';
import 'package:attendance_admin/Components/SideLocations.dart';
import 'package:attendance_admin/Models/Brain.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/Location/controller/AllSiteRepositry.dart';
import 'package:attendance_admin/ui/Location/model/AllSiteModel.dart';
import 'package:attendance_admin/ui/workers/model/WorkerModelIndividual.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSiteController extends StatelessWidget {
  AddSiteController({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AddSiteRepository(),
      child: Consumer(
        builder: (context, AddSiteRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return ViewAllSites();
            case Status.Unauthenticated:
              return ViewAllSites();
            case Status.Authenticating:
              return ViewAllSites();
            case Status.Authenticated:
              return ViewAllSites();
            case Status.error:
              return ViewAllSites();
          }
        },
      ),
    );
  }
}

class ViewAllSites extends StatefulWidget {
  const ViewAllSites({super.key});

  @override
  State<ViewAllSites> createState() => _ViewAllSitesState();
}

class _ViewAllSitesState extends State<ViewAllSites> {
  Future<void> refresh() async {
    final auth = context.read<AddSiteRepository>();
    await auth.getAllSite(context);
  }

  @override
  void initState() {
    final auth = context.read<AddSiteRepository>();
    auth.getAllSite(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AddSiteRepository>();
    return Scaffold(
      backgroundColor: light_black,
      body: auth.status == Status.Authenticating
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: refresh,
              color: Appcolor.blue,
              child: SafeArea(
                  child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    MainComponents()
                        .back('back', () => Routesapp.gotoHomeScreen(context)),
                    SitesLocations()
                        .SiteLocationList(context, auth.siteData, auth),
                  ],
                ),
              )),
            ),
    );
  }
}
