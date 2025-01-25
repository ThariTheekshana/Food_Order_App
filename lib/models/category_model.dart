// models/category_model.dart
class MenuCategory {
  final String id;
  final String menuCategoryId;
  final String menuId;
  final String storeId;
  final Map<String, String> title;
  final Map<String, dynamic>? subTitle; 
  final List<Map<String, String>> menuEntities;
  final String createdDate;
  final String modifiedDate;
  final String? createdBy; 
  final String? modifiedBy; 

  //since menu items has more attributes, I only used here mandatory attributes only
  MenuCategory({
    required this.id,
    required this.menuCategoryId,
    required this.menuId,
    required this.storeId,
    required this.title,
    this.subTitle,
    required this.menuEntities,
    required this.createdDate,
    required this.modifiedDate,
    this.createdBy, 
    this.modifiedBy, 
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json['ID'],
      menuCategoryId: json['MenuCategoryID'],
      menuId: json['MenuID'],
      storeId: json['StoreID'],
      title: Map<String, String>.from(json['Title'] ?? {}),
      subTitle: json['SubTitle'], 
      menuEntities: List<Map<String, String>>.from(
        (json['MenuEntities'] ?? []).map(
          (item) => Map<String, String>.from(item),
        ),
      ),
      createdDate: json['CreatedDate'],
      modifiedDate: json['ModifiedDate'],
      createdBy: json['CreatedBy'], 
      modifiedBy: json['ModifiedBy'], 
    );
  }
}
