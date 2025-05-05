import 'dart:io';
import 'dart:typed_data';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser botUser = ChatUser(
    id: "1",
    firstName: "Bot",
    profileImage:
        "assets/images/pharaoh.png",
  );

  final String apiUrl = 'http://localhost:5000//chat'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("assistant Tour Guide "),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(trailing: [
        IconButton(
          onPressed: _sendMediaMessage,
          icon: const Icon(Icons.image),
        )
      ]),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'text': chatMessage.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botReply = data['response']; // 👈 your API should return this field

        ChatMessage reply = ChatMessage(
          user: botUser,
          createdAt: DateTime.now(),
          text: botReply,
        );

        setState(() {
          messages = [reply, ...messages];
        });
      } else {
        _showError("Error: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Failed to connect to API");
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe this picture?",
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          )
        ],
      );
      _sendMessage(chatMessage);
    }
  }

  void _showError(String message) {
    ChatMessage errorMsg = ChatMessage(
      user: botUser,
      createdAt: DateTime.now(),
      text: message,
    );

    setState(() {
      messages = [errorMsg, ...messages];
    });
  }
}
