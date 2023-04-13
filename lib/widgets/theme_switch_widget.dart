import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uweb_gpt/providers/active_theme_provider.dart';

class ThemeSwitchWidget extends ConsumerStatefulWidget {
  const ThemeSwitchWidget({super.key});

  @override
  ConsumerState<ThemeSwitchWidget> createState() => _ThemeSwitchWidgetState();
}

class _ThemeSwitchWidgetState extends ConsumerState<ThemeSwitchWidget> {
  void toggleTheme(bool value) {
    ref.read(activeThemeProvider.notifier).state =
        value ? Themes.dark : Themes.light;
  }

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      activeColor: Theme.of(context).colorScheme.onSecondary,
      value: ref.watch(activeThemeProvider) == Themes.dark,
      onChanged: (value) {
        toggleTheme(value);
      },
    );
  }
}
