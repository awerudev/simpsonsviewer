import 'package:flutter/material.dart';
import 'package:shared/app/helpers/extensions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    required this.appTitle,
    super.key,
  });

  final String appTitle;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colorScheme.background,
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Center(
                    child: Text(
                      appTitle,
                      textAlign: TextAlign.center,
                      style: context.textTheme.displayLarge
                          ?.copyWith(color: context.colorScheme.primary),
                    ),
                  ),
                ),
                const Flexible(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      );
}
