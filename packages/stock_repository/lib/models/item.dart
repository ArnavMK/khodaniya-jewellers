import '../constants/costants.dart';

class Item {
  final String id;
  final String name;
  final String description;
  final String image;
  final double grossWeight;
  final double weight;
  final String type;
  final String material;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.grossWeight,
    required this.weight,
    required this.image,
    required this.type, 
    required this.material,
  });

  @override
  String toString() {
    return 'Item{id: $id, name: $name, description: $description, grossWeight: $grossWeight, weight: $weight, image: $image, type: $type, material: $material}';
  }
  
  Map<String, dynamic> toJson() {
    return {
      DataFields.id: id,
      DataFields.name: name,
      DataFields.description: description,
      DataFields.grossWeight: grossWeight,
      DataFields.weight: weight,
    };
  } 

  factory Item.fromJson(Map<String, dynamic> json) {

    return Item(
      image: json[DataFields.image] as String? ?? '',
      id: json[DataFields.id] as String,
      name: json[DataFields.name] as String,
      description: json[DataFields.description] as String,
      grossWeight: (json[DataFields.grossWeight] as num).toDouble(),
      weight: (json[DataFields.weight] as num).toDouble(),
      type: json[DataFields.type] as String? ?? '',
      material: json[DataFields.material] as String? ?? '',
    );
  }
}
