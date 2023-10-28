import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/items_card.dart';
import '../components/shared_prefs.dart';
import '../extensions/extensions.dart';
import '../models/brands.dart';
import '../models/items.dart';
import '../styles/styles.dart';
import 'items_upload_screen.dart';

// ignore: must_be_immutable
class ItemsScreen extends StatefulWidget {
  ItemsScreen({super.key, this.model});

  Brands? model;

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(decoration: pinkBackGround),
        title: const Text(
          'iShop',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => ItemsUploadScreen(
                            model: widget.model,
                          )));
            },
            icon: const Icon(
              Icons.add_box_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: context.screenSize.height * 0.8,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('sellers')
              .doc(sharedPreferences!.getString('uid'))
              .collection('brands')
              .doc(widget.model!.brandID)
              .collection('items')
              .orderBy('publishedDate', descending: true)
              .snapshots(),
          // ignore: strict_raw_type
          builder: (context, AsyncSnapshot dataSnapshot) {
            if (dataSnapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final itemsModel = Items.fromJson(
                    // ignore: avoid_dynamic_calls
                    dataSnapshot.data.docs[index].data() as Map<String, dynamic>,
                  );

                  return ItemsCard(
                    model: itemsModel,
                    context: context,
                  );
                },
                // ignore: avoid_dynamic_calls
                itemCount: dataSnapshot.data.docs.length,
              );
            } else {
              return const Center(
                child: Text(
                  'No items exists',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
