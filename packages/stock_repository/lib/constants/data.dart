
import '../models/models.dart';
import 'costants.dart';

Iterable<Item> items = [
  Item(
    image: 'assets/images/item1.png',
    id: '1',
    name: 'Item 1',
    description: 'Description of Item 1',
    grossWeight: 10.0,
    weight: 8.0,
    type: DataFields.necklace,
    material: DataFields.gold, 
  ),
  Item(
    image: 'assets/images/item2.png',
    id: '2',
    name: 'Item 2',
    description: 'Description of Item 2',
    grossWeight: 15.0,
    weight: 12.0,
    type: DataFields.bracelet,
    material: DataFields.silver, 
  ),
  Item(
    image: 'assets/images/item3.png',
    id: '3',
    name: 'Item 3',
    description: 'Description of Item 3',
    grossWeight: 20.0,
    weight: 18.0,
    type: DataFields.ring,
    material: DataFields.gold, 
  ),
];
