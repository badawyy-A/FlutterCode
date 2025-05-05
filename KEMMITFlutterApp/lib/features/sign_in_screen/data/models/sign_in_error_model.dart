class SignInErrorModel {
  String? message;

  SignInErrorModel({this.message});

  SignInErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
  String getAllErrorMessage() {
    return message ?? 'Unknown Error Occurred';
  }
}
