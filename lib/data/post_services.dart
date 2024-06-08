import 'package:cubit_example/helper/dio_config.dart';
import 'package:cubit_example/model/post_model.dart';
import 'package:dio/dio.dart';

class PostServices {
  PostServices._internal();

  //--  Make a singleton
  static final PostServices _instance = PostServices._internal();
  static PostServices get instance => _instance;

  Future<List<PostModel>> fetchPosts() async {
    Response response = await refDio.get('/posts');

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 299) {
      return (response.data as List)
          .map(
            (e) => PostModel.fromMap(e),
          )
          .toList();
    } else {
      return Future.error(response);
    }
  }
}
