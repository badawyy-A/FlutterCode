class SignUpRequest {
  String? userName;
  String? email;
  String? password;
  String? firstName;
  String? lastName;

  SignUpRequest(
      {this.userName,
        this.email,
        this.password,
        this.firstName,
        this.lastName});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['email'] = email;
    data['password'] = password;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    return data;
  }
}
