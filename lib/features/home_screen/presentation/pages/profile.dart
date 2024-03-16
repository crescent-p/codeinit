import 'package:codeinit/core/common/cubit/app_user_cubit.dart';
import 'package:codeinit/core/common/widgets/tile_card.dart';
import 'package:codeinit/core/utils/show_snackbar.dart';
import 'package:codeinit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:codeinit/features/auth/presentation/pages/signin.dart';
import 'package:codeinit/features/blog/domain/usecases/get_personal_blogs_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/profile.dart';

import '../../../blog/presentation/bloc/blog_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<BlogBloc>().add(GetAllBlogEvent());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    AuthSignOutEvent(),
                  );
              Navigator.pushAndRemoveUntil(
                context,
                SignIn.route(),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<AppUserCubit, AppUserState>(
                builder: (context, state) {
                  if (state is AppUserLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is AppUserLoggedIn) {
                    return Scrollbar(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Profile(
                                imageUrl:
                                    'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                website: 'https://www.example.com',
                                designation: 'Flutter Developer',
                                name: state.user.name,
                                email: state.user.email,
                                phone_number: state.user.id),
                          ),
                          const Text(
                            "Memories",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          BlocBuilder<BlogBloc, BlogState>(
                            builder: (context, state) {
                              if (state is BlogLoading) {
                                return const CircularProgressIndicator();
                              } else if (state is BlogLoadSuccess) {
                                return SingleChildScrollView(
                                  child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.blogs.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index > state.blogs.length - 1) {
                                          return const Text("No More Blogs");
                                        }
                                        return BlogCard(
                                            state: state, index: index);
                                      }),
                                );
                              } else if (state is BlogFailure) {
                                showSnackBar(context, state.message);
                                return Text(state.message);
                              } else {
                                return const Text("No Blog Found");
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text("No User Logged In");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
