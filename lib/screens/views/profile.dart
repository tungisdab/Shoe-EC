import 'package:app_shoes_ec/authentication/authentication.dart';
import 'package:app_shoes_ec/controllers/controllers.dart';
import 'package:app_shoes_ec/screens/screens.dart';
import 'package:app_shoes_ec/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final editProfileController = Get.put(EditProfileController());
  final String _selectedImage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.bgColor,
      body: SafeArea(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 50)),
            ImageField(image: _selectedImage),
            NameField(),
            emailField(),
            const SizedBox(height: 20),
            editProfileButton(context),
            // logOutButton(context),
            SizedBox(
              height: 50,
              width: 50,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (e) => const Settings(),
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
        ),
      )),
    );
  }
}

class ImageField extends StatelessWidget {
  ImageField({super.key, required this.image});
  final String image;
  final EditProfileController editImageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              // child: Image(
              //   image: NetworkImage(editImageController.imageUrl.value),
              //   fit: BoxFit.cover,
              // )
              child: Image.asset(
                'assets/icons/common/test.jpg',
                height: 50,
                fit: BoxFit.cover,
              ),
            )),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              _showBottomSheet(context);
            },
            child: Container(
              height: 36,
              width: 36,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Image.asset(
                "assets/icons/common/edit.png",
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    // final ImagePicker picker = ImagePicker();
                    // final XFile? imageUrl = await picker.pickImage(
                    //     source: ImageSource.gallery, imageQuality: 80);
                    // if (imageUrl != null) {
                    //   // log('${imageUrl.path}\n' + '${imageUrl.mimeType}');
                    //   // image = imageUrl.path;
                    //   // Get.put(EditProfileController()).updateImage(image);
                    //   Navigator.pop(context);
                    // }
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.photo_library_outlined,
                    size: 100,
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () async {
                    // final ImagePicker picker = ImagePicker();
                    // final XFile? imageUrl = await picker.pickImage(
                    //     source: ImageSource.camera, imageQuality: 80);
                    // if (imageUrl != null) {
                    //   // log('${imageUrl.path}\n' + '${imageUrl.mimeType}');
                    //   // image = imageUrl.path;
                    //   Get.put(EditProfileController()).updateImage(image);
                    // }
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 100,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

// Widget nameField() => Obx(() => Text(
//         // APIs.me.name,
//         EditProfileController().name.value,
//         style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//       ));

class NameField extends StatelessWidget {
  NameField({super.key});

  final EditProfileController editProfileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return ThemeColor()
            .gradient
            .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: const Text(
        // editProfileController.name.value,
        "MA",
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

Widget emailField() => ShaderMask(
    shaderCallback: (Rect bounds) {
      return ThemeColor()
          .gradient
          .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
    },
    // child: Text(APIs.me.email,
    //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white)),
    child: const Text("Trời sẽ nắng vào ngày em yên lòng.",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white)));

Widget editProfileButton(BuildContext context) => ElevatedButton(
    onPressed: () {
      // showEditProfileDialog(context);
    },
    style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 40),
        // backgroundColor: AppColor.listColor,
        // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    child: const Text(
      "Edit Profile",
      style: TextStyle(color: Colors.black),
    ));

// Widget logOutButton(BuildContext context) => ElevatedButton(
//     // onPressed: () async {}
//     onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (e) => const Wellcome(),
//           ),
//         ),
//     style: ElevatedButton.styleFrom(
//         minimumSize: const Size(120, 40),
//         backgroundColor: Colors.red.shade300,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
//     child: const Text(
//       "Log out",
//       style: TextStyle(color: Colors.white),
//     ));
