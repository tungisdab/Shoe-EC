import 'package:app_shoes_ec/data/data.dart';
import 'package:app_shoes_ec/models/models.dart';
import 'package:app_shoes_ec/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class RecipeDetailAppBar extends StatefulWidget {
  const RecipeDetailAppBar({super.key});

  @override
  State<RecipeDetailAppBar> createState() => _RecipeDetailAppBarState();
}

class _RecipeDetailAppBarState extends State<RecipeDetailAppBar> {
  List<Product> fancyProduct = [];

  @override
  void initState() {
    fancyProduct = data.where((product) => product.isFavorite).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      expandedHeight: 275.0.h,
      backgroundColor: Colors.white,
      foregroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0.0,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 50.h, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(3, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/bg3.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground,
        ],
      ),
      leading: Icon(
        IconlyBroken.category,
        size: 25.h,
        color: Colors.red,
      ),
      actions: [
        IconButton(
          icon: Icon(
            IconlyBroken.buy,
            size: 25.h,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (e) => const Cart()),
            );
          },
        ),
        IconButton(
          icon: Icon(
            IconlyBroken.notification,
            size: 25.h,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (e) => const Home1()),
            );
          },
        ),
      ],
      floating: true,
      snap: true,
      title: Container(
        width: double.infinity,
        height: 35.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconlyBroken.edit,
              size: 20.h,
              color: Colors.red,
            ),
            SizedBox(width: 8.w),
            Text(
              'Shoes Story',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
    );
  }
}