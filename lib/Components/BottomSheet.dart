import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Bottomsheet{
  void sheet(BuildContext context){
     showModalBottomSheet<void>(
           
            context: context,
            builder: (BuildContext context) {
             
              return Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                   Lottie.asset('assets/images/loader.json',width: 50),
                   SizedBox(width: 15,),
                   MainComponents().txtview15("Loading")
                  ],
                ),
              );
            },
          );
  }
}