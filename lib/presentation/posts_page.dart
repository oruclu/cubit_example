import 'package:cubit_example/business_logic/posts_cubit.dart';
import 'package:cubit_example/business_logic/posts_state.dart';
import 'package:cubit_example/business_logic/selectedpost_cubit.dart';
import 'package:cubit_example/business_logic/selectedpost_state.dart';
import 'package:cubit_example/model/post_model.dart';
import 'package:cubit_example/repository/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: RefreshIndicator(
        onRefresh: () => fetchData(),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            return switch (state) {
              PostInitialState() => const SizedBox(),
              PostLoadingState() => const Center(
                  child: CircularProgressIndicator(),
                ),
              PostLoadedState() => const Center(
                  child: PostsList(),
                ),
              PostErrorState() => const Center(
                  child: CircularProgressIndicator(),
                ),
              PostState() => const SizedBox(),
            };
          },
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    await context.read<PostCubit>().fetchPosts();
  }
}

class PostsList extends StatelessWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      final posts = (state as PostLoadedState).posts;
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostCard(post: post);
        },
      );
    });
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectPostCubit, SelectedPostState>(
      builder: (context, state) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: cardColor(context),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onLongPress: () {
                context.read<SelectPostCubit>().selectPost(post.id);
              },
              onTap: () {
                context.read<SelectPostCubit>().unSelectPost(post.id);
              },
              radius: 600,
              splashFactory: InkRipple.splashFactory,
              borderRadius: BorderRadius.circular(12),
              child: ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
              ),
            ),
          ),
        );
      }
    );
  }

  Color cardColor(BuildContext context) {
    return context.read<SelectPostCubit>().selectedPostIds.any(
              (element) => element == post.id,
            )
        ? Colors.lightBlue
        : Colors.white;
  }
}
