// views/food_item_page.dart
import 'dart:ui';
import 'package:assignment02/components/ingrediants_containers.dart';
import 'package:assignment02/components/nutritional_text.dart';
import 'package:assignment02/models/food_item_model.dart';
import 'package:assignment02/models/item_modifier_model.dart';
import 'package:assignment02/services/item_modifier_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodItemPage extends StatefulWidget {
  FoodItem foodItem;
  FoodItemPage({super.key, required this.foodItem});

  @override
  State<FoodItemPage> createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  bool _isLoading = true;

  List<ItemModifierModel> _modifiers = [];

  Future<void> _fetchModifiersForSelectedItem() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<String> modifierGroupIds =
          List<String>.from(widget.foodItem.modifierGroupRules['IDs'] as List);

      if (modifierGroupIds.isEmpty) {
        setState(() {
          _isLoading = false;
        });
      }

      List<ItemModifierModel> modifiers =
          await ItemModifierService.fetchModifiersByItemId(modifierGroupIds);

      setState(() {
        _modifiers = modifiers;
        _isLoading = false;
        if (modifiers.isEmpty) {
        } else {
          true;
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _fetchModifiersForSelectedItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 10.0),
              child: Container(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(
                          'assets/images/item.png',
                          //widget.foodItem.imageUrl, // added figma image because json image is not working
                          height: 200.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 300.w),
                            child: Text(
                              widget.foodItem.title['en']!,
                              style: GoogleFonts.urbanist(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "\$ ${widget.foodItem.price['Price']['TablePrice']?.toString() ?? "0.00"}",
                            style: GoogleFonts.urbanist(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Colors.green, size: 26.sp),
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.green, size: 16.sp),
                                SizedBox(width: 4.w),
                                Text(
                                  widget.foodItem.aggregatedProductRating
                                      .toString(),
                                  style: GoogleFonts.urbanist(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: Text(
                          widget.foodItem.description['en']!,
                          style: GoogleFonts.urbanist(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF434E58)),
                        ),
                      ),
                      SizedBox(height: 10.w),
                      DefaultTabController(
                        length: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TabBar(
                              labelColor: Colors.green,
                              isScrollable: true,
                              unselectedLabelColor: Color(0xFF171725),
                              indicatorColor: Colors.green,
                              tabAlignment: TabAlignment.start,
                              tabs: [
                                Tab(text: "Ingredients"),
                                Tab(text: "Nutritional"),
                                Tab(text: "Instructions"),
                                Tab(text: "Allergies"),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 160.h,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 15.0.h,
                                      left: 5.w,
                                    ),
                                    child: TabBarView(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 40.0.w),
                                              child: Text(
                                                "This product contains ingredients that may trigger \nallergies. Please review the ingredient list for details",
                                                //widget.foodItem.dishInfo['Classifications'] ['Ingredients'].toString(), // those values are empty so i hard coded those values

                                                style: GoogleFonts.urbanist(
                                                    fontSize: 12.sp,
                                                    color: const Color(
                                                        0xFF66707A)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 20.0.h),
                                              child: const Row(
                                                children: [
                                                  IngrediantsContainers(
                                                    text: 'Eggs',
                                                  ),
                                                  IngrediantsContainers(
                                                    text: 'Fish',
                                                  ),
                                                  IngrediantsContainers(
                                                    text: 'Milk',
                                                  ),
                                                  IngrediantsContainers(
                                                    text: 'Mollusks',
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Row(
                                              children: [
                                                const IngrediantsContainers(
                                                  text: 'Mustard',
                                                ),
                                                const IngrediantsContainers(
                                                  text: 'Gluten',
                                                ),
                                                SizedBox(
                                                  width: 15.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Text("See more",
                                                        style: GoogleFonts.urbanist(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: const Color(
                                                                0xFF1CAE81))),
                                                    SizedBox(
                                                      width: 5.h,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_outlined,
                                                      color: const Color(
                                                          0xFF1CAE81),
                                                      size: 12.sp,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Nutritional value per 100g",
                                              style: GoogleFonts.urbanist(
                                                  fontSize: 12.sp,
                                                  color:
                                                      const Color(0xFF66707A)),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 30.0.w),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  NutritionalText(text: "198"),
                                                  NutritionalText(text: "14.1"),
                                                  NutritionalText(text: "19.6"),
                                                  NutritionalText(text: "6.6"),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 10.0.w),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  NutritionalText(text: "Kcal"),
                                                  NutritionalText(
                                                      text: "Protiens"),
                                                  NutritionalText(text: "Fats"),
                                                  NutritionalText(
                                                      text: "Carbo H"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Cooking Instructions",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 12.sp,
                                              color: const Color(0xFF66707A)),
                                        ),
                                        Text(
                                          "Allergies",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [Container()],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (_modifiers.isNotEmpty && !_isLoading)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(thickness: 2, height: 20.h),
                            Text(
                              "Toppings",
                              style: GoogleFonts.urbanist(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF171725)),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            ..._modifiers.map((modifier) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(modifier.title['en']!,
                                      style: GoogleFonts.urbanist(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF171725))),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Divider(thickness: 2, height: 20.h),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Add Comments (Optional)",
                        style: GoogleFonts.urbanist(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF19120E)),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Write here",
                          hintStyle: GoogleFonts.urbanist(
                            fontSize: 14.sp,
                            color: const Color(0xFFA7A19E),
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 2.0.w,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 130.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: const Color(0xFFE8E8E8)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20.w,
                                ),
                                const Icon(
                                  Icons.remove,
                                  color: Color(0xFF1CAE81),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text('1',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: const Color(0xFF201A18),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    )),
                                SizedBox(
                                  width: 20.w,
                                ),
                                const Icon(
                                  Icons.add,
                                  color: Color(0xFF1CAE81),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 180.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: const Color(0xFF1CAE81)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Add to Cart',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: const Color(0xFFFFFFFF),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  Text('₹1260',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: const Color(0xFFFFFFFF),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
