import 'package:flutter/material.dart';

class FavouriteSongs extends StatelessWidget {
  const FavouriteSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Favourite Songs"),
      ),
    );
  }
}
