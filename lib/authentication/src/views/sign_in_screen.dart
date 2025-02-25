import 'package:app_shoes_ec/authentication/src/sign_in_bloc/sign_in_bloc.dart';
import 'package:app_shoes_ec/screens/screens.dart';
import 'package:app_shoes_ec/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
	final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
	bool signInRequired = false;
	IconData iconPassword = IconlyBroken.show;
	bool obscurePassword = true;
	String? _errorMsg;
	
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
			listener: (context, state) {
				if(state is SignInSuccess) {
					setState(() {
					  signInRequired = false;
					});
				} else if(state is SignInProcess) {
					setState(() {
					  signInRequired = true;
					});
				} else if(state is SignInFailure) {
					setState(() {
					  signInRequired = false;
						_errorMsg = 'Invalid email or password';
					});
				}
			},
			child: Form(
					key: _formKey,
					child: Column(
						children: [
							const SizedBox(height: 20),
							SizedBox(
								width: MediaQuery.of(context).size.width * 0.9,
								child: MyTextField(
									controller: emailController,
									hintText: 'Email',
									obscureText: false,
									keyboardType: TextInputType.emailAddress,
									prefixIcon: const Icon(IconlyBroken.message),
									errorMsg: _errorMsg,
									validator: (val) {
										if (val!.isEmpty) {
											return 'Please fill in this field';
										} else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
											return 'Please enter a valid email';
										}
										return null;
									}
								)
							),
							const SizedBox(height: 10),
							SizedBox(
								width: MediaQuery.of(context).size.width * 0.9,
								child: MyTextField(
									controller: passwordController,
									hintText: 'Password',
									obscureText: obscurePassword,
									keyboardType: TextInputType.visiblePassword,
									prefixIcon: const Icon(IconlyBroken.password),
									errorMsg: _errorMsg,
									validator: (val) {
										if (val!.isEmpty) {
											return 'Please fill in this field';
										} else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
											return 'Please enter a valid password';
										}
										return null;
									},
									suffixIcon: IconButton(
										onPressed: () {
											setState(() {
												obscurePassword = !obscurePassword;
												if(obscurePassword) {
													iconPassword = IconlyBroken.show;
												} else {
													iconPassword = IconlyBold.show;
												}
											});
										},
										icon: Icon(iconPassword),
									),
								),
							),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, 
                    MaterialPageRoute(
                        builder: (e) => const ForgotPassword(),
                      ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot password?', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                ),
              ),
							const SizedBox(height: 20),
							!signInRequired
								? SizedBox(
										width: MediaQuery.of(context).size.width * 0.5,
										child: TextButton(
											onPressed: () {
												if (_formKey.currentState!.validate()) {
													context.read<SignInBloc>().add(SignInRequired(
														emailController.text,
														passwordController.text)
													);
												}
											},
											style: TextButton.styleFrom(
												elevation: 3.0,
												backgroundColor: Theme.of(context).colorScheme.primary,
												foregroundColor: Colors.white,
												shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(60)
												)
											),
											child: const Padding(
												padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
												child: Text(
													'Sign In',
													textAlign: TextAlign.center,
													style: TextStyle(
														color: Colors.white,
														fontSize: 16,
														fontWeight: FontWeight.w600
													),
												),
											)
										),
									)
							: const CircularProgressIndicator(),
              
						],
					)
				),
		);
  }
}