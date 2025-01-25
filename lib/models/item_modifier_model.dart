// models/item_modifier_model.dart
class ItemModifierModel {
  final String id;
  final String modifierGroupId;
  final String storeId;
  final Map<String, String> title;
  final Map<String, dynamic> description;
  final String displayType;
  final List<Map<String, String>> modifierOptions;
  final Map<String, dynamic> quantityConstraintsRules;
  final Map<String, dynamic>? metaData;
  final String createdDate;
  final String modifiedDate;

  ItemModifierModel({
    required this.id,
    required this.modifierGroupId,
    required this.storeId,
    required this.title,
    required this.description,
    required this.displayType,
    required this.modifierOptions,
    required this.quantityConstraintsRules,
     this.metaData,
    required this.createdDate,
    required this.modifiedDate,
  });

  factory ItemModifierModel.fromJson(Map<String, dynamic> json) {
    return ItemModifierModel(
      id: json['ID'] as String,
      modifierGroupId: json['ModifierGroupID'] as String,
      storeId: json['StoreID'] as String,
      title: Map<String, String>.from(json['Title'] as Map),
      description: Map<String, dynamic>.from(json['Description'] as Map),
      displayType: json['DisplayType'] as String,
      modifierOptions: List<Map<String, String>>.from(
        (json['ModifierOptions'] as List).map((item) => Map<String, String>.from(item as Map)),
      ),
      quantityConstraintsRules: Map<String, dynamic>.from(json['QuantityConstraintsRules'] as Map),
      metaData: json['MetaData'] != null
          ? Map<String, dynamic>.from(json['MetaData'] as Map)
          : null,
      createdDate: json['CreatedDate'] as String,
      modifiedDate: json['ModifiedDate'] as String,
    );
  }
}
