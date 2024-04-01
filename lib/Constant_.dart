import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class Constants {

  // Color primaryAppColor = const Color(0xff5D5FEF);
  Color primaryAppColor = const Color(0xff37d1d3);
  Color btnTextColor  = const Color(0xffFFFFFF);
  Color headerColor=Colors.grey.shade200;
   String avator = 'assets/images/ellipse-92-bg.png';
   String EmptyDocument = 'assets/Empty Data.json';
   String docid="HbRb0XiGytHNAWtiaUEN";
   String deleteLottiefile="assets/delete anima.json";
   String ErrorLottiefile="assets/final Error Ani.json";
   String Lottiefile="assets/emptystate.json";
   String whiteshadeimg="assets/white-trianglify-b79c7e1f.jpg";
   String patterImg="assets/patttern.png";

   String deleteUserSvg="assets/Delete Users.svg";
   String userLogoutSvg="assets/Logout img.svg";
   String userSuccessSvg="assets/Success Users.svg";
  static   String flagvalue= "en";
  static    String langvalue='English';
  datePicker(context) async{
    DateTime? pickedDate = await DatePicker.showSimpleDatePicker(context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
      dateFormat: "dd-MM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );
    return pickedDate;
  }

}