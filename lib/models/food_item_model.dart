// models/food_item_model.dart
class FoodItem {
  final String id;
  final String menuItemId;
  final String storeId;
  final Map<String, String> title;
  final Map<String, String> description;
  final String imageUrl;
  final Map<String, dynamic> price;
  final Map<String, String> metaData;
  final double aggregatedProductRating;
  final Map<String, dynamic> nutrientData;
  final Map<String, dynamic> dishInfo;
  final String createdDate;
  final String modifiedDate;
  final Map<String, dynamic> modifierGroupRules;

  FoodItem({
    required this.id,
    required this.menuItemId,
    required this.storeId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.metaData,
    required this.aggregatedProductRating,
    required this.dishInfo,
    required this.nutrientData,
    required this.createdDate,
    required this.modifiedDate,
    required this.modifierGroupRules
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['ID'] as String,
      menuItemId: json['MenuItemID'] as String,
      storeId: json['StoreID'] as String,
      title: Map<String, String>.from(json['Title']),
      description: Map<String, String>.from(json['Description']),
      imageUrl: json['ImageURL'] as String,
      price: Map<String, dynamic>.from(json['PriceInfo']),
      metaData: Map<String, String>.from(json['MetaData']),
      aggregatedProductRating:
          (json['AggregatedProductRating'] as num).toDouble(),
      nutrientData: Map<String, dynamic>.from(json['NutrientData']),
      dishInfo: Map<String, dynamic>.from(json['DishInfo']),
      createdDate: json['CreatedDate'] as String,
      modifiedDate: json['ModifiedDate'] as String,
      modifierGroupRules: Map<String, dynamic>.from(json['ModifierGroupRules']),
    );
  }
}
