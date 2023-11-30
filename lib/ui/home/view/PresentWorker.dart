import 'package:attendance_admin/Cards/PresentWorkerCard.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/home/controller/HomeRepository.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PresentWorkerController extends StatelessWidget {
  const PresentWorkerController({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeRepository(),
      child: Consumer(
        builder: (context, HomeRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return PresentWorkerList();
            case Status.Unauthenticated:
              return PresentWorkerList();
            case Status.Authenticating:
              return PresentWorkerList();
            case Status.Authenticated:
              return PresentWorkerList();
            case Status.error:
              return PresentWorkerList();
          }
        },
      ),
    );
  }
}

class PresentWorkerList extends StatefulWidget {
  const PresentWorkerList({super.key});

  @override
  State<PresentWorkerList> createState() => _PresentWorkerListState();
}

class _PresentWorkerListState extends State<PresentWorkerList> {
  @override
  void initState() {
    final auth = context.read<HomeRepository>();
    auth.getPresentWorker(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<HomeRepository>();
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              MainComponents()
                  .back('back', () => Routesapp.gotoHomeScreen(context)),
              Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.centerLeft,
                  child: MainComponents().txtview15("All Workers in")),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: auth.workerListData.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: PresentWokerCard(
                        workerList: auth.workerListData[index],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
