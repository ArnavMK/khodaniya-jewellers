import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:khodaniya_jewellers/screens/screens.dart';
import 'package:stock_repository/models/models.dart';
import 'package:khodaniya_jewellers/components/components.dart';
import 'package:user_repository/user_repository.dart';

class ItemTile extends StatefulWidget {
  final Item item;

  const ItemTile({
    super.key,
    required this.item 
  });

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) {
          return ItemDetailsScreen(item: widget.item);
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
                        child: MyImageBuilder(imageURL: widget.item.image),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        MaterialMacro(item: widget.item),
                        const SizedBox(width: 5),
                        TypeMacro(item: widget.item),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ), 
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.item.description,
                      style: TextStyle(
                        color: Colors.grey.withAlpha(200),
                        fontSize: 8,
                        fontWeight: FontWeight.w300
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                      Row(
                        children: [
                          Text(
                            '${widget.item.netWeight}g',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            'net',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (widget.item.isFavorite) {
                          UserRepository.instance.currentUser?.removeItemFromFavorites(widget.item);
                          widget.item.isFavorite = false;
                        }
                        else {
                          UserRepository.instance.currentUser?.addItemToFavorites(widget.item);
                          widget.item.isFavorite = true;
                        }
                      });                      
                    },
                    child: _getIcon(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Icon _getIcon() {
    if (widget.item.isFavorite) {
      return Icon(
        CupertinoIcons.minus_circle_fill,
        size: 20, 
      );
    }
    else {
      return Icon(
        CupertinoIcons.add_circled_solid,
        size: 20, 
      );
    }
  }
}
