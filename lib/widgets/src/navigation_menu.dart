import 'package:app_shoes_ec/data/data.dart';
import 'package:app_shoes_ec/models/models.dart';
import 'package:app_shoes_ec/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  List<Product> fancyProduct = [];

  @override
  void initState() {
    fancyProduct = data.where((product) => product.isFavorite).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.h),
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: NavigationBar(
              indicatorColor: Colors.transparent,
              animationDuration: const Duration(milliseconds: 1000),
              selectedIndex: controller.selectedIndex.value,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              backgroundColor: Colors.transparent,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: [
                NavigationDestination(
                  icon: SizedBox(
                      height: 25.h,
                      child: Image.asset(
                        'assets/icons/nav/shoes.png',
                        fit: BoxFit.contain,
                      )),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: SizedBox(
                      height: 25.h,
                      child: Image.asset(
                        'assets/icons/nav/loupe.png',
                        fit: BoxFit.contain,
                      )),
                  label: 'Search',
                ),
                NavigationDestination(
                  icon: SizedBox(
                      height: 25.h,
                      child: Image.asset(
                        'assets/icons/nav/heart.png',
                        fit: BoxFit.contain,
                      )),
                  label: 'Fancy',
                ),
                NavigationDestination(
                  icon: fancyProduct.isEmpty
                      ? SizedBox(
                          height: 42.h,
                          child: Image.asset(
                            'assets/icons/nav/bag.png',
                            fit: BoxFit.contain,
                          ),
                        )
                      : SizedBox(
                          height: 28.h,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                // child: Image.asset(
                                //   "assets/icons/common/lo3.png",
                                // ),
                                child: Image.asset(
                                  'assets/icons/nav/bag.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Center(
                                    child: Text(
                                  '${fancyProduct.length}',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.red,
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                  label: 'Cart',
                ),
                NavigationDestination(
                  icon: SizedBox(
                      height: 25.h,
                      child: Image.asset(
                        'assets/icons/nav/people.png',
                        fit: BoxFit.contain,
                      )),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = <Widget>[
    const Home(),
    const Search(),
    const Fancy(),
    const Cart(),
    const Profile(),
  ];
}
