import 'dart:convert';

import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/Models/Brain.dart';
import 'package:attendance_admin/Models/TokenData.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/supervisor/controller/SuperVisorRepository.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlSuperVisorController extends StatelessWidget {
  AlSuperVisorController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SuperVisorRepository(),
      child: Consumer(
        builder: (context, SuperVisorRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return AllSupervisors();
            case Status.Unauthenticated:
              return AllSupervisors();
            case Status.Authenticating:
              return AllSupervisors();
            case Status.Authenticated:
              return AllSupervisors();
            case Status.error:
              return AllSupervisors();
          }
        },
      ),
    );
  }
}

class AllSupervisors extends StatefulWidget {
  const AllSupervisors({super.key});

  @override
  State<AllSupervisors> createState() => _AllSupervisorsState();
}

class _AllSupervisorsState extends State<AllSupervisors> {
  Future<void> Supervisor() async {
    var data = await BrainCode().Supervisorlist(await token);
    // setState(() {
    //   supervisordata = jsonDecode(data);
    // });
  }

  Future<void> refresh() async {
    final auth = context.read<SuperVisorRepository>();
    await auth.getAllSuperVisor(context);
  }

  @override
  void initState() {
    final auth = context.read<SuperVisorRepository>();
    auth.getAllSuperVisor(context);
    // Supervisor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<SuperVisorRepository>();
    return Scaffold(
      backgroundColor: light_black,
      body: auth.status == Status.Authenticating
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: refresh,
              color: Appcolor.blue,
              child: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      MainComponents().back(
                          'back', () => Routesapp.gotoHomeScreen(context)),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: MainComponents()
                            .AllSupervisors(auth.superVisorListData),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
