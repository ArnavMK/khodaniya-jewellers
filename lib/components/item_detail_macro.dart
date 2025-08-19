import 'package:flutter/material.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';

class ItemDetailMacro extends StatelessWidget {

  final Icon icon;
  final String content;

  const ItemDetailMacro({
    super.key,
    required this.icon,
    required this.content
  });

  @override
  Widget build(BuildContext context) {    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(
          color: Colors.grey.shade400,
          offset: Offset(2, 2),
          blurRadius: 5,
        )],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Icon(
              icon.icon,
              size: 19,
              color: AppColors.primary,
            ),
            const SizedBox(height: 5),
            Text (
              content,
              style: TextStyle(
                color: Colors.black, 
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
