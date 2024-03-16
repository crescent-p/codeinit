import 'package:codeinit/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewPage extends StatelessWidget {
  static route(Blog blog) {
    return MaterialPageRoute(builder: (context) => BlogViewPage(blog: blog));
  }

  final Blog blog;
  const BlogViewPage({super.key, required this.blog});

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
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(blog.imageUrl)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(blog.content),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
