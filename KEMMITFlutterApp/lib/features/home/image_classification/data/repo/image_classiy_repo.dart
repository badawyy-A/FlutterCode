import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/features/home/image_classification/data/models/image_classification_response.dart';
import 'package:morshd/features/home/image_classification/data/services/api_result_chat.dart';
import 'package:morshd/features/home/image_classification/data/services/image_classification_services.dart';

class ChatBotRepo {
  final ChatBoServices _chatBoServices;

  ChatBotRepo(this._chatBoServices);

  Future<ApiResultChat<ChatBotResponse>> chatBot(File image) async {
    var response = await _chatBoServices.chatBot(FormData.fromMap({
      "file": await MultipartFile.fromFile(image.path),
    }));

    try {
       return ApiSuccessChat(response);
    } catch (failure) {
      return ApiFailureChat(failure.toString());
    }
  }
}

final chatBotRepoProvider = FutureProvider((ref) async {
  final chatBotServices = await ref.watch(chatBotServicesProvider.future);

  return ChatBotRepo(chatBotServices);
});

