
import 'package:cubit_example/business_logic/selectedpost_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectPostCubit extends Cubit<SelectedPostState> {
  SelectPostCubit(super.initialState);

  List<int> selectedPostIds = [];

  void selectPost(int postId) {
    selectedPostIds.add(postId);
    emit(SelectedPostState(Colors.lightBlue));
  }

  void unSelectPost(int postId) {
    selectedPostIds.removeWhere((element) => element == postId);
    emit(SelectedPostState(Colors.white));
  }
}
