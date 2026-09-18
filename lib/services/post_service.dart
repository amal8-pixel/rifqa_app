import 'package:dio/dio.dart';
import '../models/post_model.dart';

class PostService {
  final Dio dio = Dio();
  Future<List<PostModel>> getPosts() async {
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/posts',
    );
    final List data = response.data;

    return data.map((json) => PostModel.fromJson(json)).toList();
  }
}
