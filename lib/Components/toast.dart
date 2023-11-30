import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class Toast{
  void Success(BuildContext context,String message,String Descript){
    
MotionToast.success(
	title:  Text(message),
	description:  Text(Descript),
).show(context);

  }
    void Fail(BuildContext context,String message,String Descript){

MotionToast.error(
	title:  Text(message),
	description:  Text(Descript)  
).show(context);


  }
  void warning(BuildContext context,String message,String Descript){

MotionToast.warning(
	title:  Text(message),
	description:  Text(Descript)  
).show(context);


  }
  void delete(BuildContext context,String message,String Descript){

MotionToast.delete(
	title:  Text(message),
	description:  Text(Descript)  
).show(context);


  }
    
}