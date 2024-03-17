import 'package:codeinit/features/blog/domain/entities/blog.dart';
import 'package:codeinit/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';

class BlogViewPage extends StatelessWidget {
  final BlogLoadPersonalSuccess state;
  static route(Blog blog, BlogLoadPersonalSuccess state) {
    return MaterialPageRoute(builder: (context) => BlogViewPage(blog: blog, state: state,));
  }

  final Blog blog;
  const BlogViewPage({super.key, required this.blog, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.blogs[index].posterName ?? ' ',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      state.blogs[index].createdAt.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      state.blogs[index].content ?? ' ',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
