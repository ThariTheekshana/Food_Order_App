// components/ingrediants_containers.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IngrediantsContainers extends StatelessWidget {
  final String text;
  const IngrediantsContainers({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(text,
            style: GoogleFonts.urbanist(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF66707A))),
      ),
      width: 65.w,
      height: 35.h,
      margin: EdgeInsets.only(right: 8.0.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
    );
  }
}
