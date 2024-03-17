import 'package:codeinit/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

class LocalProfile extends StatelessWidget {
  final BlogLoadSuccess state;
  final int index;
  const LocalProfile({super.key, required this.state, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: Profile(
            name: state.blogs[index].posterName ?? ' ',
            designation: state.blogs[index].title,
            imageUrl: state.blogs[index].imageUrl,
            website: state.blogs[index].imageUrl,
            email: 'Email Hidden',
            phone_number: state.blogs[index].year ?? ' ',
          ),
        ));
  }
}
