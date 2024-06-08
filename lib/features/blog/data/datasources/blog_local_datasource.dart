import 'package:hive/hive.dart';
import 'package:semaphore/features/blog/data/models/blog_model.dart';

abstract interface class BlogLocalDatasource {
  void saveLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadLocalBlogs();
}

class BlogLocalDatasourceImpl implements BlogLocalDatasource {
  final Box box;

  BlogLocalDatasourceImpl(this.box);

  @override
  List<BlogModel> loadLocalBlogs() {
    List<BlogModel> blogs = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        final blogObject = box.get(i.toString());
        blogs.add(
          BlogModel.fromJson(blogObject).copyWith(
            userName: blogObject['user_name'],
          ),
        );
      }
    });
    return blogs;
  }

  @override
  void saveLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();
    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        final blogObject = blogs[i].toJson();
        blogObject['user_name'] = blogs[i].userName;
        box.put(i.toString(), blogObject);
      }
    });
  }
}
