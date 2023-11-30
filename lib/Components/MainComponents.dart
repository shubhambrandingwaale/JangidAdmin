import 'package:attendance_admin/Cards/SuperVisorCard.dart';
import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/Image.dart';
import 'package:attendance_admin/Models/Brain.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/widgets/Regular.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainComponents {
  Widget Button(txt, Function() func, Color btcolor) {
    return MaterialButton(
      onPressed: () => func(),
      color: btcolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          txt,
          style: GoogleFonts.poppins(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget Textfields(label, TextEditingController editController, hint,
      IconData iconData, TextInputType keyboardtype) {
    return TextField(
      controller: editController,
      keyboardType: keyboardtype,
      style: GoogleFonts.poppins(fontSize: 13),
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: light_black, style: BorderStyle.solid)),
          label: Text(label),
          hintText: hint,
          labelStyle: GoogleFonts.poppins(fontSize: 13),
          prefixIcon: Icon(iconData)),
    );
  }

  Widget Wallet(wallettxt, Function() wallet) {
    return GestureDetector(
      onTap: wallet,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 0.5, // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            MainComponents().txtview14(wallettxt),
            const SizedBox(
              width: 10,
            ),
            MainComponents().Images(logout, 30.0)
          ],
        ),
      ),
    );
  }

  Widget Cards(
      TextEditingController usercontroller,
      TextEditingController passwordcontrol,
      func,
      btcolor,
      TextInputType txttype,
      {Function? passwordToggle,
      bool isPasswordVisible = true}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                MainComponents().Textfields("username", usercontroller,
                    "Enter Username", Icons.person, txttype),
                const SizedBox(
                  height: 10,
                ),
                // MainComponents().Textfields("password", passwordcontrol,
                //     "Enter Password", Icons.lock, txttype),
                TextField(
                  controller: passwordcontrol,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.poppins(fontSize: 13),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: light_black, style: BorderStyle.solid)),
                      label: Text("Password"),
                      hintText: "Enter password",
                      labelStyle: GoogleFonts.poppins(fontSize: 13),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: InkWell(
                          onTap: () {
                            if (passwordToggle != null) {
                              passwordToggle!();
                            }
                          },
                          child: isPasswordVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off))),
                  obscureText: !isPasswordVisible,
                ),
                const SizedBox(
                  height: 10,
                ),
                MainComponents().Button("Login", func, btcolor)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget txtview28(txt) {
    return Text(
      txt,
      style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    );
  }

  Widget txtview22(txt) {
    return Text(
      txt,
      style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
      textAlign: TextAlign.start,
    );
  }

  Widget txtview14(txt) {
    return Text(txt,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center);
  }

  Widget txtview13(txt) {
    return Text(txt,
        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400),
        textAlign: TextAlign.center);
  }

  Widget txtview15(txt) {
    return Text(txt,
        style: GoogleFonts.poppins(
            fontSize: 19, fontWeight: FontWeight.w500, color: blue),
        textAlign: TextAlign.center);
  }

  Widget txtview11(txt) {
    return Text(txt,
        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w400),
        textAlign: TextAlign.center);
  }

  Widget txtview10(txt) {
    return Text(txt,
        style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400),
        textAlign: TextAlign.center);
  }

  Widget txtview12(txt) {
    return Text(txt,
        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
        textAlign: TextAlign.center);
  }

  Widget txtview18(txt) {
    return Text(
      txt,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: blue,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget back(
    txt,
    Function() back,
  ) {
    return GestureDetector(
      onTap: back,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2), // changes position of shadow
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
                    Regular(text: 'Back', size: 15, color: Appcolor.blue),
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
          ],
        ),
      ),
    );
  }

  Widget Images(location, imgWidth) {
    return Image.asset(
      location,
      width: imgWidth,
    );
  }

  Widget homeCards(image, uptxt, lowtxt, sublowtxt) {
    return Card(
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Images(image, 45.0),
          const SizedBox(
            width: 3,
          ),
          Container(
            color: Colors.white,
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: txtview12(uptxt),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      txtview18(lowtxt),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: txtview11(sublowtxt),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget homeCards2(
    BuildContext context,
    location,
    Function() allsites,
    txt,
  ) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.40,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Appcolor.blue,
        elevation: 10,
        onPressed: () => allsites(),
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Images(location, 30.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                txt,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )),
            )
          ],
        ),
      ),
    );
  }

  Widget SiteLocation1(txt, bt1txt, imbt1, BuildContext context, Routes) {
    return Card(
      elevation: 10,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(3, 3, 3, 5),
                alignment: Alignment.centerLeft,
                child: txtview18(txt)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                homeCards2(context, imbt1,
                    () => BrainCode().Navigatorpush(context, Routes), bt1txt),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget SiteLocation2(txt, bt1txt, bt2txt, imbt1, imbt2, BuildContext context,
      Routes1, Routes2) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: decoration(Colors.white),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(3, 3, 3, 5),
                alignment: Alignment.centerLeft,
                child: txtview18(txt)),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                homeCards2(context, imbt1,
                    () => BrainCode().Navigatorpush(context, Routes1), bt1txt),
                homeCards2(context, imbt2,
                    () => BrainCode().Navigatorpush(context, Routes2), bt2txt)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget Deductions_list(int length) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      child: Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, index) {
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
                              Images(working, 40.0),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  txtview18("Sanjeev Singh"),
                                  txtview13("sent 15:22, 17 Oct, 2023"),
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
                            child: txtview14("-1510 ₹"),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Divider(
                        color: lowblack,
                        thickness: .1,
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget wallet_back(txt, txt2, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MainComponents().back(txt, () => Routesapp.gotoBackPage(context)),
          MainComponents()
              .Wallet(txt2, () => BrainCode().Navigatorpops(context)),
        ],
      ),
    );
  }

  Widget card_with_txt_bt(heading, maintxt, btntxt, btncolor, context, routes) {
    return Container(
      decoration: decoration(Colors.white),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.centerLeft, child: txtview12(heading)),
                txtview22(maintxt),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.all(15),
              color: btncolor,
              onPressed: () => {BrainCode().Navigatorpush(context, routes)},
              child: Text(
                btntxt,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget Popup() {
    return PopupMenuButton<String>(
      onSelected: (String choice) {
        if (choice == 'Edit') {
        } else if (choice == 'Delete') {}
      },
      icon: const Icon(Icons.more_vert), // This makes the icon clickable
      itemBuilder: (BuildContext context) {
        return ['Edit', 'Delete'].map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  BoxDecoration decoration(decocolor) {
    return BoxDecoration(
        color: decocolor, borderRadius: BorderRadius.circular(10));
  }

  Widget AllSupervisors(List supervisorlist) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: supervisorlist.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, index) {
            return SuperVisorCard(
              superVisordata: supervisorlist[index],
            );
          }),
    );
  }
}
