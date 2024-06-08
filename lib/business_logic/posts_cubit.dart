import 'package:cubit_example/business_logic/posts_state.dart';
import 'package:cubit_example/data/post_services.dart';
import 'package:cubit_example/model/post_model.dart';
import 'package:cubit_example/repository/post_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(super.initialState);

  final _services = PostServices.instance;

  List<PostModel> posts = [];

  Future<void> fetchPosts() async {
    try {
      emit(PostLoadingState());
      final posts = await _services.fetchPosts();
      debugPrint('posts len : ${posts.length}');
      emit(PostLoadedState(posts));
    } catch (e) {
      debugPrint('err: $e');
      emit(PostErrorState());
    }
  }

}
