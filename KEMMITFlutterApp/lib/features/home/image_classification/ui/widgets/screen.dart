import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/features/home/image_classification/controller/image_classifier.dart';

class ImageClassificationScreen extends ConsumerWidget {
  const ImageClassificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatBotControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Image Classification")),
      body: Center(
        child: state.when(
          data: (_) => const Text("Image classified successfully!"),
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text("Error: $error"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(chatBotControllerProvider.notifier).chatBot();
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}
