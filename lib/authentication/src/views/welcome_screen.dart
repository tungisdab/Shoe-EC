import 'dart:ui';

import 'package:app_shoes_ec/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(20, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Theme.of(context).colorScheme.tertiary
                      color: Colors.white
                      
                      ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-2.7, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width / 1.3,
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                      // color: Theme.of(context).colorScheme.secondary
                      
                      ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(2.7, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width / 1.3,
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Theme.of(context).colorScheme.primary
                      color: Colors.white

                      ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.asset('assets/images/background/bg.png'),
                  ),
                  BlocProvider<GoogleAuthBloc>(
                          create: (context) => GoogleAuthBloc(
                              userRepository: context
                                  .read<AuthenticationBloc>()
                                  .userRepository),
                          child: const SignInWithGoogle(),
                        ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: TabBar(
                      controller: tabController,
                      unselectedLabelColor: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.5),
                      labelColor: Theme.of(context).colorScheme.onBackground,
                      tabs: const [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        BlocProvider<SignInBloc>(
                          create: (context) => SignInBloc(
                              userRepository: context
                                  .read<AuthenticationBloc>()
                                  .userRepository),
                          child: const SignInScreen(),
                        ),
                        BlocProvider<SignUpBloc>(
                          create: (context) => SignUpBloc(
                              userRepository: context
                                  .read<AuthenticationBloc>()
                                  .userRepository),
                          child: const SignUpScreen(),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
