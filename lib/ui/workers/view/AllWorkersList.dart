import 'package:attendance_admin/Cards/WorkerCard.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/workers/controller/WorkerRepository.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkerListController extends StatelessWidget {
  WorkerListController({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => WorkerRepository(),
      child: Consumer(
        builder: (context, WorkerRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return AllWorkersList();
            case Status.Unauthenticated:
              return AllWorkersList();
            case Status.Authenticating:
              return AllWorkersList();
            case Status.Authenticated:
              return AllWorkersList();
            case Status.error:
              return AllWorkersList();
          }
        },
      ),
    );
  }
}

class AllWorkersList extends StatefulWidget {
  const AllWorkersList({super.key});

  @override
  State<AllWorkersList> createState() => _AllWorkersState();
}

class _AllWorkersState extends State<AllWorkersList> {
  Future<void> refresh() async {
    final auth = context.read<WorkerRepository>();
    await auth.getAllWorkerList(context);
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 10), () async {
      final auth = context.read<WorkerRepository>();
      auth.getAllWorkerList(context);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<WorkerRepository>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: auth.status == Status.Authenticating
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: refresh,
              color: Appcolor.blue,
              child: Container(
                color: Colors.white,
                child: SafeArea(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        MainComponents().back(
                            'back', () => Routesapp.gotoHomeScreen(context)),
                        Container(
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.centerLeft,
                            child:
                                MainComponents().txtview15("All Workers in")),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: auth.workerListData.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Routesapp.gotoWorkerProfile(
                                      context, auth.workerListData[index].id);
                                },
                                child: WorkerCard(
                                  workerdata: auth.workerListData[index],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
