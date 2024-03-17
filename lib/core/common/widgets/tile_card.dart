import 'package:codeinit/core/theme/colors.dart';
import 'package:codeinit/core/utils/date_format.dart';
import 'package:codeinit/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:codeinit/features/blog/presentation/pages/blog_view_page.dart';
import 'package:codeinit/features/home_screen/presentation/pages/local_profile.dart';
import 'package:codeinit/features/home_screen/presentation/pages/profile.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final BlogLoadSuccess state;
  final int index;
  const BlogCard({super.key, required this.state, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocalProfile(
              state: state,
              index: index,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 92, 9, 180),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppPallete.gradient1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.blogs[index].posterName ?? ' ',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      dateFormatDDMMYYYY(state.blogs[index].createdAt),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              state.blogs[index].title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              state.blogs[index].content,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            Image(image: NetworkImage(state.blogs[index].imageUrl))
          ],
        ),
      ),
    );
  }
}
