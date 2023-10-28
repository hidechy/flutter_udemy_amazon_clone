// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:test_udemy_amazon_clone2/screens/items_upload_screen.dart';
import 'package:test_udemy_amazon_clone2/styles/styles.dart';
import '../components/text_delegate_header.dart';
import '../models/brands.dart';

// ignore: must_be_immutable
class ItemsScreen extends StatefulWidget {
  ItemsScreen({
    super.key,
    this.model,
  });

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
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextDelegateHeader(title: 'My ' + widget.model!.brandTitle.toString() + "'s Items"),
          ),
        ],
      ),
    );
  }
}
