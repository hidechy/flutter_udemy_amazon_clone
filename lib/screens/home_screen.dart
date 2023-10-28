//import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/drawer.dart';
import '../components/sellers_card.dart';

//import '../data/data.dart';
import '../models/sellers.dart';
import '../styles/styles.dart';
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
      // body: CustomScrollView(
      //   slivers: [
      //     //image slider
      //     SliverToBoxAdapter(
      //       child: Padding(
      //         padding: const EdgeInsets.all(6.0),
      //         child: SizedBox(
      //           height: MediaQuery.of(context).size.height * .3,
      //           width: MediaQuery.of(context).size.width,
      //           child: CarouselSlider(
      //             options: CarouselOptions(
      //               height: MediaQuery.of(context).size.height * .9,
      //               aspectRatio: 16 / 9,
      //               viewportFraction: 0.8,
      //               initialPage: 0,
      //               enableInfiniteScroll: true,
      //               reverse: false,
      //               autoPlay: true,
      //               autoPlayInterval: const Duration(seconds: 2),
      //               autoPlayAnimationDuration: const Duration(milliseconds: 800),
      //               autoPlayCurve: Curves.fastOutSlowIn,
      //               enlargeCenterPage: true,
      //               scrollDirection: Axis.horizontal,
      //             ),
      //             items: itemsImagesList.map((index) {
      //               return Builder(builder: (BuildContext c) {
      //                 return Container(
      //                   width: MediaQuery.of(context).size.width,
      //                   margin: const EdgeInsets.symmetric(horizontal: 1.0),
      //                   child: ClipRRect(
      //                     borderRadius: BorderRadius.circular(40),
      //                     child: Image.asset(
      //                       index,
      //                       fit: BoxFit.fill,
      //                     ),
      //                   ),
      //                 );
      //               });
      //             }).toList(),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('sellers').snapshots(),
        // ignore: strict_raw_type
        builder: (context, AsyncSnapshot dataSnapshot) {
          if (dataSnapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                // ignore: avoid_dynamic_calls
                final model = Sellers.fromJson(dataSnapshot.data.docs[index].data() as Map<String, dynamic>);

                return SellersCard(
                  model: model,
                );
              },
              // ignore: avoid_dynamic_calls
              itemCount: dataSnapshot.data.docs.length,
            );
          } else {
            return const Center(
              child: Text(
                'No Sellers Data exists.',
              ),
            );
          }
        },
      ),
    );
  }
}
