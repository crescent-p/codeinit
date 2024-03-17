import 'package:codeinit/core/theme/colors.dart';
import 'package:codeinit/core/utils/date_format.dart';
import 'package:codeinit/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:codeinit/features/blog/presentation/pages/blog_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogCardForeign extends StatelessWidget {
  final BlogLoadPersonalSuccess state;
  final int index;
  const BlogCardForeign({super.key, required this.state, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogViewPage(
              blog: state.blogs[index],
              state: state,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 81, 197, 247),
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
                  children: [
                    Text(
                      state.blogs[index].posterName ?? ' ',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      dateFormatDDMMYYYY(state.blogs[index].createdAt),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
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
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 10),
            Text(
              state.blogs[index].content,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.start,
            ),
            Image(image: NetworkImage(state.blogs[index].imageUrl))
          ],
        ),
      ),
    );
  }
}
