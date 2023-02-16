import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/boarding_model.dart';


class BoardingItem extends StatelessWidget {
  final BoardingModel boardingModel;

  const BoardingItem({required this.boardingModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(image: AssetImage(boardingModel.image)),
        ),
         SizedBox(
          height: 40.h,
        ),
        Text(boardingModel.title,
            style: GoogleFonts.poppins(
              fontSize: 23.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            )),
        Text(boardingModel.description,
            style: TextStyle(fontSize: 23.sp)),
      ],
    );
  }
}
