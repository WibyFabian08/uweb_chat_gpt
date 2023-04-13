import 'package:flutter/material.dart';
import 'package:uweb_gpt/constant/themes.dart';
import 'package:uweb_gpt/providers/active_theme_provider.dart';
import 'package:uweb_gpt/screens/chat_screen.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(activeThemeProvider);

    return MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode:
            themeProvider == Themes.dark ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: const ChatScreen());
  }
}
