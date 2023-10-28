import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../models/sellers.dart';

// ignore: must_be_immutable
class SellersCard extends StatefulWidget {
  SellersCard({super.key, this.model});

  Sellers? model;

  @override
  State<SellersCard> createState() => _SellersCardState();
}

class _SellersCardState extends State<SellersCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black54,
      elevation: 20,
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 270,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  widget.model!.photoUrl.toString(),
                  height: 220,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                widget.model!.name.toString(),
                style: const TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SmoothStarRating(
                rating: widget.model!.ratings == null ? 0.0 : double.parse(widget.model!.ratings.toString()),
                color: Colors.pinkAccent,
                borderColor: Colors.pinkAccent,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
