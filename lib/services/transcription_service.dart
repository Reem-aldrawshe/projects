import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class TranscriptionService {
  static const String apiKey = 'fa52de3c5c6540fe93420fed2fb4ee00';

  static final Dio dio = Dio(
    BaseOptions(
      headers: {
        'authorization': apiKey,
      },
    ),
  );

  static Future<String> uploadAndTranscribe(String filePath) async {
    final file = File(filePath);

    final uploadRes = await dio.post(
      'https://api.assemblyai.com/v2/upload',
      data: file.openRead(),
      options: Options(
        headers: {
          'transfer-encoding': 'chunked',
          'content-type': 'application/octet-stream',
        },
      ),
    );

    final uploadUrl = uploadRes.data['upload_url'];

    final transcriptRes = await dio.post(
      'https://api.assemblyai.com/v2/transcript',
      data: jsonEncode({'audio_url': uploadUrl , 'language_code': 'ar'}),
      options: Options(
        headers: {
          'content-type': 'application/json',
        },
      ),
    );

    final transcriptId = transcriptRes.data['id'];

    while (true) {
      final pollingRes = await dio.get(
        'https://api.assemblyai.com/v2/transcript/$transcriptId',
      );

      final status = pollingRes.data['status'];
      if (status == 'completed') {
        return pollingRes.data['text'];
      } else if (status == 'failed') {
        throw Exception("Transcription failed");
      }

      await Future.delayed(const Duration(seconds: 2));
    }
  }
}
