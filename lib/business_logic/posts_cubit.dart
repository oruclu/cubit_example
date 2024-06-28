import 'package:cubit_example/business_logic/posts_state.dart';
import 'package:cubit_example/data/post_services.dart';
import 'package:cubit_example/helper/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit()
      : super(const PostState(
            posts: [], pageState: PageState.idle, selectedPostIds: []));

  final _services = PostServices.instance;

  Future<void> fetchPosts() async {
    try {
      emit(state.copyWith(pageState: PageState.loading));

      final posts = await _services.fetchPosts();

      emit(state.copyWith(posts: posts, pageState: PageState.completed));
    } catch (e) {
      emit(state.copyWith(pageState: PageState.error));
    }
  }

  void selectPost(int postId) {
    List<int> selectedPostIDs = [];
    selectedPostIDs.addAll(state.selectedPostIds);
    selectedPostIDs.add(postId);
    emit(state.copyWith(selectedPostIds: selectedPostIDs));
  }

  void unSelectPost(int postId) {
    List<int> selectedPostIDs = [];
    selectedPostIDs.addAll(state.selectedPostIds);
    selectedPostIDs.removeWhere((element) => element == postId);
    emit(state.copyWith(selectedPostIds: selectedPostIDs));
  }
}
