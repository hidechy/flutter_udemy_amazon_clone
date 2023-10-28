import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fire_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_udemy_amazon_clone2/styles/styles.dart';

import '../components/progress_bar.dart';
import '../components/shared_prefs.dart';
import '../models/brands.dart';
import 'home_screen.dart';
import 'splash_screen.dart';

// ignore: must_be_immutable
class ItemsUploadScreen extends StatefulWidget {
  ItemsUploadScreen({
    super.key,
    this.model,
  });

  Brands? model;

  @override
  State<ItemsUploadScreen> createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {
  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();

  TextEditingController itemInfoTextEditingController = TextEditingController();
  TextEditingController itemTitleTextEditingController = TextEditingController();
  TextEditingController itemDescriptionTextEditingController = TextEditingController();
  TextEditingController itemPriceTextEditingController = TextEditingController();

  bool uploading = false;
  String downloadUrlImage = '';
  String itemUniqueId = DateTime.now().millisecondsSinceEpoch.toString();

  ///
  void saveBrandInfo() {
    FirebaseFirestore.instance
        .collection('sellers')
        .doc(sharedPreferences!.getString('uid'))
        .collection('brands')
        .doc(widget.model!.brandID)
        .collection('items')
        .doc(itemUniqueId)
        .set({
      'itemID': itemUniqueId,
      'brandID': widget.model!.brandID.toString(),
      'sellerUID': sharedPreferences!.getString('uid'),
      'sellerName': sharedPreferences!.getString('name'),
      'itemInfo': itemInfoTextEditingController.text.trim(),
      'itemTitle': itemTitleTextEditingController.text.trim(),
      'longDescription': itemInfoTextEditingController.text.trim(),
      'price': itemPriceTextEditingController.text.trim(),
      'publishedDate': DateTime.now(),
      'status': 'available',
      'thumbnailUrl': downloadUrlImage,
    }).then((value) {
      FirebaseFirestore.instance.collection('items').doc(itemUniqueId).set({
        'itemID': itemUniqueId,
        'brandID': widget.model!.brandID.toString(),
        'sellerUID': sharedPreferences!.getString('uid'),
        'sellerName': sharedPreferences!.getString('name'),
        'itemInfo': itemInfoTextEditingController.text.trim(),
        'itemTitle': itemTitleTextEditingController.text.trim(),
        'longDescription': itemInfoTextEditingController.text.trim(),
        'price': itemPriceTextEditingController.text.trim(),
        'publishedDate': DateTime.now(),
        'status': 'available',
        'thumbnailUrl': downloadUrlImage,
      });
    });

    setState(() {
      uploading = false;
    });

    Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
  }

  ///
  Future<void> validateUploadForm() async {
    if (imgXFile != null) {
      if (itemInfoTextEditingController.text.isNotEmpty &&
          itemTitleTextEditingController.text.isNotEmpty &&
          itemDescriptionTextEditingController.text.isNotEmpty &&
          itemPriceTextEditingController.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });

        //1. upload image to storage - get downloadUrl
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();

        final storageRef = fire_storage.FirebaseStorage.instance.ref().child('sellersItemsImages').child(fileName);

        final uploadImageTask = storageRef.putFile(File(imgXFile!.path));

        final taskSnapshot = await uploadImageTask.whenComplete(() {});

        await taskSnapshot.ref.getDownloadURL().then((urlImage) {
          downloadUrlImage = urlImage;
        });

        //2. save brand info to firestore database
        saveBrandInfo();
      } else {
        await Fluttertoast.showToast(msg: 'Please fill complete form.');
      }
    } else {
      await Fluttertoast.showToast(msg: 'Please choose image.');
    }
  }

  Scaffold uploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: IconButton(
              onPressed: () {
                //validate upload form
                // ignore: unnecessary_statements
                uploading == true ? null : validateUploadForm();
              },
              icon: const Icon(
                Icons.cloud_upload,
              ),
            ),
          ),
        ],
        flexibleSpace: Container(decoration: pinkBackGround),
        title: const Text('Upload New Item'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          uploading == true ? progressBar() : Container(),

          //image
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        File(
                          imgXFile!.path,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const Divider(
            color: Colors.pinkAccent,
            thickness: 1,
          ),

          //brand info
          ListTile(
            leading: const Icon(
              Icons.perm_device_information,
              color: Colors.deepPurple,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itemInfoTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'item info',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.pinkAccent,
            thickness: 1,
          ),

          //brand title
          ListTile(
            leading: const Icon(
              Icons.title,
              color: Colors.deepPurple,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itemTitleTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'item title',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.pinkAccent,
            thickness: 1,
          ),

          //item description
          ListTile(
            leading: const Icon(
              Icons.description,
              color: Colors.deepPurple,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itemDescriptionTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'item description',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.pinkAccent,
            thickness: 1,
          ),

          //item price
          ListTile(
            leading: const Icon(
              Icons.camera,
              color: Colors.deepPurple,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itemPriceTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'item price',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.pinkAccent,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return imgXFile == null ? defaultScreen() : uploadFormScreen();
  }

  Scaffold defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(decoration: pinkBackGround),
        title: const Text('Add New Item'),
        centerTitle: true,
      ),
      body: DecoratedBox(
        decoration: pinkBackGround,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_photo_alternate,
                color: Colors.white,
                size: 200,
              ),
              ElevatedButton(
                  onPressed: obtainImageDialogBox,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Add New Item',
                  )),
            ],
          ),
        ),
      ),
    );
  }

  ///
  dynamic obtainImageDialogBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              'Brand Image',
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              SimpleDialogOption(
                onPressed: captureImagewithPhoneCamera,
                child: const Text(
                  'Capture image with Camera',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: getImageFromGallery,
                child: const Text(
                  'Select image from Gallery',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {},
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        });
  }

  ///
  Future<void> getImageFromGallery() async {
    Navigator.pop(context);

    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      // ignore: unnecessary_statements
      imgXFile;
    });
  }

  ///
  Future<void> captureImagewithPhoneCamera() async {
    Navigator.pop(context);

    imgXFile = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      // ignore: unnecessary_statements
      imgXFile;
    });
  }
}
