// models/menu_model.dart
class Menu {
  final String id;
  final String menuId;
  final Map<String, String> title;
  final String verticalId;
  final String storeId;
  final String? subTitle;
  final String? description; 
  final Map<String, Map<String, String>> menuAvailability;
  final List<String> menuCategoryIds;
  final String createdDate;
  final String modifiedDate;
  final String? createdBy; 
  final String? modifiedBy; 

  Menu({
    required this.id,
    required this.menuId,
    required this.title,
    required this.verticalId,
    required this.storeId,
    this.subTitle, 
    this.description,
    required this.menuAvailability,
    required this.menuCategoryIds,
    required this.createdDate,
    required this.modifiedDate,
    this.createdBy,
    this.modifiedBy, 
  });

 
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['ID'],
      menuId: json['MenuID'],
      title: Map<String, String>.from(json['Title'] ?? {}),
      verticalId: json['VerticalID'],
      storeId: json['StoreID'],
      subTitle: json['SubTitle'], 
      description: json['Description'],
      menuAvailability: Map<String, Map<String, String>>.from(
        json['MenuAvailability']?.map((key, value) => MapEntry(
          key as String,
          Map<String, String>.from(value as Map),
        )) ?? {},
      ),
      menuCategoryIds: List<String>.from(json['MenuCategoryIDs'] ?? []),
      createdDate: json['CreatedDate'],
      modifiedDate: json['ModifiedDate'],
      createdBy: json['CreatedBy'], 
      modifiedBy: json['ModifiedBy'],
    );
  }
}



