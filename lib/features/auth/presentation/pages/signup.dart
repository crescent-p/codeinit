import 'dart:io';

import 'package:codeinit/core/common/widgets/loader.dart';
import 'package:codeinit/core/theme/colors.dart';
import 'package:codeinit/core/utils/image_picker.dart';
import 'package:codeinit/core/utils/show_snackbar.dart';
import 'package:codeinit/features/auth/data/models/user_model.dart';
import 'package:codeinit/features/blog/presentation/pages/blog_page.dart';
import 'package:codeinit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:codeinit/features/auth/presentation/pages/signin.dart';
import 'package:codeinit/features/auth/presentation/widgets/auth_field.dart';
import 'package:codeinit/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:codeinit/features/home_screen/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static route() => MaterialPageRoute(builder: (context) => const SignUp());

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final designationController = TextEditingController();
  final websiteController = TextEditingController();
  final phoneController = TextEditingController();
  File? image;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              return showSnackBar(context, "Error: ${state.message}");
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const LoadingIndicator();
            } else if (state is AuthSuccess) {
              Navigator.push(context, HomeScreen.route());
            }
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(12, 100, 12, 50),
                    child: Center(
                      child: Text("Sign Up.",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  AuthField(
                    hintText: "Name",
                    obscureText: false,
                    controller: nameController,
                  ),
                  const SizedBox(height: 20),
                  AuthField(
                    hintText: "E-mail",
                    controller: emailController,
                  ),
                  const SizedBox(height: 20),
                  AuthField(
                    hintText: "Password",
                    obscureText: true,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  AuthField(
                    hintText: "Designation",
                    controller: designationController,
                  ),
                  const SizedBox(height: 20),
                  AuthField(
                    hintText: "website",
                    controller: websiteController,
                  ),
                  const SizedBox(height: 20),
                  AuthField(
                    hintText: "Phone Number",
                    controller: phoneController,
                  ),
                  IconButton(
                      onPressed: () async {
                        image = await pickImage();
                        if (image != null) {
                          showSnackBar(context, 'Image selected.');
                        } else {
                          showSnackBar(context, 'Image not selected.');
                        }
                      },
                      icon: const Icon(Icons.add_a_photo)),
                  const SizedBox(height: 20),
                  AuthSignUpButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthSignUpEvent(
                            user: UserModel(
                              name: nameController.text,
                              designation: designationController.text,
                              website: websiteController.text,
                              phone_number: phoneController.text,
                              image_url: image?.path ?? "",
                              id: "",
                              email: emailController.text,
                            ),
                            email: emailController.text,
                            password: passwordController.text));
                      },
                      buttonText: "Sign Up."),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, SignIn.route());
                    },
                    child: RichText(
                        text: const TextSpan(
                            text: "Don't have an account? ",
                            children: [
                          TextSpan(
                              text: "Sign In.",
                              style: TextStyle(
                                  color: AppPallete.errorColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17))
                        ])),
                  )
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
