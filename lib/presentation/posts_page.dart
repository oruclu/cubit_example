import 'package:cubit_example/business_logic/posts_cubit.dart';
import 'package:cubit_example/business_logic/posts_state.dart';
import 'package:cubit_example/helper/enums.dart';
import 'package:cubit_example/model/post_model.dart';
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
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: RefreshIndicator(
        onRefresh: () => fetchPosts(),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            return switch (state.pageState) {
              PageState.idle => const SizedBox(),
              PageState.loading => const Center(
                  child: CircularProgressIndicator(),
                ),
              PageState.completed => const Center(
                  child: PostsList(),
                ),
              PageState.error => const Center(
                  child: Text('ERROR'),
                ),
            };
          },
        ),
      ),
    );
  }

  Future<void> fetchPosts() async {
    await context.read<PostCubit>().fetchPosts();
  }
}

class PostsList extends StatelessWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      final posts = state.posts;
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
    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      return Card(
        margin: const EdgeInsets.only(bottom: 16),
        color: cardColor(state),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onLongPress: () {
              context.read<PostCubit>().selectPost(post.id);
            },
            onTap: () {
              context.read<PostCubit>().unSelectPost(post.id);
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
    });
  }

  Color cardColor(PostState state) {
    return state.selectedPostIds.any(
      (element) => element == post.id,
    )
        ? Colors.orangeAccent
        : Colors.white;
  }
}
