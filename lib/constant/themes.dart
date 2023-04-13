import "package:flutter/material.dart";

final lightTheme = ThemeData(
        colorScheme: ThemeData.light().colorScheme.copyWith(
          primary: Colors.amber,
          onPrimary: Colors.white,
          secondary: Colors.deepPurple,
          onSecondary: Colors.amber
        )
      );

final darkTheme = ThemeData(
        colorScheme: ThemeData.dark().colorScheme.copyWith(
          primary: Colors.blueGrey,
          onPrimary: Colors.white,
          secondary: Colors.blueGrey,
          onSecondary: Colors.white
        )
      );