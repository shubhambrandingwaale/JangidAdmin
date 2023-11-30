import 'dart:math';

import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/addSiteLocation/controller/AddSiteLocationRepository.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/CustomFont.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/widgets/AnimatedButton.dart';
import 'package:attendance_admin/widgets/Regular.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AddLocationMapController extends StatelessWidget {
  AddLocationMapController(
      {Key? key, required this.siteId, required this.isComeFromHome})
      : super(key: key);
  bool isComeFromHome;
  int siteId;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AddSiteLocationRepository(),
      child: Consumer(
        builder: (context, AddSiteLocationRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return AddLocationMap(
                  siteId: siteId, isComeFromHome: isComeFromHome);
            case Status.Unauthenticated:
              return AddLocationMap(
                  siteId: siteId, isComeFromHome: isComeFromHome);
            case Status.Authenticating:
              return AddLocationMap(
                  siteId: siteId, isComeFromHome: isComeFromHome);
            case Status.Authenticated:
              return AddLocationMap(
                  siteId: siteId, isComeFromHome: isComeFromHome);
            case Status.error:
              return AddLocationMap(
                  siteId: siteId, isComeFromHome: isComeFromHome);
          }
        },
      ),
    );
  }
}

class AddLocationMap extends StatefulWidget {
  AddLocationMap(
      {super.key, required this.siteId, required this.isComeFromHome});
  int siteId;
  bool isComeFromHome;
  @override
  State<AddLocationMap> createState() => _AddLocationMapState();
}

class _AddLocationMapState extends State<AddLocationMap> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(milliseconds: 10), () async {
      final auth = context.read<AddSiteLocationRepository>();
      print(await auth.checkGPSStatus());
      if (!auth.isGPSEnabled) {
        setState(() {});
      }
      print(await auth.getCurrentLocation(context));
    });
    super.initState();
  }

  GoogleMapController? _controller;
  double _circleRadius = 0.0;
  LatLng _circleCenter = LatLng(37.7749, -122.4194); // Initial center

  Set<Circle> _circles = {};

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AddSiteLocationRepository>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: light_black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: !auth.isLocationFetched
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Routesapp.gotoBackPage(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
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
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.40,
                      child: GoogleMap(
                        onMapCreated: (controller) {
                          setState(() {
                            _controller = controller;
                          });
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(auth.latitude,
                              auth.longtitude), // Initial map center position
                          zoom: 15.0, // Initial zoom level
                        ),
                        circles: <Circle>{
                          Circle(
                            circleId: const CircleId('circle_1'),
                            center: LatLng(auth.latitude,
                                auth.longtitude), // Center of the circle
                            radius: _circleRadius,
                            fillColor: Colors.blue.withOpacity(0.3),
                            strokeWidth: 2,
                          ),
                        },
                        markers: <Marker>{
                          Marker(
                            markerId: const MarkerId("currentLocation"),
                            position: LatLng(
                              auth.latitude,
                              auth.longtitude,
                            ),
                            infoWindow: const InfoWindow(
                              title: "Current Location",
                            ),
                          ),
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(10.0),
                      width: size.width,
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Regular(
                              text: 'Company Location',
                              size: 15,
                              color: Appcolor.grey,
                              fontWeight: CustomFontWeight.semibold,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Regular(
                              text: auth.comapnyAddress,
                              size: 14,
                              color: Appcolor.black,
                              textOverflow: TextOverflow.ellipsis,
                              fontWeight: CustomFontWeight.regular,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(10.0),
                      width: size.width,
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Regular(
                              text: 'Radius to Location',
                              size: 15,
                              color: Appcolor.grey,
                              fontWeight: CustomFontWeight.semibold,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Regular(
                                  text: '0m',
                                  size: 16,
                                  color: Appcolor.black,
                                  fontWeight: CustomFontWeight.semibold,
                                ),
                                Expanded(
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      valueIndicatorColor: Colors.black,
                                      inactiveTrackColor:
                                          const Color(0xFF8D8E98),
                                      thumbColor: Appcolor.blue,
                                      activeTrackColor: Appcolor.blue,
                                      overlayColor: const Color(0x29EB1555),
                                      thumbShape: const RoundSliderThumbShape(
                                          enabledThumbRadius: 12.0),
                                      overlayShape:
                                          const RoundSliderOverlayShape(
                                              overlayRadius: 20.0),
                                    ),
                                    child: Slider(
                                      value: _circleRadius,
                                      min: 0.0,
                                      max: 1000.0,
                                      label: _circleRadius.round().toString(),
                                      divisions: 100,
                                      onChanged: (value) {
                                        setState(() {
                                          _circleRadius = value;
                                          _updateCircleRadius();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Regular(
                                  text: '1000m',
                                  size: 16,
                                  color: Appcolor.black,
                                  fontWeight: CustomFontWeight.semibold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: MyAnimatedbutton(
                          lable: 'Confirm Location',
                          height: 50,
                          width: size.width,
                          bgcolor: Appcolor.blue,
                          color: Appcolor.White,
                          size: 20,
                          fontweigth: CustomFontWeight.semibold,
                          onPressed: () {
                            auth.UpdateSiteLocation(context, _circleRadius,
                                widget.siteId, widget.isComeFromHome);
                          }),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  void _updateCircleRadius() {
    final newCircle = Circle(
      circleId: CircleId('circle_1'),
      center: _circleCenter,
      radius: _circleRadius,
      fillColor: Colors.blue.withOpacity(0.3),
      strokeWidth: 2,
    );

    setState(() {
      // Remove the existing circle and add the updated one
      _circles.clear();
      _circles.add(newCircle);
    });
  }
}
