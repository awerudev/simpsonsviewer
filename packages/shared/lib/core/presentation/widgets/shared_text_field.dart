import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/app/helpers/extensions.dart';
import 'package:shared/app/themes/app_spacing.dart';

class SharedTextField extends StatelessWidget {
  const SharedTextField({
    required this.controller,
    required this.labelText,
    this.hintText,
    this.textInputAction,
    this.textInputType,
    this.onChanged,
    this.padding,
    this.isPassword = false,
    this.maxLength,
    this.autofocus = false,
    this.onSubmitted,
    this.focusNode,
    this.suffix,
    this.textAlign = TextAlign.left,
    this.contentPadding,
    this.style,
    this.hintTextStyle,
    this.decoration,
    this.prefixIcon,
    super.key,
  });

  final TextEditingController controller;
  final String? hintText;
  final bool isPassword;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final EdgeInsets? padding;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final bool autofocus;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final Widget? suffix;
  final TextAlign textAlign;
  final EdgeInsets? contentPadding;
  final TextStyle? style;
  final TextStyle? hintTextStyle;
  final InputDecoration? decoration;
  final String labelText;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final TextStyle? defaultTextStyle =
        context.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface);

    return Semantics(
      key: Key(labelText),
      textField: true,
      label: labelText,
      child: Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: Insets.medium),
        child: textInputType == TextInputType.visiblePassword || isPassword
            ? _PasswordTextField(
                controller: controller,
                onChanged: onChanged,
                autofocus: autofocus,
                onSubmitted: onSubmitted,
                textInputAction: textInputAction,
                focusNode: focusNode,
                hintText: hintText,
                labelText: labelText,
              )
            : TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: decoration ??
                    InputDecoration(
                      prefixIcon: prefixIcon,
                      labelText: labelText,
                      hintText: hintText,
                      hintStyle: hintTextStyle ?? defaultTextStyle,
                      contentPadding: contentPadding,
                      suffix: suffix,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorScheme.primary),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorScheme.secondary),
                      ),
                    ),
                keyboardType: textInputType,
                textInputAction: textInputAction,
                style: style ?? defaultTextStyle,
                textAlign: textAlign,
                autofocus: autofocus,
                maxLength: maxLength,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                buildCounter: (
                  _, {
                  int? currentLength,
                  int? maxLength,
                  bool? isFocused,
                }) =>
                    null,
              ),
      ),
    );
  }
}

class _PasswordTextField extends HookWidget {
  const _PasswordTextField({
    required this.hintText,
    required this.labelText,
    this.controller,
    this.onChanged,
    this.autofocus = false,
    this.onSubmitted,
    this.textInputAction,
    this.focusNode,
  });

  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final ValueChanged<String>? onSubmitted;
  final String? hintText;
  final String labelText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isPasswordHidden = useState<bool>(true);
    final ColorScheme colorScheme = context.colorScheme;
    final TextStyle? textStyle =
        context.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface);

    return Row(
      children: <Widget>[
        Expanded(
          child: Semantics(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                hintStyle: textStyle,
                suffixIcon: GestureDetector(
                  key: const Key('password_icon'),
                  onTap: () => isPasswordHidden.value = !isPasswordHidden.value,
                  child: Icon(
                    isPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.secondary),
                ),
              ),
              textInputAction: textInputAction,
              style: textStyle,
              textAlign: TextAlign.left,
              autofocus: autofocus,
              obscureText: isPasswordHidden.value,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          ),
        ),
      ],
    );
  }
}
