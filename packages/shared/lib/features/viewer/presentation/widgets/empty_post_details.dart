import 'package:flutter/material.dart';
import 'package:shared/app/helpers/extensions.dart';
import 'package:shared/app/themes/app_spacing.dart';

class EmptyPostDetails extends StatelessWidget {
  const EmptyPostDetails({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: Insets.large),
        color: context.colorScheme.background,
        width: Insets.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.account_box_rounded,
                size: 200,
                color: context.colorScheme.onBackground.withOpacity(0.25),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: Insets.small,
                  bottom: Insets.xsmall,
                ),
                child: Text(
                  context.commonL10n.post__empty_post_details__message,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.onBackground.withOpacity(0.25),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
}
