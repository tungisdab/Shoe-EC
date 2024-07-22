import 'package:app_shoes_ec/screens/screens.dart';
import 'package:app_shoes_ec/widgets/src/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';


class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> screens = const [
    Home(),
    Search(),
    Fancy(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    // final l10n = AppLocalizations.of(context)!; // Move this to build method

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _menu(context),
      body: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return PageView(
            controller: _pageController,
            onPageChanged: (index) {
              context.read<BottomNavCubit>().selectTab(index);
            },
            physics: const NeverScrollableScrollPhysics(),
            children: screens,
          );
        },
      ),
    );
  }

  Widget _menu(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 4.h),
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
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: context.watch<BottomNavCubit>().state,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
         destinations: [
          NavigationDestination(
            icon: Icon(
              context.watch<BottomNavCubit>().state == 0
                  ? IconlyBold.home
                  : IconlyBroken.home,
              size: 25.h,
              color: Colors.red.shade400,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              context.watch<BottomNavCubit>().state == 1
                  ? IconlyBold.search
                  : IconlyBroken.search,
              size: 25.h,
              color: Colors.red.shade400,
            ),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(
              context.watch<BottomNavCubit>().state == 2
                  ? IconlyBold.heart
                  : IconlyBroken.heart,
              size: 25.h,
              color: Colors.red.shade400,
            ),
            label: 'Fancy',
          ),
         
          NavigationDestination(
            icon: Icon(
              context.watch<BottomNavCubit>().state == 3
                  ? IconlyBold.profile
                  : IconlyBroken.profile,
              size: 25.h,
              color: Colors.red.shade400,
            ),
            label: 'Profile',
          ),
        ],
        onDestinationSelected: (index) {
          context.read<BottomNavCubit>().selectTab(index);
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}