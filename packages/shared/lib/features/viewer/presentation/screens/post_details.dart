import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared/app/generated/assets.gen.dart';
import 'package:shared/app/helpers/extensions.dart';
import 'package:shared/app/themes/app_spacing.dart';
import 'package:shared/features/viewer/domain/model/post.dart';
import 'package:shared/features/viewer/domain/model/post_icon.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final ({double width, double height}) size = _getIconSize(post.icon);
    final Widget imagePlaceholder = Center(
      child: Assets.images.imagePlaceholder.image(
        width: size.width,
        height: size.height,
        fit: BoxFit.fill,
        package: 'shared',
      ),
    );

    return Center(
      child: Container(
        margin: const EdgeInsets.all(Insets.large),
        color: context.colorScheme.background,
        child: ListView(
          children: <Widget>[
            VSpace.large(),
            if (post.icon.url?.getOrCrash() != null)
              Center(
                child: CachedNetworkImage(
                  imageUrl: post.icon.url!.getOrCrash(),
                  imageBuilder: (
                    BuildContext context,
                    ImageProvider<Object> imageProvider,
                  ) =>
                      Container(
                    decoration: BoxDecoration(
                      color: context.colorScheme.onBackground,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                    width: size.width,
                    height: size.height,
                  ),
                  errorWidget:
                      (BuildContext context, String url, dynamic error) =>
                          imagePlaceholder,
                ),
              )
            else
              imagePlaceholder,
            VSpace.large(),
            Text(
              post.character,
              style: context.textTheme.headlineSmall
                  ?.copyWith(color: context.colorScheme.secondary),
            ),
            VSpace.large(),
            Text(
              post.description,
              style: context.textTheme.bodyLarge
                  ?.copyWith(color: context.colorScheme.secondary),
            ),
            VSpace.large(),
          ],
        ),
      ),
    );
  }

  ({double width, double height}) _getIconSize(PostIcon postIcon) {
    double width = postIcon.width.getOrCrash().toDouble();
    double height = postIcon.height.getOrCrash().toDouble();
    const double defaultSize = 300;
    if (width == 0) {
      width = defaultSize;
    }
    if (height == 0) {
      height = defaultSize;
    }

    return (width: width, height: height);
  }
}
