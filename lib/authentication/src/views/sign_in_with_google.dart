import 'package:app_shoes_ec/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<GoogleAuthBloc>().add(GoogleSignInEvent()),
      child: Container(
        margin: EdgeInsets.all(20.h),
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: BlocBuilder<GoogleAuthBloc, GoogleAuthState>(
          builder: (context, state) {
            if (state is GoogleAuthPending) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/common/google1.png',
                    height: 40.h,
                  ),
                  SizedBox(
                    width: 20.h,
                  ),
                  const Text('Sign in with Google'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
