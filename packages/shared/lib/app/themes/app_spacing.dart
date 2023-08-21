import 'package:flutter/material.dart';

// ignore_for_file: prefer-match-file-name,prefer-single-widget-per-file,
// ignore_for_file: avoid-returning-widgets,prefer-correct-identifier-length
final class VSpace extends StatelessWidget {
  const VSpace(this.size, {super.key});

  factory VSpace.xxsmall() => const VSpace(Insets.xxsmall);
  factory VSpace.xsmall() => const VSpace(Insets.xsmall);
  factory VSpace.small() => const VSpace(Insets.small);
  factory VSpace.medium() => const VSpace(Insets.medium);
  factory VSpace.large() => const VSpace(Insets.large);
  factory VSpace.xlarge() => const VSpace(Insets.xlarge);
  factory VSpace.xxlarge() => const VSpace(Insets.xxlarge);
  factory VSpace.xxxlarge() => const VSpace(Insets.xxxlarge);

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(height: size);
}

final class HSpace extends StatelessWidget {
  const HSpace(this.size, {super.key});

  factory HSpace.xxsmall() => const HSpace(Insets.xxsmall);
  factory HSpace.xsmall() => const HSpace(Insets.xsmall);
  factory HSpace.small() => const HSpace(Insets.small);
  factory HSpace.medium() => const HSpace(Insets.medium);
  factory HSpace.large() => const HSpace(Insets.large);
  factory HSpace.xlarge() => const HSpace(Insets.xlarge);
  factory HSpace.xxlarge() => const HSpace(Insets.xxlarge);
  factory HSpace.xxxlarge() => const HSpace(Insets.xxxlarge);

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(width: size);
}

final class Insets {
  const Insets._();

  static const double scale = 1;

  // Regular paddings
  static const double zero = 0;
  static const double xxsmall = scale * 4;
  static const double xsmall = scale * 8;
  static const double small = scale * 12;
  static const double medium = scale * 16;
  static const double large = scale * 24;
  static const double xlarge = scale * 32;
  static const double xxlarge = scale * 48;
  static const double xxxlarge = scale * 64;
  static const double infinity = double.infinity;
}
