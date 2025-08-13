import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:khodaniya_jewellers/screens/screens.dart';
import 'package:stock_repository/models/models.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:stock_repository/constants/costants.dart';
import 'package:khodaniya_jewellers/components/components.dart';

class ItemTile extends StatelessWidget {
  final int index;

  const ItemTile({
    super.key,
    required this.index,
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
    Item item = LocalStockDatabase.instance.getAllStocks().elementAt(index);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) {
          return ItemDetailsScreen(item: item);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(3, 3),
              color: Colors.grey.shade300,
              blurRadius: 3
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: 160,
                        child: MyImageBuilder(imageURL: item.image),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
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
                        ),
                        const SizedBox(width: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.cyan.withAlpha(50),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              item.type,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ), 
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.description,
                      style: TextStyle(
                        color: Colors.grey.withAlpha(200),
                        fontSize: 9,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${item.grossWeight}g',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Icon(CupertinoIcons.arrow_right_circle_fill, color: Colors.black, size: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
