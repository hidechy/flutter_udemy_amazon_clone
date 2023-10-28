import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/shared_prefs.dart';
import '../models/items.dart';
import '../styles/styles.dart';
import 'splash_screen.dart';

// ignore: must_be_immutable
class ItemsDetailsScreen extends StatefulWidget {
  ItemsDetailsScreen({super.key, this.model});

  Items? model;

  @override
  State<ItemsDetailsScreen> createState() => _ItemsDetailsScreenState();
}

class _ItemsDetailsScreenState extends State<ItemsDetailsScreen> {
  ///
  void deleteItem() {
    FirebaseFirestore.instance
        .collection('sellers')
        .doc(sharedPreferences!.getString('uid'))
        .collection('brands')
        .doc(widget.model!.brandID)
        .collection('items')
        .doc(widget.model!.itemID)
        .delete()
        .then((value) {
      FirebaseFirestore.instance.collection('items').doc(widget.model!.itemID).delete();

      Fluttertoast.showToast(msg: 'Item Deleted Successfully.');
      Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(decoration: pinkBackGround),
        title: Text(
          widget.model!.itemTitle.toString(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: deleteItem,
        label: const Text('Delete this Item'),
        icon: const Icon(Icons.delete_sweep_outlined, color: Colors.white),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.model!.thumbnailUrl.toString()),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Text(
              '${widget.model!.itemTitle}:',
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.pinkAccent,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 6),
            child: Text(
              widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              '${widget.model!.price} €',
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.pink,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8, right: 320),
            child: Divider(height: 1, thickness: 2, color: Colors.pinkAccent),
          ),
        ],
      ),
    );
  }
}
