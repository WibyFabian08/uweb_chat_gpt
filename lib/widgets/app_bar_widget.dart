import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uweb_gpt/providers/active_theme_provider.dart';
import 'package:uweb_gpt/widgets/theme_switch_widget.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

class AppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(activeThemeProvider);

    return AppBar(
      title: Text("Uweb GPT",
          style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.onPrimary)),
      centerTitle: true,
      actions: [
        Consumer(
          builder: (context, ref, child) {
            return Icon(themeProvider == Themes.dark
                ? Icons.light_mode
                : Icons.dark_mode);
          },
        ),
        const ThemeSwitchWidget()
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
