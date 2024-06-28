import 'package:cubit_example/helper/enums.dart';
import 'package:cubit_example/model/post_model.dart';
import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  const PostState(
      {required this.posts,
      required this.pageState,
      required this.selectedPostIds});

  final PageState pageState;
  final List<PostModel> posts;
  final List<int> selectedPostIds;

  PostState copyWith({
    final PageState? pageState,
    final List<PostModel>? posts,
    List<int>? selectedPostIds,
  }) {
    return PostState(
        posts: posts ?? this.posts,
        pageState: pageState ?? this.pageState,
        selectedPostIds: selectedPostIds ?? this.selectedPostIds);
  }

  @override
  List<Object?> get props => [posts, pageState, selectedPostIds];
}
