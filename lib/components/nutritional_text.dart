// components/nutritional_text.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NutritionalText extends StatelessWidget {
  final String text;
  const NutritionalText({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          GoogleFonts.urbanist(fontSize: 12.sp, color: const Color(0xFF66707A)),
    );
  }
}
