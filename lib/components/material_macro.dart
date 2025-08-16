import 'package:flutter/material.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:stock_repository/constants/costants.dart';
import 'package:stock_repository/models/models.dart';

class MaterialMacro extends StatelessWidget {
  final Item item;

  const MaterialMacro({
    super.key,
    required this.item,
  }); 

  Color _getMacroColor(Item item) {
    if (item.material == DataFields.gold) {
      return AppColors.gold.withAlpha(150);
    }
    // if its silver;
    return AppColors.silver;
  }

  Color _getTextColor(Item item) {
    if (item.material == DataFields.gold) {
      return Colors.brown.withAlpha(150);
    }
    // if its silver;
    return Colors.white; 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getMacroColor(item),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          item.material + '-piece',
          style: TextStyle(
            color: _getTextColor(item),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
