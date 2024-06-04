import 'package:cubit_example/model/post_model.dart';
import 'package:cubit_example/repository/post_repo.dart';

class PostInitialState extends PostState {
  @override
  List<Object?> get props => [];
}

class PostLoadingState extends PostState {
  @override
  List<Object?> get props => [];
}

class PostLoadedState extends PostState {

  PostLoadedState(this.posts);

  final List<PostModel> posts;

  @override
  List<Object?> get props => [posts];
}

class PostErrorState extends PostState {
  @override
  List<Object?> get props => [];
}

