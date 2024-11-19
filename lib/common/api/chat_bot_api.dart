/*
 * @Email: cavanvip@gmail.com
 * @Github: https://github.com/cavanlee
 * @Description: 
 */

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:unitaapp/common/http/api_client.dart';

import '../models/message_model.dart';

/// ChatBotAPI for handling chatbot interactions
class ChatBotAPI {
  /// Chatbot Interaction
  static Future<Map<String, dynamic>> chatbotChat(String query, int userId) async {
    final parameters = {
      "query": query,
      "userId": userId,
    };
    try {
      final response = await ApiClient().post(
        '/chatbot/chat',
        data: parameters,
      );

      // Since the server always returns a String, wrap it in a Map
      if (response.data is String) {
        return {
          "status": 200, // Assuming success if we get a String
          "message": "Operation successful",
          "data": response.data, // The string returned by the server
        };
      } else {
        throw Exception("Unexpected response type: ${response.data.runtimeType}");
      }
    } catch (e) {
      throw Exception("Chatbot API Error: $e");
    }
  }
}