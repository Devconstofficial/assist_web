import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class FullImageViewScreen extends StatelessWidget {
  final String imageUrl;

  const FullImageViewScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ImageNetwork(
            image: imageUrl,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.4,
            fitWeb: BoxFitWeb.cover,
            fitAndroidIos: BoxFit.cover,
            onLoading: const CircularProgressIndicator(strokeWidth: 2),
            onError: const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
