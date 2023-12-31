import 'package:flutter/material.dart';

import '../models/items.dart';
import '../screens/items_details_screen.dart';

// ignore: must_be_immutable
class ItemsCard extends StatefulWidget {
  ItemsCard({super.key, this.model, this.context});

  Items? model;
  BuildContext? context;

  @override
  State<ItemsCard> createState() => _ItemsCardState();
}

class _ItemsCardState extends State<ItemsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => ItemsDetailsScreen(model: widget.model)),
        );
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(height: 2),
                Text(
                  widget.model!.itemTitle.toString(),
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 2),
                Image.network(
                  widget.model!.thumbnailUrl.toString(),
                  height: 220,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.model!.itemInfo.toString(),
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
