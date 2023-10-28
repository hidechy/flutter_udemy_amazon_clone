import 'package:flutter/material.dart';

import '../models/brands.dart';

// ignore: must_be_immutable
class BrandsCard extends StatefulWidget {
  BrandsCard({super.key, this.model, this.context});

  Brands? model;
  BuildContext? context;

  @override
  State<BrandsCard> createState() => _BrandsCardState();
}

class _BrandsCardState extends State<BrandsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          height: 270,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Image.network(
                widget.model!.thumbnailUrl.toString(),
                height: 220,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.model!.brandTitle.toString(),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 3,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_sweep,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
