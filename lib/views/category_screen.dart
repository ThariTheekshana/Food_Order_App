// views/category_screen.dart
import 'package:assignment02/models/category_model.dart';
import 'package:assignment02/services/category_services.dart';
import 'package:assignment02/services/menu_services.dart';
import 'package:assignment02/views/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CatergotyScreen extends StatefulWidget {
  final String menuID;

  const CatergotyScreen({super.key, required this.menuID});

  @override
  State<CatergotyScreen> createState() => _CatergotyScreenState();
}

class _CatergotyScreenState extends State<CatergotyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // List<MenuCategory> _categories = [];
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // _fetchCategories();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  // Future<void> _fetchCategories() async {
  //   try {

  //     final menu = await MenuServices.fetchMenuByMenuId(widget.menuID);

  //    // print(menu);
  //    // print(menu.menuCategoryIds);

  //     final categories =
  //         await CategoryServices.fetchCategoriesByMenuCategoryIds(
  //             menu.menuCategoryIds);

  //    // print(categories);

  //     setState(() {
  //       _categories = categories;
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     // Handle error (e.g., show a snackbar or error dialog)
  //     print('Error fetching categories: $e');
  //   }
  // }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 3,
        child: Stack(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/coverImage.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 190.h),
                Center(
                  child: Container(
                    width: 220.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      onTap: (index) {
                        setState(() {
                          _tabController.index = index;
                        });
                      },
                      indicator: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      labelPadding: EdgeInsets.zero,
                      tabs: List.generate(3, (index) {
                        bool isSelected = _tabController.index == index;
                        return Container(
                          width: 65.w,
                          height: 44.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: isSelected
                                ? Color(0xFFEBEFF8)
                                : Colors.transparent,
                          ),
                          child: Tab(
                            child: Image.asset(
                              index == 0
                                  ? 'assets/images/bike.png'
                                  : index == 1
                                      ? 'assets/images/bag.png'
                                      : 'assets/images/sit.png',
                              color: isSelected
                                  ? Color(0xFF1CAE81)
                                  : Color(0xFF333333),
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Center(
                        child: Text(
                          'delivery Content',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ),
                      MenuItemScreen(
                        menuID: widget.menuID,
                      ),
                      Center(
                        child: Text(
                          'Chair Content',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 100.h,
              left: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "El Cabanyal",
                    style: GoogleFonts.urbanist(
                      fontSize: 36.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "FASTFOOD · BURGERS",
                    style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100.h,
              right: 20.w,
              child: Image.asset(
                'assets/images/coverImage2.png',
                width: 70.w,
                height: 70.h,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
