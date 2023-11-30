import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/widgets/AnimatedButton.dart';
import 'package:attendance_admin/widgets/CatchImage.dart';
import 'package:flutter/material.dart';
import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/addSiteLocation/controller/AddSiteLocationRepository.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/CustomFont.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/widgets/Regular.dart';
import 'package:provider/provider.dart';

class AddWorkerSiteController extends StatelessWidget {
  AddWorkerSiteController({
    Key? key,
    required this.siteId,
  }) : super(key: key);
  int siteId = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AddSiteLocationRepository(),
      child: Consumer(
        builder: (context, AddSiteLocationRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return AddWorkerSite(
                siteId: siteId,
              );
            case Status.Unauthenticated:
              return AddWorkerSite(
                siteId: siteId,
              );
            case Status.Authenticating:
              return AddWorkerSite(
                siteId: siteId,
              );
            case Status.Authenticated:
              return AddWorkerSite(
                siteId: siteId,
              );
            case Status.error:
              return AddWorkerSite(
                siteId: siteId,
              );
          }
        },
      ),
    );
  }
}

class AddWorkerSite extends StatefulWidget {
  AddWorkerSite({super.key, required this.siteId});
  int siteId = 0;
  @override
  State<AddWorkerSite> createState() => _AddWorkerSiteState();
}

class _AddWorkerSiteState extends State<AddWorkerSite> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 10), () async {
      final auth = context.read<AddSiteLocationRepository>();
      auth.getAllSupervisor(context);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = context.watch<AddSiteLocationRepository>();
    return Scaffold(
      backgroundColor: light_black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: auth.selectedValue == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Routesapp.gotoBackPage(context);
                          },
                          child: Container(
                            width: size.width * 0.25,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Regular(
                                      text: 'Back',
                                      size: 15,
                                      color: Appcolor.blue),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Icon(
                                    Icons.keyboard_return_outlined,
                                    color: lightblue,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Regular(
                          text: 'Add Supervisor to site',
                          size: 20,
                          color: Appcolor.blue,
                          fontWeight: CustomFontWeight.medium,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Appcolor.White),
                          child: DropdownButton<int>(
                            isExpanded: true,
                            elevation: 0,
                            itemHeight: 60,
                            hint: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Please Select Supervisor'),
                            ),
                            value: auth.selectedValue,
                            underline: SizedBox(),
                            items: auth.dummyData
                                .toJson()["data"]
                                .map<DropdownMenuItem<int>>((item) {
                              return DropdownMenuItem<int>(
                                value: item["id"],
                                child: CustomDropdownItem(
                                  name: item['item'],
                                  image: item['image'],
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                Customlog(newValue);
                                auth.selectedValue = newValue;
                                // auth.supervisorId
                              });
                              // Customlog(
                              //     'selectedValue is : ${auth.selectedValue["id"]}  ${auth.selectedValue}');
                            },
                          ),
                        ),
                        const SizedBox(height: 50),
                        MyAnimatedbutton(
                            lable: 'Confirm Supervisor',
                            height: 50,
                            width: size.width,
                            bgcolor: Appcolor.blue,
                            color: Appcolor.White,
                            size: 20,
                            fontweigth: CustomFontWeight.semibold,
                            onPressed: () {
                              Customlog(auth.selectedValue);
                              auth.UpdateSuperVisor(
                                  context,
                                  auth.selectedValue.toString(),
                                  widget.siteId.toString());
                            }),
                      ]),
                ),
        ),
      ),
    );
  }
}

class CustomDropdownItem extends StatelessWidget {
  final String name;
  final String image;

  CustomDropdownItem({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      width: size.width,
      height: 60,
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 2,
        //     blurRadius: 4,
        //     offset: const Offset(0, 2), // changes position of shadow
        //   ),
        // ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          cacheImage(
              'https://jangid.nlaolympiad.in/$image',
              35, // Set the desired width for the image
              35,
              BoxFit.contain // Set the desired height for the image
              ),
          const SizedBox(
              width: 8), // Add spacing between the image and the name
          Text(name),
        ],
      ),
    );
  }
}
