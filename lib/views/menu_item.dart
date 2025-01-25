// views/menu_item.dart
import 'package:assignment02/models/category_model.dart';
import 'package:assignment02/models/food_item_model.dart';
import 'package:assignment02/services/category_services.dart';
import 'package:assignment02/services/food_item_service.dart';
import 'package:assignment02/services/menu_services.dart';
import 'package:assignment02/views/food_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItemScreen extends StatefulWidget {
 
  final String menuID;
  MenuItemScreen({super.key, required this.menuID});

  @override
  State<MenuItemScreen> createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<MenuItemScreen> {
  int selectedIndex = 0;
  List<FoodItem> categoryItems = [];

  List<MenuCategory> _categories = [];
  bool _isLoading = true;

  Future<void> fetchSelectedCategoryItems() async {
    setState(() {
      _isLoading = true;
    });

    if (selectedIndex < 0 || _categories.isEmpty) {
      setState(() {
        categoryItems = [];
        _isLoading = false;
      });
      return;
    }

    try {
      List<String> menuEntitiesIDs = _categories[selectedIndex]
          .menuEntities
          .map((entity) => entity['ID'] as String)
          .toList();

      List<FoodItem> foodItems =
          await FoodItemService.fetchFoodItemsbyIDs(menuEntitiesIDs);

      setState(() {
        _isLoading = false;
        categoryItems = foodItems;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    
    }
  }

  Future<void> _fetchCategories() async {
    try {
      final menu = await MenuServices.fetchMenuByMenuId(widget.menuID);

      final categories =
          await CategoryServices.fetchCategoriesByMenuCategoryIds(
              menu.menuCategoryIds);

      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      print('Error fetching categories: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _fetchCategories();
      if (_categories.isNotEmpty) {
        await fetchSelectedCategoryItems();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.0, left: 15.w),
              child: Row(
                children: [
                  Container(
                    width: 160.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xFFE8E8E8)),
                    child: Center(
                      child: Text(
                        "Lunch menu".toUpperCase(),
                        style: GoogleFonts.urbanist(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 140.w,
                  ),
                  Image.asset(
                    'assets/images/search.png',
                    width: 30.w,
                    height: 30.h,
                    color: Colors.black,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 15.w),
              child: SizedBox(
                height: 40.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          width: 120.w,
                          margin: EdgeInsets.only(right: 10.0.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border:
                                  Border.all(color: Colors.black, width: 1.w),
                              color: selectedIndex == index
                                  ? const Color(0xFF1CAE81)
                                  : const Color(0XFFFFFFFF)),
                          child: Center(
                            child: Text(
                              _categories[index].title['en']!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.urbanist(
                                textStyle: TextStyle(
                                    color: selectedIndex == index
                                        ? const Color(0xFFFFFFFF)
                                        : Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 200.0.w),
                      child: Text(
                        _isLoading
                            ? "Loading... "
                            : _categories[selectedIndex]
                                .title["en"]!
                                .toUpperCase(),
                        style: GoogleFonts.urbanist(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500, // this name change according to user preferences
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 500.h,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: categoryItems.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodItemPage(
                                        foodItem: categoryItems[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/images/food.png',
                                        width: 70.w,
                                        height: 70.h,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(width: 20.w),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(right: 10.0.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 20.0.w),
                                                child: Text(
                                                  _isLoading
                                                      ? "Loading... "
                                                      : categoryItems[index]
                                                          .title['en']!,
                                                  style: GoogleFonts.urbanist(
                                                    fontSize: 16.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 20.0.w),
                                                child: Text(
                                                  _isLoading
                                                      ? "Loading... "
                                                      : categoryItems[index]
                                                          .description['en']!,
                                                  style: GoogleFonts.urbanist(
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 10.h),
                                              Text(
                                                _isLoading
                                                    ? "Loading... "
                                                    : "\$ ${categoryItems[index].price['Price']['TablePrice']?.toString() ?? "0.00"}",
                                                style: GoogleFonts.urbanist(
                                                  fontSize: 14.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1.0,
                                color: Colors.grey[300],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
