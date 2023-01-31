import 'package:flutter/material.dart';
import 'package:miaged/const/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton (String buttonText,onPressed){
  return Center(
    child: SizedBox(
      width: 0.5.sw,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.white, fontSize: 25),
        ),
        style: ElevatedButton.styleFrom(
          primary: AppColors.vinted_color,
          elevation: 3,
        ),
      ),
    ),
  );
}