import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/app/helpers/extensions.dart';
import 'package:shared/app/themes/app_spacing.dart';
import 'package:shared/core/presentation/widgets/shared_text_field.dart';
import 'package:shared/features/viewer/domain/bloc/post/post_bloc.dart';
import 'package:shared/features/viewer/domain/model/post.dart';
import 'package:shared/features/viewer/presentation/screens/post_details.dart';
import 'package:shared/features/viewer/presentation/widgets/empty_post.dart';
import 'package:shared/features/viewer/presentation/widgets/empty_post_details.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();
    final ValueNotifier<Post?> selectedPost = useState<Post?>(null);

    return AdaptiveLayout(
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.standard: SlotLayout.from(
            key: const Key('Post List'),
            builder: (_) => Column(
              children: <Widget>[
                SharedTextField(
                  padding: const EdgeInsets.all(Insets.small),
                  controller: controller,
                  labelText: context.commonL10n.post__search_bar__label,
                  prefixIcon: const Icon(Icons.search),
                  onChanged: (String value) =>
                      context.read<PostBloc>().onSearch(value),
                ),
                Expanded(
                  child: BlocBuilder<PostBloc, PostState>(
                    builder: (BuildContext context, PostState state) =>
                        state.maybeMap(
                      success: (PostSuccess state) => _HomeContent(
                        posts: controller.text.isNotNullOrBlank
                            ? state.filtered
                            : state.allPost,
                        selectedPost: selectedPost,
                      ),
                      orElse: CircularProgressIndicator.new,
                    ),
                  ),
                ),
              ],
            ),
          ),
        },
      ),
      secondaryBody: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('Post Details'),
            builder: (_) {
              if (selectedPost.value != null) {
                return PostDetails(post: selectedPost.value!);
              }
              return const EmptyPostDetails();
            },
          ),
        },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.posts,
    required this.selectedPost,
  });

  final List<Post> posts;
  final ValueNotifier<Post?> selectedPost;

  @override
  Widget build(BuildContext context) => posts.isNotEmpty
      ? ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final Post post = posts[index];

            return ListTile(
              onTap: () => _launchPostDetails(
                context,
                post,
                selectedPost,
              ),
              title: Text(
                post.character,
                style: context.textTheme.labelLarge
                    ?.copyWith(color: context.colorScheme.secondary),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const VSpace(Insets.small),
          itemCount: posts.length,
        )
      : const EmptyPost();

  Future<void> _launchPostDetails(
    BuildContext context,
    Post post,
    ValueNotifier<Post?> selectedPost,
  ) async {
    if (Breakpoints.mediumAndUp.isActive(context)) {
      if (selectedPost.value == post) {
        selectedPost.value = null;
      } else {
        selectedPost.value = post;
      }
    } else {
      await GoRouter.of(context).pushNamed(
        'postDetails',
        pathParameters: <String, String>{
          'character': post.character,
        },
        extra: post,
      );
    }
  }
}
