import 'package:codeinit/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void updateAllBlogs(List<BlogModel> blogs);
  List<BlogModel> getAllBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceImpl({required this.box});

  @override
  List<BlogModel> getAllBlogs() {
    List<BlogModel> blogs = [];
    for (int i = 0; i < box.length; i++) {
      blogs.add(
        BlogModel.fromJson(
          box.get(
            i.toString(),
          ),
        ),
      );
    }
    return blogs;
  }

  @override
  void updateAllBlogs(List<BlogModel> blogs) {
    try {
      box.clear();
      for (int i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i].toJson());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
