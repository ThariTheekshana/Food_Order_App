// views/menu_screen.dart
import 'package:assignment02/models/menu_model.dart';
import 'package:assignment02/views/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen extends StatefulWidget {
  final List<Menu> menus;

  MenuScreen({required this.menus});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
     
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFF1CAE81),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.0.h),
                  child: Text(
                    'Select Menu',
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please select menu',
                  style: GoogleFonts.urbanist(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12.r),
              itemCount: widget.menus.length,
              itemBuilder: (context, index) {
                final menu = widget.menus[index];
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu.title['en']!,
                        style: GoogleFonts.urbanist(
                          textStyle: TextStyle(
                            color: Color(0xFF616161),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Divider()
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CatergotyScreen(menuID: menu.menuId),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
