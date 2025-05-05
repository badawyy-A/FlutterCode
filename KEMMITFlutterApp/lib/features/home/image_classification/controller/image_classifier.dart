import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/features/home/image_classification/data/models/message_and_image_model.dart';
import 'package:morshd/features/home/image_classification/data/repo/image_classiy_repo.dart';

class ImageClassification extends AsyncNotifier<void> {
  File? image;
  List<MessageAndImageModel> dataAndImage = [];

  @override
  FutureOr<void> build() {
    // This function is required by AsyncNotifier but isn't needed for this use case
  }

  Future<void> chatBot() async {
    if (image == null) {
      state = AsyncValue.error("No image selected", StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();

    try {
      final response = await ref.read(chatBotRepoProvider.future);
      var result = await response.chatBot(File(image!.path));
      result.when(
        success: (data) {
          dataAndImage.add(
            MessageAndImageModel(
              name: data.name.toString(),
              description: data.description.toString(), // Add description
              image: File(image!.path),
            ),
          );
          state = AsyncValue.data(null); // Updating state after success
        },
        failure: (failure) {
          state = AsyncValue.error(failure, StackTrace.current);
        },
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final chatBotControllerProvider =
    AsyncNotifierProvider<ImageClassification, void>(
  ImageClassification.new,
);
