import '../constants/costants.dart';

class Item {
  /// unique id of the item
  final String id;

  /// name of the item
  final String name;

  final String description;

  /// image url for the item image
  final String image;

  /// total weight of the item with the stones and accesories
  final double grossWeight;

  /// this is the weight of the total gold or silver in the item
  final double netWeight;

  /// purity of the item in percentage, for example 22k gold is 91.67% pure
  final int purity;

  /// type: necklace, foot wear etc.. 
  final String type;

  /// sizes: the sizes of this item
  final String size;

  /// material: gold or silver
  final String material;

  bool isFavorite = false;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.grossWeight,
    required this.image,
    required this.type, 
    required this.material,
    required this.netWeight,
    required this.purity,
    required this.size,
  });

  @override
  String toString() {
    return 'Item{id: $id, name: $name, description: $description, grossWeight: $grossWeight, netWeight: $netWeight, purity: $purity, type: $type, material: $material}';
  }
  
  Map<String, dynamic> toJson() {
    return {
      DataFields.id: id,
      DataFields.name: name,
      DataFields.description: description,
      DataFields.grossWeight: grossWeight,
      DataFields.netWeight: netWeight,
    };
  } 

  factory Item.fromJson(Map<String, dynamic> json) {

    return Item(
      image: json[DataFields.image] as String? ?? '',
      id: json[DataFields.id] as String,
      name: json[DataFields.name] as String,
      description: json[DataFields.description] as String,
      grossWeight: (json[DataFields.grossWeight] as num).toDouble(),
      netWeight: (json[DataFields.netWeight] as num).toDouble(),
      purity: (json[DataFields.purity] as num?)?.toInt() ?? 0,
      type: json[DataFields.type] as String? ?? '',
      material: json[DataFields.material] as String? ?? '',
      size: json[DataFields.size] as String? ?? '',
    );
  }
}
