import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_udemy_amazon_clone2/styles/styles.dart';

import '../components/brands_card.dart';
import '../components/drawer.dart';
import '../components/shared_prefs.dart';
import '../models/brands.dart';
import 'brands_upload_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
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
              Navigator.push(context, MaterialPageRoute(builder: (c) => const BrandsUploadScreen()));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('sellers')
            .doc(sharedPreferences!.getString('uid'))
            .collection('brands')
            .orderBy('publishedDate', descending: true)
            .snapshots(),
        // ignore: strict_raw_type
        builder: (context, AsyncSnapshot dataSnapshot) {
          if (dataSnapshot.hasData) //if brands exists
          {
            // //display brands
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final brandsModel = Brands.fromJson(
                  // ignore: avoid_dynamic_calls
                  dataSnapshot.data.docs[index].data() as Map<String, dynamic>,
                );

                return BrandsCard(
                  model: brandsModel,
                  context: context,
                );
              },
              // ignore: avoid_dynamic_calls
              itemCount: dataSnapshot.data.docs.length,
            );
          } else //if brands NOT exists
          {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'No brands exists',
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
