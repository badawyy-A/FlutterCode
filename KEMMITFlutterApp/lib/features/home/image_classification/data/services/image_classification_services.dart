import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/core/networking/dio_factory.dart';
import 'package:morshd/features/home/image_classification/data/models/image_classification_response.dart';

class ChatBoServices {
  final Dio _dio;

  ChatBoServices(this._dio);

  Future<ChatBotResponse> chatBot(FormData formData) async {
    final response = await _dio.post(
      'http://localhost:5000//upload-image',
      data: formData,
    );
    // final data=jsonDecode(response.data) ;
    // print(data['top_prediction']);

    return ChatBotResponse.fromJson(response.data);
  }
}

final chatBotServicesProvider = FutureProvider(
  (ref) async {
    Dio dio = await DioFactory.getDio();
    return ChatBoServices(dio);
  },
);
