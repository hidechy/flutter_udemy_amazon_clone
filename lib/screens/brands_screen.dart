import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/brands_card.dart';
import '../extensions/extensions.dart';

//import '../components/drawer.dart';
import '../models/brands.dart';
import '../models/sellers.dart';
import '../styles/styles.dart';

// ignore: must_be_immutable
class BrandsScreen extends StatefulWidget {
  BrandsScreen({super.key, this.model});

  Sellers? model;

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
//      drawer: const MyDrawer(),
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
      ),
      body: SizedBox(
        height: context.screenSize.height * 0.8,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('sellers')
              .doc(widget.model!.uid.toString())
              .collection('brands')
              .orderBy('publishedDate', descending: true)
              .snapshots(),
          // ignore: strict_raw_type
          builder: (context, AsyncSnapshot dataSnapshot) {
            if (dataSnapshot.hasData) //if brands exists
            {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final brandsModel = Brands.fromJson(
                    // ignore: avoid_dynamic_calls
                    dataSnapshot.data.docs[index].data() as Map<String, dynamic>,
                  );

                  return BrandsCard(
                    model: brandsModel,
                  );
                },
                // ignore: avoid_dynamic_calls
                itemCount: dataSnapshot.data.docs.length,
              );
            } else //if brands NOT exists
            {
              return const Center(
                child: Text(
                  'No brands exists',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
