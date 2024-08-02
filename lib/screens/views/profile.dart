import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_shoes_ec/authentication/authentication.dart';
import 'package:app_shoes_ec/styles/style.dart';
import 'package:app_shoes_ec/screens/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  Uint8List? _image;

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);

      log('Image path: ${imageFile.path}');
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('image_profile/${FirebaseAuth.instance.currentUser!.uid}.jpg');
      final uploadTask = storageRef.putFile(imageFile);

      // Get download URL
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore with the new image URL
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'imageUrl': downloadUrl});
    }
  }

  Future<void> editField(String field) async {
    String newValue = '';
    final result = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Edit $field"),
              content: TextField(
                autofocus: true,
                onChanged: (value) {
                  newValue = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter new $field",
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(newValue),
                    child: const Text('Save'))
              ],
            ));

    if (result != null && result.trim().isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({field: result});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColor.bgColor,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseAuth.instance.currentUser != null
                      ? FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots()
                      : null,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 50)),
                            imageField(userData['imageUrl']?.toString() ?? ''),
                            field('Name'),
                            const SizedBox(height: 20),
                            nameField(userData['name']),
                            const SizedBox(height: 20),
                            field('Phone'),
                            const SizedBox(height: 20),
                            phoneField(userData['phone']),
                            const SizedBox(height: 20),
                            field('Address'),
                            const SizedBox(height: 20),
                            addressField(userData['address']),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget field(String field) => Text(
        field,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget imageField(String imageUrl) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 2),
                ),
                child: imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(imageUrl, fit: BoxFit.fitHeight),
                      )
                    : const Icon(
                        IconlyBroken.profile,
                        size: 100,
                        color: Colors.red,
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    selectImage();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      IconlyBroken.camera,
                      color: Colors.red,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (e) => const SettingsApp(),
                      ),
                    );
                  },
                  child: const Icon(
                    IconlyBroken.setting,
                    color: Colors.red,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<SignInBloc>().add(const SignOutRequired());
                },
                icon: const Icon(IconlyBroken.logout),
              )
            ],
          )
        ],
      );

  Widget nameField(String name) => Container(
        height: 70.h,
        width: double.infinity,
        margin: EdgeInsets.only(left: 20.h, right: 20.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(20.h),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20.h), // Khoảng cách từ bên trái
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return ThemeColor().gradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                    },
                    child: Text(
                      name,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.h),
                child: GestureDetector(
                    onTap: () => editField('name'),
                    child: const Icon(IconlyBroken.edit, color: Colors.red)),
              ),
            ],
          ),
        ),
      );

  Widget phoneField(String phone) => Container(
        height: 70.h,
        width: double.infinity,
        margin: EdgeInsets.only(left: 20.h, right: 20.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(20.h),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20.h), // Khoảng cách từ bên trái
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return ThemeColor().gradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                    },
                    child: Text(
                      phone,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.h),
                child: GestureDetector(
                    onTap: () => editField('phone'),
                    child: const Icon(IconlyBroken.edit, color: Colors.red)),
              ),
            ],
          ),
        ),
      );

  Widget addressField(String address) => Container(
        height: 70.h,
        width: double.infinity,
        margin: EdgeInsets.only(left: 20.h, right: 20.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(20.h),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20.h), // Khoảng cách từ bên trái
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return ThemeColor().gradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                    },
                    child: Text(
                      address,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.h),
                child: GestureDetector(
                    onTap: () => editField('address'),
                    child: const Icon(IconlyBroken.edit, color: Colors.red)),
              ),
            ],
          ),
        ),
      );
}
