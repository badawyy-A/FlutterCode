/*class ChatBotResponse {
  ChatBotResponse({
    this.name,
  });

  final String? name;

  factory ChatBotResponse.fromJson(Map<String, dynamic> json) {
    print("API Response: \$json");
    return ChatBotResponse(
     name: json["prediction"] ?? "Unknown",
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "file": name,
  //     };
}
*/

class ChatBotResponse {
  ChatBotResponse({
    this.name,
    this.description,
  });

  final String? name;
  final String? description;

  factory ChatBotResponse.fromJson(Map<String, dynamic> json) {
    print("API Response: $json");
    return ChatBotResponse(
      name: json["top_prediction"] ?? "Unknown",
      description: json["description"] ?? "No description available.",
    );
  }
}
