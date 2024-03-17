import 'package:codeinit/core/common/widgets/loader.dart';
import 'package:codeinit/core/theme/colors.dart';
import 'package:codeinit/core/utils/show_snackbar.dart';
import 'package:codeinit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:codeinit/features/auth/presentation/pages/signup.dart';
import 'package:codeinit/features/auth/presentation/widgets/auth_field.dart';
import 'package:codeinit/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:codeinit/features/home_screen/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  static route() => MaterialPageRoute(builder: (context) => const SignIn());

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(AuthCurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 100, 12, 50),
        child: BlocConsumer<AuthBloc, AuthStateMine>(
          listener: (context, state) {
            if (state is AuthFailure) {
              return showSnackBar(context, state.message);
            }
            if (state is AuthSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                HomeScreen.route(),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const LoadingIndicator();
            }
            return BlocConsumer<AuthBloc, AuthStateMine>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  return showSnackBar(
                    context,
                    state.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const LoadingIndicator();
                }
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 100, 12, 50),
                        child: Center(
                          child: Text("Sign in.",
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold)),
                        ),
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
                      AuthSignUpButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context)
                                .add(AuthSignInEvent(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ));
                          }
                        },
                        buttonText: "Sign in",
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, SignUp.route());
                        },
                        child: RichText(
                            text: const TextSpan(
                                text: "Already have an account? ",
                                children: [
                              TextSpan(
                                  text: "Sign Up.",
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
            );
          },
        ),
      ),
    ));
  }
}
