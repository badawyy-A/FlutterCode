/*import 'dart:io';

class MessageAndImageModel {
  File image;
  String name;

  MessageAndImageModel({
    required this.image,
    required this.name,
    });
}
*/

import 'dart:io';

class MessageAndImageModel {
  File image;
  String name;
  String description; // Added description field

  MessageAndImageModel({
    required this.image,
    required this.name,
    required this.description, // Added this line
  });
}
