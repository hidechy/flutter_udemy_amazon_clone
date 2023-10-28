import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fire_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../components/progress_bar.dart';
import '../components/shared_prefs.dart';
import '../styles/styles.dart';
import 'home_screen.dart';
import 'splash_screen.dart';

class BrandsUploadScreen extends StatefulWidget {
  const BrandsUploadScreen({super.key});

  @override
  State<BrandsUploadScreen> createState() => _BrandsUploadScreenState();
}

class _BrandsUploadScreenState extends State<BrandsUploadScreen> {
  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();

  TextEditingController brandInfoTextEditingController = TextEditingController();
  TextEditingController brandTitleTextEditingController = TextEditingController();

  bool uploading = false;
  String downloadUrlImage = '';
  String brandUniqueId = DateTime.now().millisecondsSinceEpoch.toString();

  ///
  void saveBrandInfo() {
    FirebaseFirestore.instance
        .collection('sellers')
        .doc(sharedPreferences!.getString('uid'))
        .collection('brands')
        .doc(brandUniqueId)
        .set({
      'brandID': brandUniqueId,
      'sellerUID': sharedPreferences!.getString('uid'),
      'brandInfo': brandInfoTextEditingController.text.trim(),
      'brandTitle': brandTitleTextEditingController.text.trim(),
      'publishedDate': DateTime.now(),
      'status': 'available',
      'thumbnailUrl': downloadUrlImage,
    });

    setState(() {
      uploading = false;
      brandUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    });

    Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
  }

  ///
  Future<void> validateUploadForm() async {
    if (imgXFile != null) {
      if (brandInfoTextEditingController.text.isNotEmpty && brandTitleTextEditingController.text.isNotEmpty) {
        setState(() => uploading = true);

        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final storageRef = fire_storage.FirebaseStorage.instance.ref().child('sellersBrandsImages').child(fileName);
        final uploadImageTask = storageRef.putFile(File(imgXFile!.path));
        final taskSnapshot = await uploadImageTask.whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((urlImage) => downloadUrlImage = urlImage);

        saveBrandInfo();
      } else {
        await Fluttertoast.showToast(msg: 'Please write brand info and brand title.');
      }
    } else {
      await Fluttertoast.showToast(msg: 'Please choose image.');
    }
  }

  ///
  Widget uploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen())),
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
              icon: const Icon(Icons.cloud_upload),
            ),
          ),
        ],
        flexibleSpace: Container(decoration: pinkBackGround),
        title: const Text('Upload New Brand'),
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
                  decoration: BoxDecoration(image: DecorationImage(image: FileImage(File(imgXFile!.path)))),
                ),
              ),
            ),
          ),

          const Divider(color: Colors.pinkAccent, thickness: 1),

          //brand info
          ListTile(
            leading: const Icon(Icons.perm_device_information, color: Colors.deepPurple),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: brandInfoTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'brand info',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(color: Colors.pinkAccent, thickness: 1),

          //brand title
          ListTile(
            leading: const Icon(Icons.title, color: Colors.deepPurple),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: brandTitleTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'brand title',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(color: Colors.pinkAccent, thickness: 1),
        ],
      ),
    );
  }

  ///
  @override
  Widget build(BuildContext context) => imgXFile == null ? defaultScreen() : uploadFormScreen();

  ///
  Widget defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(decoration: pinkBackGround),
        title: const Text('Add New Brand'),
        centerTitle: true,
      ),
      body: DecoratedBox(
        decoration: pinkBackGround,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_photo_alternate_outlined, color: Colors.white, size: 200),
              ElevatedButton(
                onPressed: obtainImageDialogBox,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Add New Brand'),
              ),
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
            style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
          ),
          children: [
            SimpleDialogOption(
              onPressed: captureImagewithPhoneCamera,
              child: const Text(
                'Capture image with Camera',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SimpleDialogOption(
              onPressed: getImageFromGallery,
              child: const Text(
                'Select image from Gallery',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {},
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  ///
  Future<void> getImageFromGallery() async {
    Navigator.pop(context);

    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() => imgXFile);
  }

  ///
  Future<void> captureImagewithPhoneCamera() async {
    Navigator.pop(context);

    imgXFile = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() => imgXFile);
  }
}
